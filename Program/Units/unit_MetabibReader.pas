(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Oleksiy Penkov  oleksiy.penkov@gmail.com
  * Created             22.08.2026
  * Description         Читач каталогів metabib (JSON Lines: заголовок
  *                     metabib.dataset/1 + записи metabib.dataset_record/1).
  *                     Контейнери: .jsonl, .jsonl.zst, .jsonl.gz, .zip
  *
  ****************************************************************************** *)

unit unit_MetabibReader;

interface

uses
  SysUtils,
  Classes,
  Generics.Collections;

type
  TMetabibPerson = record
    LastName: string;
    FirstName: string;
    MiddleName: string;
    NickName: string;
  end;

  TMetabibBook = record
    BookID: Int64;
    LocatorKind: string;
    HasArtifact: Boolean;
    ArchiveID: string;
    EntryName: string;
    EntryIndex: Integer;
    UncompressedSize: Integer;
    Title: string;
    BookName: string;
    Authors: TArray<TMetabibPerson>;
    Translators: TArray<TMetabibPerson>;
    Genres: TArray<string>;
    SeriesName: string;
    SeriesNo: Integer;
    Lang: string;
    Annotation: string;
    Keywords: string;
    Publisher: string;
    City: string;
    ISBN: string;
    PubYear: Integer;
    Deleted: Boolean;
    RatingAvg: Double;
    Stamp: TDateTime;
  end;

  TMetabibReadResult = (mrOk, mrEof, mrBadLine);

  EMetabibError = class(Exception);

  TMetabibReader = class
  private
    FBase: TStream;          // file or memory stream (owned)
    FDecoded: TStream;       // decompression wrapper or = FBase (owned unless = FBase)
    FInBuf: TBytes;
    FInLen: Integer;
    FInPos: Integer;
    FPending: TBytes;
    FEof: Boolean;
    FFirstLine: Boolean;
    FArchives: TDictionary<string, string>; // id -> archive file name
    FLibraryName: string;
    FRecordCount: Integer;
    FLineNo: Integer;
    procedure OpenContainer(const FileName: string);
    function ReadRawLine(out Line: string): Boolean;
    procedure ReadHeader;
  public
    constructor Create(const FileName: string);
    destructor Destroy; override;

    function ReadNext(out Book: TMetabibBook): TMetabibReadResult;
    function ArchiveName(const ArchiveID: string): string;

    class function IsDatasetFile(const FileName: string): Boolean;

    property LibraryName: string read FLibraryName;
    property RecordCount: Integer read FRecordCount;
    property LineNo: Integer read FLineNo;
  end;

implementation

uses
  IOUtils,
  DateUtils,
  StrUtils,
  Character,
  System.JSON,
  ZLib,
  unit_ZstdStream,
  unit_MHLArchiveHelpers;

resourcestring
  rstrNotMetabibDataset = 'Файл не є каталогом metabib (очікували metabib.dataset/1): %s';
  rstrNoJsonlInZip = 'У zip-архіві немає файлу *.jsonl: %s';

const
  DATASET_SCHEMA = 'metabib.dataset/1';
  RECORD_SCHEMA = 'metabib.dataset_record/1';

  // Аннотація: спершу та, що лежить у самій книзі, і лише потім база
  // бібліотеки -- у libbannotations трапляються чужі й службові тексти.
  ANNOTATION_SOURCES: array [0 .. 2] of string = ('fb2', 'fbd', 'db');

  // Каталожні поля (автори, перекладачі, назва, серія) -- навпаки: база
  // бібліотеки первинна, а FB2 буває битим (U+FFFD замість імен).
  CATALOG_SOURCES: array [0 .. 2] of string = ('db', 'fb2', 'fbd');

// ---------------------------------------------------------------------------
// Допоміжні розбори "claim array": кожне поле claims - масив
// {observation, value, raw}; value буває скаляром або масивом.
// ---------------------------------------------------------------------------

