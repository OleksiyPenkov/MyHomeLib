unit unit_MCP_Tools_Text;

interface

uses
  unit_MCP_Protocol;

procedure RegisterTextTools(Server: TMcpServer);

implementation

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  System.JSON,
  unit_Globals,
  unit_Interfaces,
  unit_Errors,
  unit_MCP_Json,
  unit_MCP_Tools_Library,
  unit_MCP_Fb2Extract,
  unit_MCP_TextCache;

// Shared preamble for get_book_toc/get_book_text/search_in_book: resolves the
// collection and book, rejects anything that is not FB2, and ensures the text
// cache holds an extraction for it. SourceSize/SourceStamp -- the same values
// EnsureCached was keyed on -- are handed back via out params so get_book_text
// and search_in_book don't have to re-resolve Book.GetBookFileName and
// re-stat it a second time to call ReadCachedSlice; the TBookRecord result
// itself is no longer needed by any caller now that those two values are
// returned directly, but the function keeps returning it (harmlessly
// discardable via a bare statement call, as get_book_toc already does) rather
// than reshaping this into a procedure for a difference that is now purely
// cosmetic.
//
// GetBookFileName, NOT GetBookContainer, is what resolves to a real file for
// both FB2 shapes: the .fb2 itself for bfFb2, the containing .zip for
// bfFb2Archive. GetBookContainer returns CollectionRoot+Folder, which for a
// loose .fb2 is a DIRECTORY -- FileExists on it would fail for every
// non-archived book in the library.
function LoadBookForText(const Args: TJSONObject;
  out CollectionID, BookID: Integer; out Cached: TCachedBook;
  out SourceSize: Int64; out SourceStamp: TDateTime): TBookRecord;
var
  Collection: IBookCollection;
  BookKey: TBookKey;
  Book: TBookRecord;
  SourcePath: string;
  // Anonymous methods cannot capture a var/out parameter (E2555) -- these
  // ordinary locals mirror CollectionID/BookID (out params of this very
  // function) purely so the EnsureCached closure below can log them.
  LocalCollectionID, LocalBookID: Integer;
begin
  CollectionID := RequireInt(Args, 'collection_id');
  BookID := RequireInt(Args, 'book_id');
  LocalCollectionID := CollectionID;
  LocalBookID := BookID;

  Collection := CollectionOrFail(CollectionID);

  BookKey.BookID := BookID;
  BookKey.DatabaseID := CollectionID;
  try
    Collection.GetBookRecord(BookKey, Book, False);
  except
    on E: Exception do
    begin
      // E.Message here can be an EAssertionFailed carrying a build-machine
      // source path (confirmed live: a nonexistent book_id reached an
      // Assert deep in unit_Database_SQLite.pas) -- never interpolate it
      // into the client-facing message. Full detail goes to stderr only,
      // matching CollectionOrFail/GetBook's own pattern in
      // unit_MCP_Tools_Library.pas.
      LogToStderr(Format('LoadBookForText.GetBookRecord(%d): %s', [BookID, E.Message]));
      raise EMcpToolError.Create('book_not_found',
        Format('Book %d not found', [BookID]));
    end;
  end;

  if not (Book.GetBookFormat in [bfFb2, bfFb2Archive]) then
    raise EMcpToolError.Create('unsupported_format',
      Format('Text extraction supports FB2 only; this book is "%s"', [Book.FileExt]));

  SourcePath := Book.GetBookFileName;
  if not FileExists(SourcePath) then
    raise EMcpToolError.Create('file_missing',
      Format('Book file not found: %s', [SourcePath]));

  SourceSize := TFile.GetSize(SourcePath);
  SourceStamp := TFile.GetLastWriteTime(SourcePath);

  Cached := EnsureCached(CollectionID, BookID, SourceSize, SourceStamp,
    function: TFb2Extraction
    var
      Stream: TStream;
    begin
      Stream := nil;
      try
        try
          Stream := Book.GetBookStream;
        except
          on E: EBookNotFound do
          begin
            LogToStderr(Format('LoadBookForText.GetBookStream(%d/%d): %s',
              [LocalCollectionID, LocalBookID, E.Message]));
            raise EMcpToolError.Create('file_missing',
              Format('Book file not found: %s', [SourcePath]));
          end;
        end;

        // GetBookStream can also return nil WITHOUT raising at all: when
        // Settings.IgnoreAbsentArchives is True -- its DEFAULT
        // (unit_Settings.pas) -- a missing/renamed archive is swallowed
        // inside GetBookStream itself (unit_Globals.pas) and Result stays
        // nil. Every book in the one registered collection is
        // bfFb2Archive, so this is a live path: without this check,
        // ExtractFb2(nil) below would have reached an access violation
        // instead of a mapped file_missing (ExtractFb2 itself now also
        // guards against a nil Stream defensively, but the check belongs
        // here too so the message can name the resolved path).
        if not Assigned(Stream) then
          raise EMcpToolError.Create('file_missing',
            Format('Book file not found: %s', [SourcePath]));

        try
          Result := ExtractFb2(Stream);
        except
          on E: EFb2ExtractError do
          begin
            if E.Kind = eekNoText then
              raise EMcpToolError.Create('book_has_no_text', E.Message)
            else
              raise EMcpToolError.Create('extraction_failed', E.Message);
          end;
        end;
      finally
        Stream.Free;
      end;
    end);

  Result := Book;
