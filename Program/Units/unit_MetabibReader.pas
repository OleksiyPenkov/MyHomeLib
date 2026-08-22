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
    FReader: TStreamReader;
    FArchives: TDictionary<string, string>; // id -> archive file name
    FLibraryName: string;
    FRecordCount: Integer;
    FLineNo: Integer;
    procedure OpenContainer(const FileName: string);
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

function FirstClaimString(Group: TJSONObject; const Field: string): string;
var
  v: TJSONValue;
begin
  Result := '';
  for v in ClaimValues(Group, Field) do
    if v is TJSONString then
      Exit(TJSONString(v).Value);
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
    if v is TJSONString then
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

function ClaimPersons(Group: TJSONObject; const Field: string): TArray<TMetabibPerson>;
var
  v: TJSONValue;
  o: TJSONObject;
  list: TList<TMetabibPerson>;
  p: TMetabibPerson;

  function S(const Name: string): string;
  var
    fv: TJSONValue;
  begin
    fv := o.Values[Name];
    if fv is TJSONString then
      Result := TJSONString(fv).Value
    else
      Result := '';
  end;

begin
  list := TList<TMetabibPerson>.Create;
  try
    for v in ClaimValues(Group, Field) do
      if v is TJSONObject then
      begin
        o := TJSONObject(v);
        p.LastName := S('last_name');
        p.FirstName := S('first_name');
        p.MiddleName := S('middle_name');
        p.NickName := S('nick_name');
        if (p.LastName <> '') or (p.FirstName <> '') or (p.NickName <> '') then
          list.Add(p);
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

  FReader := TStreamReader.Create(FDecoded, TEncoding.UTF8, False, 64 * 1024);
end;

procedure TMetabibReader.ReadHeader;
var
  Line: string;
  Root: TJSONValue;
  Obj, ArchObj: TJSONObject;
  Archives: TJSONArray;
  v: TJSONValue;
begin
  if FReader.EndOfStream then
    raise EMetabibError.CreateFmt(rstrNotMetabibDataset, ['(порожній файл)']);

  Line := FReader.ReadLine;
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
  try
    OpenContainer(FileName);
    ReadHeader;
  except
    FreeAndNil(FReader);
    if FDecoded <> FBase then
      FreeAndNil(FDecoded);
    FreeAndNil(FBase);
    FreeAndNil(FArchives);
    raise;
  end;
end;

destructor TMetabibReader.Destroy;
begin
  FreeAndNil(FReader);
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
  Seqs: TArray<TJSONValue>;
  StampStr: string;
  dt: TDateTime;
begin
  Book := Default (TMetabibBook);

  repeat
    if FReader.EndOfStream then
      Exit(mrEof);
    Line := FReader.ReadLine;
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
    Book.BookID := IntValue(Locator, 'book_id', 0);

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

    Book.Title := FirstClaimString(Bib, 'title');
    Book.BookName := FirstClaimString(Pub, 'book_name');
    Book.Authors := ClaimPersons(Bib, 'authors');
    Book.Translators := ClaimPersons(Bib, 'translators');
    Book.Genres := ClaimStrings(Bib, 'genres');
    Book.Lang := FirstClaimString(Bib, 'language');
    Book.Annotation := FirstClaimString(Bib, 'annotation');
    Book.Keywords := FirstClaimString(Bib, 'keywords');

    Seqs := ClaimValues(Bib, 'sequences');
    if (Length(Seqs) > 0) and (Seqs[0] is TJSONObject) then
    begin
      Book.SeriesName := StrValue(TJSONObject(Seqs[0]), 'name');
      Book.SeriesNo := IntValue(TJSONObject(Seqs[0]), 'number', 0);
    end;

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