function ClaimValues(Group: TJSONObject; const Field: string): TArray<TJSONValue>;
var
  arr: TJSONArray;
  item, v, el: TJSONValue;
  list: TList<TJSONValue>;
begin
  Result := nil;
  if not Assigned(Group) then
    Exit;
  if not (Group.Values[Field] is TJSONArray) then
    Exit;
  arr := TJSONArray(Group.Values[Field]);

  list := TList<TJSONValue>.Create;
  try
    for item in arr do
    begin
      if not (item is TJSONObject) then
        Continue;
      v := TJSONObject(item).Values['value'];
      if not Assigned(v) or (v is TJSONNull) then
        Continue;
      if v is TJSONArray then
      begin
        for el in TJSONArray(v) do
          if not (el is TJSONNull) then
            list.Add(el);
      end
      else
        list.Add(v);
    end;
    Result := list.ToArray;
  finally
    list.Free;
  end;
end;

// A value is usable when it has at least one letter or digit. Empty and blank
// values are a source with nothing to say; values made of nothing but
// punctuation or U+FFFD replacement characters are what a corrupted FB2 leaves
// behind ("()", "- -", "������"), and taking one would hide a good claim from
// another source. Surrogates pass: a name written entirely outside the BMP is
// rare but real, and U+FFFD is never one.
function IsUsableText(const S: string): Boolean;
var
  ch: Char;
begin
  for ch in S do
    if ch.IsLetterOrDigit or ch.IsSurrogate then
      Exit(True);
  Result := False;
end;

// Decodes the HTML entities that leak into names from the library database
// ("&quot;", "&#34;", "&#x2014;"). Anything that does not parse as an entity is
// left as it is.
function DecodeEntities(const S: string): string;
var
  i, j, code: Integer;
  name: string;
  sb: TStringBuilder;