end;

// Table of contents: the section hierarchy as a flat pre-order list with
// Level recording nesting depth (0 = top-level) -- a parent's [Offset,
// Offset+Length) span strictly contains its children's, so this is NOT a
// partition of the text. A caller must never concatenate every entry; each
// entry's own slice already includes everything nested under it.
function GetBookToc(const Args: TJSONObject): TJSONObject;
var
  CollectionID, BookID, I: Integer;
  Cached: TCachedBook;
  SourceSize: Int64;
  SourceStamp: TDateTime;
  Arr: TJSONArray;
  Entry: TJSONObject;
begin
  // Neither the book record nor SourceSize/SourceStamp is needed here --
  // only Cached matters -- so the function result is discarded rather than
  // bound to an unused local.
  LoadBookForText(Args, CollectionID, BookID, Cached, SourceSize, SourceStamp);

  // Same leak-safe accumulator shape used throughout unit_MCP_Tools_Library:
  // Arr (and, per entry, Entry) must not leak if anything raises mid-loop.
  Arr := TJSONArray.Create;
  try
    for I := 0 to High(Cached.Sections) do
    begin
      Entry := TJSONObject.Create;
      try
        Entry.AddPair('title', Cached.Sections[I].Title);
        Entry.AddPair('level', TJSONNumber.Create(Cached.Sections[I].Level));
        Entry.AddPair('offset', TJSONNumber.Create(Cached.Sections[I].Offset));
        Entry.AddPair('length', TJSONNumber.Create(Cached.Sections[I].Length));
      except
        Entry.Free;
        raise;
      end;
      Arr.AddElement(Entry);
    end;
  except
    Arr.Free;
    raise;
  end;

  Result := TJSONObject.Create;
  try
    Result.AddPair('sections', Arr);
    Result.AddPair('structured', TJSONBool.Create(Cached.Structured));
    Result.AddPair('total_length', TJSONNumber.Create(Cached.TotalLength));
  except
    Result.Free;
    raise;
  end;
end;

// A text slice starting at Offset, clamped/defaulted rather than rejected
// (see ArgIntClamped) except for Offset itself: an Offset past the end of the
// text is a caller error (invalid_offset), not something to silently clamp,
// since silently clamping it to TotalLength would return an empty slice that
// looks like "book ends here" instead of "you asked past the end".
function GetBookText(const Args: TJSONObject): TJSONObject;
var
  CollectionID, BookID, Offset, Count: Integer;
  Cached: TCachedBook;
  SourceSize: Int64;
  SourceStamp: TDateTime;
  Slice: string;
  ClampedOffset, ClampedCount: Boolean;
begin
  // SourceSize/SourceStamp come straight back from LoadBookForText -- the
  // same values it just keyed EnsureCached on -- rather than re-resolving
  // Book.GetBookFileName and re-statting it a second time here.
  LoadBookForText(Args, CollectionID, BookID, Cached, SourceSize, SourceStamp);

  Offset := ArgIntClamped(Args, 'offset', 0, 0, MaxInt, ClampedOffset);
  Count := ArgIntClamped(Args, 'length', 8000, 1, 50000, ClampedCount);

  if Offset > Cached.TotalLength then
    raise EMcpToolError.Create('invalid_offset',
      Format('Offset %d is past the end of the text (total_length %d)',
        [Offset, Cached.TotalLength]));

  Slice := ReadCachedSlice(CollectionID, BookID, SourceSize, SourceStamp,
    Offset, Count);

  Result := TJSONObject.Create;
  try
    Result.AddPair('text', Slice);
    Result.AddPair('offset', TJSONNumber.Create(Offset));
    // Length(Slice) may come back one shorter than requested when the
    // surrogate trim fires (see ReadCachedSlice), so the actual length is
    // reported rather than echoing the argument.
    Result.AddPair('length', TJSONNumber.Create(Length(Slice)));
    Result.AddPair('total_length', TJSONNumber.Create(Cached.TotalLength));
    Result.AddPair('has_more',
      TJSONBool.Create(Offset + Length(Slice) < Cached.TotalLength));
    if ClampedOffset or ClampedCount then
      Result.AddPair('clamped', TJSONBool.Create(True));
  except
    Result.Free;
    raise;
  end;
end;