begin
  if Pos('&', S) = 0 then
    Exit(S);

  sb := TStringBuilder.Create(Length(S));
  try
    i := 1;
    while i <= Length(S) do
    begin
      if S[i] = '&' then
      begin
        j := i + 1;
        while (j <= Length(S)) and (j - i <= 10) and (S[j] <> ';') and (S[j] <> '&') do
          Inc(j);
        if (j <= Length(S)) and (S[j] = ';') then
        begin
          name := Copy(S, i + 1, j - i - 1);
          code := -1;
          if (Length(name) > 1) and (name[1] = '#') then
          begin
            if CharInSet(name[2], ['x', 'X']) then
              code := StrToIntDef('$' + Copy(name, 3, MaxInt), -1)
            else
              code := StrToIntDef(Copy(name, 2, MaxInt), -1);
          end
          else if name = 'amp' then
            code := Ord('&')
          else if name = 'quot' then
            code := Ord('"')
          else if name = 'apos' then
            code := Ord('''')
          else if name = 'lt' then
            code := Ord('<')
          else if name = 'gt' then
            code := Ord('>')
          else if name = 'nbsp' then
            code := Ord(' ');

          if (code > 0) and (code <= $10FFFF) and ((code < $D800) or (code > $DFFF)) then
          begin
            sb.Append(Char.ConvertFromUtf32(code));
            i := j + 1;
            Continue;
          end;
        end;
      end;
      sb.Append(S[i]);
      Inc(i);
    end;
    Result := sb.ToString;
  finally
    sb.Free;
  end;
end;

// Claims of a field in the order the consumer trusts them: those whose
// observation is in Order, source by source, then everything else in the order
// metabib wrote it. The merge step deliberately picks no winner between
// sources -- it tags each claim with an "observation" ("db", "fb2", "fbd") and
// leaves the choice to the consumer -- so the preference is spelled out here
// rather than read off the array. A claim from a source outside Order (or one
// with no observation at all) is still better than an empty field, which is why
// it stays in the list as a last resort.
function ClaimsInOrder(Group: TJSONObject; const Field: string;
  const Order: array of string): TArray<TJSONObject>;
var
  arr: TJSONArray;
  obs: TJSONValue;
  used: TArray<Boolean>;
  list: TList<TJSONObject>;
  i, j: Integer;
begin
  Result := nil;
  if not Assigned(Group) or not (Group.Values[Field] is TJSONArray) then
    Exit;
  arr := TJSONArray(Group.Values[Field]);
  SetLength(used, arr.Count);

  list := TList<TJSONObject>.Create;
  try
    for i := Low(Order) to High(Order) do
      for j := 0 to arr.Count - 1 do
        if not used[j] and (arr.Items[j] is TJSONObject) then
        begin
          obs := TJSONObject(arr.Items[j]).Values['observation'];
          if (obs is TJSONString) and SameText(TJSONString(obs).Value, Order[i]) then
          begin
            used[j] := True;
            list.Add(TJSONObject(arr.Items[j]));
          end;
        end;

    for j := 0 to arr.Count - 1 do
      if not used[j] and (arr.Items[j] is TJSONObject) then
        list.Add(TJSONObject(arr.Items[j]));

    Result := list.ToArray;
  finally
    list.Free;
  end;
end;

// "First usable value", tried source by source. A source that simply had
// nothing to say still contributes a claim with an empty value, and a corrupted
// FB2 contributes one full of replacement characters; stopping at either would
// discard a populated claim sitting right behind it -- a book with no FB2
// annotation but a database one would import with no annotation at all.
//
// The value itself is returned unmodified. Only the decision to skip is made
// on it, so nothing rewrites text on its way into a collection.
function ClaimStringByObservation(Group: TJSONObject; const Field: string;
  const Order: array of string): string;
var
  claim: TJSONObject;
  v, el: TJSONValue;
begin
  Result := '';
  for claim in ClaimsInOrder(Group, Field, Order) do
  begin
    v := claim.Values['value'];
    if v is TJSONArray then
    begin
      for el in TJSONArray(v) do
        if (el is TJSONString) and IsUsableText(TJSONString(el).Value) then
          Exit(TJSONString(el).Value);
    end
    else if (v is TJSONString) and IsUsableText(TJSONString(v).Value) then
      Exit(TJSONString(v).Value);
  end;
end;

// Same rule for fields where no source is preferred: claims in array order.
function FirstClaimString(Group: TJSONObject; const Field: string): string;
begin
  Result := ClaimStringByObservation(Group, Field, []);
end;

function FirstClaimInt(Group: TJSONObject; const Field: string; Def: Integer): Integer;
var
  v: TJSONValue;
  s: string;
  i: Integer;
begin
  Result := Def;
  for v in ClaimValues(Group, Field) do
  begin
    if v is TJSONNumber then
      Exit(TJSONNumber(v).AsInt);
    if v is TJSONString then
    begin
      // рік інколи приходить рядком на кшталт "2005" чи "2005-2006"
      s := TJSONString(v).Value;
      i := 1;
      while (i <= Length(s)) and CharInSet(s[i], ['0' .. '9']) do
        Inc(i);
      if i > 1 then
        Exit(StrToIntDef(Copy(s, 1, i - 1), Def));
    end;
  end;
end;

function FirstClaimBool(Group: TJSONObject; const Field: string): Boolean;
var
  v: TJSONValue;
begin
  Result := False;
  for v in ClaimValues(Group, Field) do
  begin
    if v is TJSONBool then
      Exit(TJSONBool(v).AsBoolean);
    if v is TJSONNumber then
      Exit(TJSONNumber(v).AsInt <> 0);
    // Same rule as FirstClaimString: an empty string is a source with nothing
    // to say, not a claim that the flag is False.
    if (v is TJSONString) and (Trim(TJSONString(v).Value) <> '') then
      Exit(MatchText(TJSONString(v).Value, ['1', 'true', 'yes']));
  end;
end;

function FirstClaimFloat(Group: TJSONObject; const Field, SubField: string): Double;
var
  v, sub: TJSONValue;
begin
  Result := 0;
  for v in ClaimValues(Group, Field) do
    if v is TJSONObject then
    begin
      sub := TJSONObject(v).Values[SubField];
      if sub is TJSONNumber then
        Exit(TJSONNumber(sub).AsDouble);
    end;
end;

// The person list of ONE source, the first in Order that names anybody usable.
// Lists are never merged across sources: each source lists the same people, so
// merging put every author on a book twice, turned a spelling difference
// ("Татьяна О." / "Татьяна Олеговна") into a second person, and let a corrupted
// FB2 name ride along next to the good database one.
//
// Names are trimmed and entity-decoded, a name part with no letter or digit is
// dropped, and a person left with no name at all is skipped.
function ClaimPersons(Group: TJSONObject; const Field: string;
  const Order: array of string): TArray<TMetabibPerson>;
var
  list: TList<TMetabibPerson>;
  claim: TJSONObject;
  v, el: TJSONValue;

  function CleanName(o: TJSONObject; const Name: string): string;
  var
    fv: TJSONValue;
  begin
    Result := '';
    fv := o.Values[Name];
    if fv is TJSONString then
    begin
      Result := Trim(DecodeEntities(TJSONString(fv).Value));
      if not IsUsableText(Result) then
        Result := '';
    end;
  end;

  procedure AddPerson(o: TJSONObject);
  var
    p, q: TMetabibPerson;
  begin
    p.LastName := CleanName(o, 'last_name');
    p.FirstName := CleanName(o, 'first_name');
    p.MiddleName := CleanName(o, 'middle_name');
    p.NickName := CleanName(o, 'nick_name');
    if (p.LastName = '') and (p.FirstName = '') and (p.NickName = '') then
      Exit;

    for q in list do
      if SameText(q.LastName, p.LastName) and SameText(q.FirstName, p.FirstName) and
        SameText(q.MiddleName, p.MiddleName) and SameText(q.NickName, p.NickName) then
        Exit;

    list.Add(p);
  end;

begin
  list := TList<TMetabibPerson>.Create;
  try
    for claim in ClaimsInOrder(Group, Field, Order) do
    begin
      v := claim.Values['value'];
      if v is TJSONArray then
      begin
        for el in TJSONArray(v) do
          if el is TJSONObject then
            AddPerson(TJSONObject(el));
      end
      else if v is TJSONObject then
        AddPerson(TJSONObject(v));

      if list.Count > 0 then
        Break;
    end;
    Result := list.ToArray;
  finally
    list.Free;
  end;
end;

function ClaimStrings(Group: TJSONObject; const Field: string): TArray<string>;
var
  v: TJSONValue;
  list: TList<string>;
begin
  list := TList<string>.Create;
  try
    for v in ClaimValues(Group, Field) do
      if (v is TJSONString) and (TJSONString(v).Value <> '') then
        list.Add(TJSONString(v).Value);
    Result := list.ToArray;
  finally
    list.Free;
  end;
end;

function ObjValue(Parent: TJSONObject; const Name: string): TJSONObject;
var
  v: TJSONValue;
begin
  Result := nil;
  if not Assigned(Parent) then
    Exit;
  v := Parent.Values[Name];
  if v is TJSONObject then
    Result := TJSONObject(v);
end;

function StrValue(Parent: TJSONObject; const Name: string): string;
var
  v: TJSONValue;
begin
  Result := '';
  if not Assigned(Parent) then
    Exit;
  v := Parent.Values[Name];
  if v is TJSONString then
    Result := TJSONString(v).Value;
end;

function IntValue(Parent: TJSONObject; const Name: string; Def: Int64): Int64;
var
  v: TJSONValue;
begin
  Result := Def;
  if not Assigned(Parent) then
    Exit;
  v := Parent.Values[Name];
  if v is TJSONNumber then
    Result := TJSONNumber(v).AsInt64;
end;

function JSONToInt64(v: TJSONValue): Int64;
begin
  if v is TJSONNumber then
    Result := TJSONNumber(v).AsInt64
  else if v is TJSONString then
    Result := StrToInt64Def(Trim(TJSONString(v).Value), 0)
  else
    Result := 0;
end;

// The first sequence with a usable name, sources tried in Order. The number is
// a plain JSON number in older dumps and {"value": n} in the database claims of
// metabib 2.1.0; reading only the former lost every database series number.
procedure ClaimSequence(Group: TJSONObject; const Order: array of string;
  out Name: string; out Number: Integer);
var
  claim: TJSONObject;
  v, el: TJSONValue;

  function TryTake(Item: TJSONValue): Boolean;
  var
    nv: TJSONValue;
  begin
    Result := False;
    if not (Item is TJSONObject) then
      Exit;
    Name := Trim(StrValue(TJSONObject(Item), 'name'));
    if not IsUsableText(Name) then
    begin
      Name := '';
      Exit;
    end;
    nv := TJSONObject(Item).Values['number'];
    if nv is TJSONObject then
      nv := TJSONObject(nv).Values['value'];
    Number := Integer(JSONToInt64(nv));
    Result := True;
  end;

begin
  Name := '';
  Number := 0;
  for claim in ClaimsInOrder(Group, 'sequences', Order) do
  begin
    v := claim.Values['value'];
    if v is TJSONArray then
    begin
      for el in TJSONArray(v) do
        if TryTake(el) then
          Exit;
    end
    else if TryTake(v) then
      Exit;
  end;
end;

// Catalog book id from identities.catalog[] for one observation. The scheme is
// "<library>.book" -- "flibusta.book" in real dumps.
function CatalogIdentity(Obj: TJSONObject; const Scheme, Observation: string): Int64;
var
  item: TJSONValue;
  id: TJSONObject;
begin
  Result := 0;
  id := ObjValue(Obj, 'identities');
  if not Assigned(id) or not (id.Values['catalog'] is TJSONArray) then
    Exit;
  for item in TJSONArray(id.Values['catalog']) do
    if (item is TJSONObject) and
      SameText(StrValue(TJSONObject(item), 'scheme'), Scheme) and
      SameText(StrValue(TJSONObject(item), 'observation'), Observation) then
    begin
      Result := JSONToInt64(TJSONObject(item).Values['value']);
      if Result > 0 then
        Exit;
    end;
end;

function PresentObservationBookID(Obj: TJSONObject; const Observation: string): Int64;
var
  item: TJSONValue;
  o, loc: TJSONObject;
begin
  Result := 0;
  if not (Obj.Values['observations'] is TJSONArray) then
    Exit;
  for item in TJSONArray(Obj.Values['observations']) do
    if item is TJSONObject then
    begin
      o := TJSONObject(item);
      if SameText(StrValue(o, 'id'), Observation) and
        SameText(StrValue(o, 'status'), 'present') then
      begin
        loc := ObjValue(o, 'locator');
        if Assigned(loc) then
          Result := JSONToInt64(loc.Values['book_id']);
        if Result > 0 then
          Exit;
      end;
    end;
end;

// Only a "database_book" locator carries book_id. Since metabib 2.1.0 an
// "archive_entry" locator is a physical position (source + index) and the id
// lives in identities.catalog. The preference is spelled out rather than taken
// from array order: the database id is authoritative, the archive one is merely
// guessed from a numeric entry name and may disagree with the database match.
function ResolveBookID(Obj, Locator: TJSONObject; const LibraryName: string): Int64;
var
  Scheme: string;
begin
  Result := IntValue(Locator, 'book_id', 0);
  if Result > 0 then
    Exit;

  Scheme := LibraryName + '.book';
  Result := CatalogIdentity(Obj, Scheme, 'db');
  if Result > 0 then
    Exit;
  Result := PresentObservationBookID(Obj, 'db');
  if Result > 0 then
    Exit;
  Result := CatalogIdentity(Obj, Scheme, 'archive');
end;

{ TMetabibReader }

class function TMetabibReader.IsDatasetFile(const FileName: string): Boolean;
var
  Ext: string;
  Zip: TMHLZip;
  i: Integer;
begin
  Ext := LowerCase(ExtractFileExt(FileName));

  if (Ext = '.zst') or (Ext = '.gz') then
    Exit(SameText(ExtractFileExt(ChangeFileExt(FileName, '')), '.jsonl'));

  if Ext = '.jsonl' then
    Exit(True);

  if Ext = '.zip' then
  begin
    // zip буває і INPX-подібним архівом: каталог metabib пізнаємо
    // за членом *.jsonl (INPX має structure.info та *.inp)
    try
      Zip := TMHLZip.Create(FileName, True);
      try
        for i := 0 to Zip.FileCount - 1 do
          if SameText(ExtractFileExt(Zip.FileNames[i]), '.jsonl') then
            Exit(True);
      finally
        FreeAndNil(Zip);
      end;
    except
      // не zip / зіпсований - хай далі розбирається штатний імпорт
    end;
  end;

  Result := False;
end;

procedure TMetabibReader.OpenContainer(const FileName: string);
var
  Ext: string;
  Zip: TMHLZip;
  i: Integer;
  Mem: TMemoryStream;
  Found: Boolean;
begin
  Ext := LowerCase(ExtractFileExt(FileName));

  if Ext = '.zip' then
  begin
    Found := False;
    Zip := TMHLZip.Create(FileName, True);
    try
      for i := 0 to Zip.FileCount - 1 do
        if SameText(ExtractFileExt(Zip.FileNames[i]), '.jsonl') then
        begin
          Mem := TMemoryStream.Create;
          FBase := Mem;
          Zip.ExtractToStream(Zip.FileNames[i], Mem);
          Mem.Seek(0, soBeginning);
          Found := True;
          Break;
        end;
    finally
      FreeAndNil(Zip);
    end;
    if not Found then
      raise EMetabibError.CreateFmt(rstrNoJsonlInZip, [FileName]);
    FDecoded := FBase;
  end
  else
  begin
    FBase := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    if Ext = '.zst' then
      FDecoded := TZstdDecompressionStream.Create(FBase, False)
    else if Ext = '.gz' then
      FDecoded := TZDecompressionStream.Create(FBase, 15 + 32) // 15+32: авто zlib/gzip
    else
      FDecoded := FBase;
  end;
end;

//
// Читає один рядок, лише рухаючись вперед: TStreamReader тут не годиться,
// бо на межі буфера він відмотує потік назад, а zstd-потік Seek не має.
//
function TMetabibReader.ReadRawLine(out Line: string): Boolean;
var
  i, OldLen, Chunk: Integer;

  procedure EmitPending;
  begin
    if (Length(FPending) > 0) and (FPending[High(FPending)] = 13) then
      SetLength(FPending, Length(FPending) - 1);
    if FFirstLine and (Length(FPending) >= 3) and (FPending[0] = $EF) and
      (FPending[1] = $BB) and (FPending[2] = $BF) then
      FPending := Copy(FPending, 3, Length(FPending) - 3); // BOM, якщо каталог створили з ним
    try
      Line := TEncoding.UTF8.GetString(FPending);
    except
      on EEncodingError do
        Line := '{'; // свідомо биті байти -> хай піде шляхом mrBadLine
    end;
    FFirstLine := False;
  end;

begin
  SetLength(FPending, 0);
  while True do
  begin
    if FInPos >= FInLen then
    begin
      if FEof then
        Break;
      if Length(FInBuf) = 0 then
        SetLength(FInBuf, 64 * 1024);
      FInLen := FDecoded.Read(FInBuf[0], Length(FInBuf));
      FInPos := 0;
      if FInLen <= 0 then
      begin
        FEof := True;
        Break;
      end;
    end;

    i := FInPos;
    while (i < FInLen) and (FInBuf[i] <> 10) do
      Inc(i);

    Chunk := i - FInPos;
    if Chunk > 0 then
    begin
      OldLen := Length(FPending);
      SetLength(FPending, OldLen + Chunk);
      Move(FInBuf[FInPos], FPending[OldLen], Chunk);
    end;

    if i < FInLen then
    begin
      FInPos := i + 1; // пропускаємо LF
      EmitPending;
      Exit(True);
    end;

    FInPos := FInLen; // рядок продовжується в наступному буфері
  end;

  if Length(FPending) > 0 then
  begin
    EmitPending;
    Exit(True);
  end;

  Line := '';
  Result := False;
end;

procedure TMetabibReader.ReadHeader;
var
  Line: string;
  Root: TJSONValue;
  Obj, ArchObj: TJSONObject;
  Archives: TJSONArray;
  v: TJSONValue;
begin
  if not ReadRawLine(Line) then
    raise EMetabibError.CreateFmt(rstrNotMetabibDataset, ['(порожній файл)']);
  Inc(FLineNo);

  Root := TJSONObject.ParseJSONValue(Line);
  try
    if not (Root is TJSONObject) then
      raise EMetabibError.CreateFmt(rstrNotMetabibDataset, ['(не JSON)']);
    Obj := TJSONObject(Root);

    if (StrValue(Obj, 'schema') <> DATASET_SCHEMA) or
      (StrValue(Obj, 'record_schema') <> RECORD_SCHEMA) then
      raise EMetabibError.CreateFmt(rstrNotMetabibDataset, [StrValue(Obj, 'schema')]);

    FLibraryName := StrValue(Obj, 'library');
    FRecordCount := IntValue(Obj, 'records', 0);

    if Obj.Values['archives'] is TJSONArray then
    begin
      Archives := TJSONArray(Obj.Values['archives']);
      for v in Archives do
        if v is TJSONObject then
        begin
          ArchObj := TJSONObject(v);
          FArchives.AddOrSetValue(StrValue(ArchObj, 'id'), StrValue(ArchObj, 'name'));
        end;
    end;
  finally
    Root.Free;
  end;
end;

constructor TMetabibReader.Create(const FileName: string);
begin
  inherited Create;
  FArchives := TDictionary<string, string>.Create;
  FFirstLine := True;
  try
    OpenContainer(FileName);
    ReadHeader;
  except
    if FDecoded <> FBase then
      FreeAndNil(FDecoded);
    FreeAndNil(FBase);
    FreeAndNil(FArchives);
    raise;
  end;
end;

destructor TMetabibReader.Destroy;
begin
  if FDecoded <> FBase then
    FreeAndNil(FDecoded);
  FreeAndNil(FBase);
  FreeAndNil(FArchives);
  inherited Destroy;
end;

function TMetabibReader.ArchiveName(const ArchiveID: string): string;
begin
  if not FArchives.TryGetValue(ArchiveID, Result) then
    Result := '';
end;

function TMetabibReader.ReadNext(out Book: TMetabibBook): TMetabibReadResult;
var
  Line: string;
  Root: TJSONValue;
  Obj, RecObj, Locator, Claims, Bib, Pub, Cat: TJSONObject;
  Artifacts, Occurrences: TJSONArray;
  vArt, vOcc: TJSONValue;
  Occ, Chosen, FirstOcc: TJSONObject;
  StampStr, LibName: string;
  dt: TDateTime;
begin
  Book := Default (TMetabibBook);

  repeat
    if not ReadRawLine(Line) then
      Exit(mrEof);
    Inc(FLineNo);
  until Trim(Line) <> '';

  Root := TJSONObject.ParseJSONValue(Line);
  try
    if not (Root is TJSONObject) then
      Exit(mrBadLine);
    Obj := TJSONObject(Root);
    if StrValue(Obj, 'schema') <> RECORD_SCHEMA then
      Exit(mrBadLine);

    // ------ локатор
    RecObj := ObjValue(Obj, 'record');
    Locator := ObjValue(RecObj, 'locator');
    Book.LocatorKind := StrValue(Locator, 'kind');
    LibName := StrValue(RecObj, 'library');
    if LibName = '' then
      LibName := FLibraryName;
    Book.BookID := ResolveBookID(Obj, Locator, LibName);

    // ------ артефакт: віддаємо перевагу входженню, на яке вказує локатор
    Chosen := nil;
    FirstOcc := nil;
    if Obj.Values['artifacts'] is TJSONArray then
    begin
      Artifacts := TJSONArray(Obj.Values['artifacts']);
      for vArt in Artifacts do
      begin
        if not (vArt is TJSONObject) then
          Continue;
        if not (TJSONObject(vArt).Values['occurrences'] is TJSONArray) then
          Continue;
        Occurrences := TJSONArray(TJSONObject(vArt).Values['occurrences']);
        for vOcc in Occurrences do
        begin
          if not (vOcc is TJSONObject) then
            Continue;
          Occ := TJSONObject(vOcc);
          if not Assigned(FirstOcc) then
            FirstOcc := Occ;
          if (Book.LocatorKind = 'archive_entry') and
            (StrValue(Occ, 'archive') = StrValue(Locator, 'source')) and
            (IntValue(Occ, 'index', -1) = IntValue(Locator, 'index', -2)) then
          begin
            Chosen := Occ;
            Break;
          end;
        end;
        if Assigned(Chosen) then
          Break;
      end;
    end;
    if not Assigned(Chosen) then
      Chosen := FirstOcc;

    if Assigned(Chosen) then
    begin
      Book.HasArtifact := True;
      Book.ArchiveID := StrValue(Chosen, 'archive');
      Book.EntryName := StrValue(Chosen, 'entry');
      Book.EntryIndex := IntValue(Chosen, 'index', 0);
      Book.UncompressedSize := IntValue(Chosen, 'uncompressed_size', 0);
    end;

    // ------ claims
    Claims := ObjValue(Obj, 'claims');
    Bib := ObjValue(Claims, 'bibliographic');
    Pub := ObjValue(Claims, 'publication');
    Cat := ObjValue(Claims, 'catalog');

    Book.Title := ClaimStringByObservation(Bib, 'title', CATALOG_SOURCES);
    Book.BookName := FirstClaimString(Pub, 'book_name');
    Book.Authors := ClaimPersons(Bib, 'authors', CATALOG_SOURCES);
    Book.Translators := ClaimPersons(Bib, 'translators', CATALOG_SOURCES);
    Book.Genres := ClaimStrings(Bib, 'genres');
    Book.Lang := FirstClaimString(Bib, 'language');
    Book.Annotation := ClaimStringByObservation(Bib, 'annotation',
      ANNOTATION_SOURCES);
    Book.Keywords := FirstClaimString(Bib, 'keywords');

    ClaimSequence(Bib, CATALOG_SOURCES, Book.SeriesName, Book.SeriesNo);

    Book.Publisher := FirstClaimString(Pub, 'publisher');
    Book.City := FirstClaimString(Pub, 'city');
    Book.ISBN := FirstClaimString(Pub, 'isbn');
    Book.PubYear := FirstClaimInt(Pub, 'year', 0);

    Book.Deleted := FirstClaimBool(Cat, 'deleted');
    Book.RatingAvg := FirstClaimFloat(Cat, 'rating', 'average');

    StampStr := FirstClaimString(Cat, 'modified');
    if StampStr = '' then
      StampStr := FirstClaimString(Cat, 'time');
    if (StampStr <> '') and TryISO8601ToDate(StampStr, dt, True) then
      Book.Stamp := dt;

    Result := mrOk;
  finally
    Root.Free;
  end;
end;

end.