// Case-insensitive substring search over the whole cached text. Reads
// [0, TotalLength) via ReadCachedSlice -- the one call shape that never trims
// a genuine boundary surrogate (see that function's own comment), so this is
// the only safe way to get every code unit of the text for a linear scan.
//
// "offset" per hit is the 0-based code-unit position of the match itself
// (not the padded passage), so it can be fed straight into get_book_text and
// the phrase will be right at the start of what comes back -- that round
// trip is the whole point of returning it. "passage" is Query padded by
// ContextChars on each side, clamped to the text's own bounds, purely for
// display.
//
// TotalHits counts every match in the text, even past max_hits -- so a
// caller can tell "there were more than I got back" the same way
// search_books/list_series report has_more/total_count.
function SearchInBook(const Args: TJSONObject): TJSONObject;
var
  CollectionID, BookID, MaxHits, ContextChars, QueryLen: Integer;
  Cached: TCachedBook;
  SourceSize: Int64;
  SourceStamp: TDateTime;
  FullText, LowerText, Query, LowerQuery, Passage: string;
  Arr: TJSONArray;
  Entry: TJSONObject;
  SearchFrom, FoundPos, MatchOffset, TotalHits, PassageStart, PassageLen: Integer;
  ClampedHits, ClampedContext: Boolean;
begin
  // Validated BEFORE LoadBookForText, which pays for a full FB2 extraction
  // and cache population on a miss -- a blank/missing query is a pure
  // argument error and must not pay that cost first.
  Query := ArgStr(Args, 'query');
  if Query = '' then
    raise EMcpToolError.Create('invalid_params', 'Missing required argument: query');

  // SourceSize/SourceStamp come straight back from LoadBookForText -- the
  // same values it just keyed EnsureCached on -- rather than re-resolving
  // Book.GetBookFileName and re-statting it a second time here.
  LoadBookForText(Args, CollectionID, BookID, Cached, SourceSize, SourceStamp);

  MaxHits := ArgIntClamped(Args, 'max_hits', 10, 1, 50, ClampedHits);
  ContextChars := ArgIntClamped(Args, 'context_chars', 200, 0, 2000, ClampedContext);

  FullText := ReadCachedSlice(CollectionID, BookID, SourceSize, SourceStamp,
    0, Cached.TotalLength);

  QueryLen := Length(Query);
  LowerText := FullText.ToLower;
  LowerQuery := Query.ToLower;

  Arr := TJSONArray.Create;
  try
    TotalHits := 0;
    SearchFrom := 1;
    FoundPos := Pos(LowerQuery, LowerText, SearchFrom);
    while FoundPos > 0 do
    begin
      Inc(TotalHits);
      if TotalHits <= MaxHits then
      begin
        MatchOffset := FoundPos - 1; // 0-based, matches get_book_text's Offset

        PassageStart := FoundPos - ContextChars;
        if PassageStart < 1 then
          PassageStart := 1;

        PassageLen := (FoundPos - PassageStart) + QueryLen + ContextChars;
        if PassageStart + PassageLen - 1 > Length(FullText) then
          PassageLen := Length(FullText) - PassageStart + 1;

        Passage := Copy(FullText, PassageStart, PassageLen);

        Entry := TJSONObject.Create;
        try
          Entry.AddPair('offset', TJSONNumber.Create(MatchOffset));
          Entry.AddPair('passage', Passage);
        except
          Entry.Free;
          raise;
        end;
        Arr.AddElement(Entry);
      end;

      SearchFrom := FoundPos + QueryLen;
      FoundPos := Pos(LowerQuery, LowerText, SearchFrom);
    end;
  except
    Arr.Free;
    raise;
  end;

  Result := TJSONObject.Create;
  try
    Result.AddPair('hits', Arr);
    Result.AddPair('total_hits', TJSONNumber.Create(TotalHits));
    if ClampedHits or ClampedContext then
      Result.AddPair('clamped', TJSONBool.Create(True));
  except
    Result.Free;
    raise;
  end;
end;

procedure RegisterTextTools(Server: TMcpServer);
begin
  Server.RegisterTool(
    'get_book_toc',
    'Зміст книги FB2: розділи з їхніми зміщеннями для get_book_text.',
    TJSONObject.ParseJSONValue(
      '{"type":"object","properties":{' +
      '"collection_id":{"type":"integer"},' +
      '"book_id":{"type":"integer"}},' +
      '"required":["collection_id","book_id"]}') as TJSONObject,
    Guarded(GetBookToc));

  Server.RegisterTool(
    'get_book_text',
    'Фрагмент тексту книги FB2 від заданого зміщення.',
    TJSONObject.ParseJSONValue(
      '{"type":"object","properties":{' +
      '"collection_id":{"type":"integer"},' +
      '"book_id":{"type":"integer"},' +
      '"offset":{"type":"integer","description":"Типово 0"},' +
      '"length":{"type":"integer","description":"Типово 8000, максимум 50000"}},' +
      '"required":["collection_id","book_id"]}') as TJSONObject,
    Guarded(GetBookText));

  Server.RegisterTool(
    'search_in_book',
    'Пошук фрагментів у тексті книги FB2 із зазначенням їхніх зміщень.',
    TJSONObject.ParseJSONValue(
      '{"type":"object","properties":{' +
      '"collection_id":{"type":"integer"},' +
      '"book_id":{"type":"integer"},' +
      '"query":{"type":"string"},' +
      '"max_hits":{"type":"integer","description":"Типово 10, максимум 50"},' +
      '"context_chars":{"type":"integer","description":"Типово 200, максимум 2000"}},' +
      '"required":["collection_id","book_id","query"]}') as TJSONObject,
    Guarded(SearchInBook));
end;

end.
