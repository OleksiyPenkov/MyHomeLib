unit unit_MCP_Tools_Library;

interface

uses
  System.SysUtils,
  System.JSON,
  unit_Globals,
  unit_Interfaces,
  unit_MCP_Protocol;

procedure RegisterLibraryTools(Server: TMcpServer);
function CollectionOrFail(const CollectionID: Integer): IBookCollection;
function Guarded(Handler: TMcpToolHandler): TMcpToolHandler;
function BookToJson(const Book: TBookRecord; Full: Boolean): TJSONObject;
function AuthorsToJson(const Authors: TBookAuthors): TJSONArray;
function GenresToJson(const Genres: TBookGenres): TJSONArray;

// Exported (not just used internally by this unit) so any other tool unit --
// unit_MCP_Tools_Text.pas included -- can log a caught exception's full
// detail to stderr while still returning a sanitized, path-free message to
// the client, the same discipline CollectionOrFail/GetBook already follow
// below.
procedure LogToStderr(const Msg: string);

implementation

uses
  System.Character,
  dm_user,
  unit_Settings,
  unit_MCP_Json,
  SQLiteWrap;

var
  // Flips to True only after TDMUser.Init has completed against an existing
  // system database. Makes EnsureLibraryInitialized idempotent so DMUser is
  // booted at most once, on the first tool call that needs it.
  GLibraryInitialized: Boolean = False;

// Boots DMUser lazily, on first tool use, instead of at process startup.
// This is what keeps the server from ever writing to the system database:
// TDMUser.Init calls TSystemData_SQLite.CreateSystemTables (DDL plus two
// INSERTs) whenever the system DB file is absent. Checking for the file
// first and refusing with a domain error if it is missing means that branch
// of Init is never reached from this process.
//
// Ordering note: TMHLSettings computes every path field (FDataDir,
// FDbsFileName, ...) inside its own constructor, which TDMUser.Create runs
// immediately. TMHLSettings.LoadSettings -- called later, from TDMUser.Init
// -- only overwrites user-preference fields (device path, proxy, UI layout,
// ...), never the path fields. So DMUser.Settings.SystemFileName[sfSystemDB]
// is already correct right after TDMUser.Create, before Init ever runs, and
// can be safely checked before deciding whether to call Init at all.
procedure EnsureLibraryInitialized;
var
  SysDBFileName: string;
begin
  if GLibraryInitialized then
    Exit;

  if not Assigned(DMUser) then
    DMUser := TDMUser.Create(nil);

  SysDBFileName := DMUser.Settings.SystemFileName[sfSystemDB];
  if not FileExists(SysDBFileName) then
    raise EMcpToolError.Create('system_db_missing',
      Format('Системну базу даних MyHomeLib не знайдено за шляхом: %s. ' +
        'Запустіть MyHomeLib хоча б один раз, щоб її створити.',
        [SysDBFileName]));

  DMUser.Init;
  GLibraryInitialized := True;
end;

// Wraps a handler so that (1) DMUser is brought up on first use (see
// EnsureLibraryInitialized) and (2) SQLite lock contention becomes a domain
// error instead of an opaque internal one. SQLiteWrap exposes no read-only
// or busy-timeout open mode, so a write by the running app surfaces here as
// "database is locked".
//
// EnsureLibraryInitialized is called INSIDE the try/except, not before it:
// TDMUser.Init itself opens the system database, so an ESQLiteException it
// raises (the system DB exists but the running app holds a lock at that
// exact moment) must go through the same collection_busy mapping as every
// other SQLite exception a handler can raise -- not surface as a raw
// JSON-RPC -32603 just because it happened one call earlier than the rest.
function Guarded(Handler: TMcpToolHandler): TMcpToolHandler;
begin
  Result :=
    function(const Args: TJSONObject): TJSONObject
    begin
      try
        EnsureLibraryInitialized;
        Result := Handler(Args);
      except
        on E: ESQLiteException do
        begin
          if E.Message.ToLower.Contains('locked') or
             E.Message.ToLower.Contains('busy') then
            raise EMcpToolError.Create('collection_busy',
              'Колекція зайнята — можливо, MyHomeLib саме імпортує книги.');
          raise;
        end;
      end;
    end;
end;

// Diagnostic-only logging for a developer attached to stderr. Never stdout --
// stdout is reserved solely for TMcpTransport's JSON-RPC output (see the
// warning in MHLMcpServer.dpr). Used to preserve inner exception detail
// (which can carry build-machine paths, e.g. from a Delphi Assert) without
// leaking it to the client in an EMcpToolError message.
procedure LogToStderr(const Msg: string);
begin
  Writeln(ErrOutput, Msg);
end;

function CollectionOrFail(const CollectionID: Integer): IBookCollection;
begin
  try
    Result := SystemDB.GetCollection(CollectionID);
  except
    on E: Exception do
    begin
      LogToStderr(Format('CollectionOrFail(%d): %s', [CollectionID, E.Message]));
      raise EMcpToolError.Create('collection_not_found',
        Format('Collection %d not found', [CollectionID]));
    end;
  end;

  if not Assigned(Result) then
    raise EMcpToolError.Create('collection_not_found',
      Format('Collection %d not found', [CollectionID]));
end;

function ListCollections(const Args: TJSONObject): TJSONObject;
var
  Iterator: ICollectionInfoIterator;
  Info: TCollectionInfo;
  Arr: TJSONArray;
  Entry: TJSONObject;
begin
  // Arr (and every Entry already added to it) must not leak if the iterator
  // raises partway through -- which is exactly what happens on the
  // collection_busy path, in a process that lives for a whole client
  // session. Same shape to be reused by every later tool building a result
  // array.
  Arr := TJSONArray.Create;
  try
    Iterator := SystemDB.GetCollectionInfoIterator;
    while Iterator.Next(Info) do
    begin
      Entry := TJSONObject.Create;
      Entry.AddPair('id', TJSONNumber.Create(Info.ID));
      Entry.AddPair('name', Info.DisplayName);
      Entry.AddPair('root_folder', Info.RootFolder);
      Entry.AddPair('type', TJSONNumber.Create(Info.CollectionType));
      Entry.AddPair('notes', Info.Notes);
      Arr.AddElement(Entry);
    end;
  except
    Arr.Free;
    raise;
  end;

  Result := TJSONObject.Create;
  Result.AddPair('collections', Arr);
end;

// Composes a display name from raw name parts, skipping blanks, instead of
// calling TAuthorData.GetFullName. GetFullName does Assert(LastName <> ''),
// which raises EAssertionFailed -- carrying an absolute build-machine source
// path, since assertions are enabled at runtime in this project's Release
// config -- for any author row with no last name. Authors come straight from
// the DB via GetBookAuthors with no backfill, and hand-edited or
// badly-imported metadata makes a blank LastName a real case in a home
// library, not a hypothetical one. Nothing upstream of BookToJson catches
// EAssertionFailed, so it would otherwise reach the client raw, reintroducing
// the same path leak that CollectionOrFail/GetBook were just fixed for, via
// this route instead.
//
// For well-formed data (LastName non-blank) this produces output identical
// to today's GetFullName: both build LastName, then (if non-blank) FirstName,
// then (if non-blank) MiddleName, each separated by a single space. This
// version additionally tolerates a blank LastName by just skipping it,
// rather than asserting or (as unit_FB2Utils.FormatName would, called
// directly with an empty LastName) leaving a stray leading space.
function ComposeAuthorFullName(const Author: TAuthorData): string;
begin
  Result := Author.LastName;

  if Author.FirstName <> '' then
  begin
    if Result <> '' then
      Result := Result + ' ' + Author.FirstName
    else
      Result := Author.FirstName;
  end;

  if Author.MiddleName <> '' then
  begin
    if Result <> '' then
      Result := Result + ' ' + Author.MiddleName
    else
      Result := Author.MiddleName;
  end;
end;

function AuthorsToJson(const Authors: TBookAuthors): TJSONArray;
var
  I: Integer;
  Entry: TJSONObject;
begin
  // Same leak-safe shape as ListCollections: Result (and, per entry, Entry)
  // must not leak if anything raises mid-loop -- Entry until it is handed to
  // Result via AddElement, Result for as long as it lives.
  Result := TJSONArray.Create;
  try
    for I := 0 to High(Authors) do
    begin
      Entry := TJSONObject.Create;
      try
        Entry.AddPair('author_id', TJSONNumber.Create(Authors[I].AuthorID));
        Entry.AddPair('last_name', Authors[I].LastName);
        Entry.AddPair('first_name', Authors[I].FirstName);
        Entry.AddPair('middle_name', Authors[I].MiddleName);
        Entry.AddPair('full_name', ComposeAuthorFullName(Authors[I]));
      except
        Entry.Free;
        raise;
      end;
      Result.AddElement(Entry);
    end;
  except
    Result.Free;
    raise;
  end;
end;

function GenresToJson(const Genres: TBookGenres): TJSONArray;
var
  I: Integer;
  Entry: TJSONObject;
begin
  Result := TJSONArray.Create;
  try
    for I := 0 to High(Genres) do
    begin
      Entry := TJSONObject.Create;
      try
        Entry.AddPair('code', Genres[I].GenreCode);
        Entry.AddPair('alias', Genres[I].GenreAlias);
      except
        Entry.Free;
        raise;
      end;
      Result.AddElement(Entry);
    end;
  except
    Result.Free;
    raise;
  end;
end;

function BookToJson(const Book: TBookRecord; Full: Boolean): TJSONObject;
begin
  // Same leak-safe shape once more. Ownership note: as soon as AddPair('authors', ...)
  // / AddPair('genres', ...) succeeds, Result owns that array -- freeing
  // Result on the except branch below cascades into freeing it too, so it
  // must NOT be freed separately (that would double-free it). If
  // AuthorsToJson/GenresToJson themselves raise, they have already cleaned up
  // their own partial state (see above) before the exception reaches here, so
  // there is nothing of theirs left to free; only Result (and whatever it
  // already owns from earlier AddPair calls in this function) needs freeing.
  Result := TJSONObject.Create;
  try
    Result.AddPair('book_id', TJSONNumber.Create(Book.BookKey.BookID));
    Result.AddPair('title', Book.Title);
    Result.AddPair('authors', AuthorsToJson(Book.Authors));
    Result.AddPair('genres', GenresToJson(Book.Genres));
    Result.AddPair('series', Book.Series);
    Result.AddPair('seq_number', TJSONNumber.Create(Book.SeqNumber));
    Result.AddPair('lang', Book.Lang);
    Result.AddPair('ext', Book.FileExt);
    Result.AddPair('size', TJSONNumber.Create(Book.Size));
    Result.AddPair('has_text',
      TJSONBool.Create(Book.GetBookFormat in [bfFb2, bfFb2Archive]));

    if Full then
    begin
      Result.AddPair('lib_rate', TJSONNumber.Create(Book.LibRate));
      Result.AddPair('rate', TJSONNumber.Create(Book.Rate));
      Result.AddPair('progress', TJSONNumber.Create(Book.Progress));
      Result.AddPair('keywords', Book.KeyWords);
      Result.AddPair('folder', Book.Folder);
      Result.AddPair('file_name', Book.FileName);
      Result.AddPair('annotation', Book.Annotation);
      Result.AddPair('review', Book.Review);
      Result.AddPair('is_local', TJSONBool.Create(bpIsLocal in Book.BookProps));
      Result.AddPair('is_deleted', TJSONBool.Create(bpIsDeleted in Book.BookProps));
      Result.AddPair('has_review', TJSONBool.Create(bpHasReview in Book.BookProps));
    end;
  except
    Result.Free;
    raise;
  end;
end;

function GetBook(const Args: TJSONObject): TJSONObject;
var
  Collection: IBookCollection;
  CollectionID: Integer;
  BookKey: TBookKey;
  Book: TBookRecord;
begin
  CollectionID := RequireInt(Args, 'collection_id');
  Collection := CollectionOrFail(CollectionID);

  BookKey.BookID := RequireInt(Args, 'book_id');
  BookKey.DatabaseID := CollectionID;

  try
    Collection.GetBookRecord(BookKey, Book, True);
  except
    on E: Exception do
    begin
      LogToStderr(Format('GetBook(%d): %s', [BookKey.BookID, E.Message]));
      raise EMcpToolError.Create('book_not_found',
        Format('Book %d not found', [BookKey.BookID]));
    end;
  end;

  Result := BookToJson(Book, True);
end;

// Builds a `<field> LIKE <literal>` fragment for one of search_books' free-text
// arguments (title/author/series/lang/keyword/annotation) that matches Value
// as a literal, case-insensitive substring -- regardless of what characters
// Value contains -- instead of letting unit_SearchUtils.PrepareQuery/
// AddToFilter interpret it.
//
// Why a plain quoted literal is not safe here: PrepareSearchData
// (Program\DAO\SQLite\unit_Database_SQLite.pas) runs every one of these
// fields through PrepareQuery(Value, UP=True) then AddToFilter with a
// hard-coded column name. PrepareQuery wraps a "plain" value as `LIKE
// "%value%"`, but the moment Value already contains '%', '=', '"' or the word
// LIKE, it assumes the caller wrote a hand-crafted condition and passes
// Value through nearly verbatim (no escaping of embedded quotes at all) --
// so a title containing a '"' defeats the wrapping outright, and a value
// shaped like `x' OR '1'='1` sails through unescaped into the WHERE clause.
// AddToFilter then makes it worse independent of PrepareQuery: it splices in
// the column name by blindly text-searching the *final* value for
// space-bounded ' LIKE ', ' =', ' <>', ' <', ' >' tokens -- so even a
// correctly-quoted literal would be at risk if the caller's own text
// happens to contain one of those substrings (e.g. an annotation containing
// "x < y"), because AddToFilter cannot tell "inside the literal" from "the
// real operator" and would splice the column name into the middle of it.
//
// The fix used here is the one Task 7 established for `genre`, taken
// further: build the whole condition ourselves so PrepareQuery has nothing
// left to reinterpret (our own literal 'LIKE' keyword makes PrepareQuery
// skip its wrapping/escaping branches and pass the string through close to
// verbatim), and render Value's *escaped* text as SQLite CHAR(code, code,
// ...) calls -- decimal Unicode code points joined by commas -- instead of
// a quoted string. A CHAR()-built value contains none of the caller's
// original characters anywhere in the spliced SQL text (only digits,
// commas, parentheses and our own fixed keywords), so AddToFilter's blind
// token search can never mistake part of the literal for a second operator,
// and there is no quote character of any kind for the value to break out
// through. This is a stronger guarantee than escaping quotes the way the
// `genre` fix does, because `genre` only ever fills in one bare `=`
// comparison, never arbitrary free text that could itself contain
// operator-shaped substrings.
//
// Chunked into groups of 100 code points per CHAR() call, concatenated with
// `||`: SQLite's SQLITE_MAX_FUNCTION_ARG defaults to 127, so a single
// CHAR() call would reject any search value longer than ~125 characters
// after escaping -- a real limit for `annotation` searches in particular.
//
// Case: the column side of this comparison (b.SearchTitle etc.) is
// precomputed by a custom MHL_UPPER SQLite UDF backed by
// `Char.ToUpper` (System.Character's TCharHelper.ToUpper, see
// Program\DAO\SQLite\Lib\SQLite3UDF.pas), not Delphi's AnsiUpperCase. Since
// this function encodes Value's exact character codes into the SQL text,
// PrepareQuery's own UP=True uppercasing step (which only touches the
// "LIKE CHAR(...)" text, not the numbers' represented characters) cannot
// perform the case-folding that step normally does -- so Value must be
// uppercased with the *same* function before it is escaped/encoded, or this
// would silently become a case-SENSITIVE match against an always-uppercase
// column.
//
// Wildcard escaping: '%' and '_' are LIKE metacharacters regardless of how
// the pattern string was built, so a literal search must escape them (and
// the escape character itself, backslash, in case Value already contains
// one) and declare ESCAPE '\' -- otherwise a title containing a literal '%'
// or '_' would be (mis)interpreted as a wildcard instead of matched
// literally.
function LiteralLikeCondition(const Value: string): string;
const
  ChunkSize = 100;
  SQ = ''''; // a single apostrophe as a string value
var
  Escaped: string;
  Codes, Terms: string;
  ChunkStart, ChunkEnd, I: Integer;
begin
  Escaped := Char.ToUpper(Value);
  Escaped := StringReplace(Escaped, '\', '\\', [rfReplaceAll]);
  Escaped := StringReplace(Escaped, '%', '\%', [rfReplaceAll]);
  Escaped := StringReplace(Escaped, '_', '\_', [rfReplaceAll]);
  Escaped := '%' + Escaped + '%';

  Terms := '';
  ChunkStart := 1;
  while ChunkStart <= Length(Escaped) do
  begin
    ChunkEnd := ChunkStart + ChunkSize - 1;
    if ChunkEnd > Length(Escaped) then
      ChunkEnd := Length(Escaped);

    Codes := '';
    for I := ChunkStart to ChunkEnd do
    begin
      if Codes <> '' then
        Codes := Codes + ',';
      Codes := Codes + IntToStr(Ord(Escaped[I]));
    end;

    if Terms <> '' then
      Terms := Terms + '||';
    Terms := Terms + 'CHAR(' + Codes + ')';

    ChunkStart := ChunkEnd + 1;
  end;

  Result := 'LIKE ' + Terms + ' ESCAPE ' + SQ + '\' + SQ;
end;

// Full-text-ish search across a single collection. LoadMemos is False --
// summary rows (BookToJson Full=False) never surface annotation or review,
// so there is no point paying for the extra SQLite reads. RecordCount is
// read exactly once, into Total, before the paging loop below: the SQLite
// iterators behind IBookIterator assert on a second call (see
// unit_Database_SQLite.pas), which would otherwise surface to the client as
// an uncaught EAssertionFailed carrying a build-machine path.
function SearchBooks(const Args: TJSONObject): TJSONObject;
var
  Collection: IBookCollection;
  Criteria: TBookSearchCriteria;
  Iterator: IBookIterator;
  Book: TBookRecord;
  Arr: TJSONArray;
  Limit, Offset, Skipped, Taken, MinRate: Integer;
  Clamped, ClampedAny: Boolean;
  Total: Integer;
  GenreCode, TitleArg, AuthorArg, SeriesArg, LangArg, KeywordArg, AnnotationArg: string;
begin
  Collection := CollectionOrFail(RequireInt(Args, 'collection_id'));

  Criteria := Default(TBookSearchCriteria);
  // Title/author/series/lang/keyword/annotation all go through
  // LiteralLikeCondition (see its comment above) rather than a direct
  // ArgStr(...) assignment -- PrepareSearchData would otherwise hand the
  // caller's raw text to PrepareQuery/AddToFilter, which splice it into the
  // WHERE clause with no escaping at all (see that function's comment for
  // the full argument).
  TitleArg := ArgStr(Args, 'title');
  if TitleArg <> '' then
    Criteria.Title := LiteralLikeCondition(TitleArg);
  AuthorArg := ArgStr(Args, 'author');
  if AuthorArg <> '' then
    Criteria.FullName := LiteralLikeCondition(AuthorArg);
  SeriesArg := ArgStr(Args, 'series');
  if SeriesArg <> '' then
    Criteria.Series := LiteralLikeCondition(SeriesArg);
  // TBookSearchCriteria.Genre is not a value to compare -- PrepareSearchData
  // splices it verbatim into a WHERE clause (' WHERE (' + SearchCriteria.Genre
  // + ')'), matching how frm_main.pas builds it from its genre-tree picker:
  // Format('(g.GenreCode = "%s")', [Genre.GenreCode]). A bare code (what
  // list_genres' "code" field is and what this tool's schema documents the
  // argument as) is not valid SQL on its own -- confirmed against a real
  // collection, where passing "0.3.3" straight through as SearchBooks did
  // before this fix produced 'near ".3": syntax error'. Build the same
  // condition shape frm_main does, but deliberately with single quotes
  // instead of frm_main's double quotes, and double up any embedded '''
  // (SQLite's escape for a literal quote inside a single-quoted string) so a
  // caller-supplied genre string can't break out of the literal and inject
  // arbitrary SQL into this WHERE clause.
  //
  // Double quotes were tried first and are NOT safe here even though doubling
  // "" does contain the value: SQLite resolves a double-quoted token as an
  // *identifier* first, falling back to a string literal only when no
  // matching identifier exists. frm_main.pas can get away with this because
  // it only ever quotes a real GenreCode value picked from its own genre
  // tree. This tool quotes arbitrary caller input, so a genre argument that
  // happens to match a column name -- e.g. the literal string "GenreCode" --
  // would become g.GenreCode = "GenreCode", comparing the column to itself
  // and matching every row instead of matching nothing. Single-quoted strings
  // have no such identifier fallback in SQLite, so they close both the
  // injection hole and this identifier-collision trap.
  GenreCode := ArgStr(Args, 'genre');
  if GenreCode <> '' then
    Criteria.Genre := Format('g.GenreCode = ''%s''',
      [StringReplace(GenreCode, '''', '''''', [rfReplaceAll])]);
  LangArg := ArgStr(Args, 'lang');
  if LangArg <> '' then
    Criteria.Lang := LiteralLikeCondition(LangArg);
  KeywordArg := ArgStr(Args, 'keyword');
  if KeywordArg <> '' then
    Criteria.KeyWord := LiteralLikeCondition(KeywordArg);
  AnnotationArg := ArgStr(Args, 'annotation');
  if AnnotationArg <> '' then
    Criteria.Annotation := LiteralLikeCondition(AnnotationArg);
  // TBookSearchCriteria.Deleted is inverted relative to this tool's
  // include_deleted argument: PrepareSearchData only adds a filter when
  // Deleted is True, and that filter is `b.IsDeleted = 0` -- i.e. Deleted
  // means "hide deleted books" (it is set straight from a "hide deleted"
  // checkbox in frm_main.pas), not "include deleted books". So the default
  // include_deleted=False (exclude deleted books) must map to Deleted=True,
  // and include_deleted=True (include deleted books) must map to
  // Deleted=False (no filter, deleted rows pass through). Do not "simplify"
  // this back to a direct assignment -- it was tried and is backwards.
  Criteria.Deleted    := not ArgBool(Args, 'include_deleted', False);

  // DateIdx must be -1, not the Default(...) zero value. PrepareSearchData's
  // 0 branch is not "no date filter" -- it means "modified in the last
  // calendar day", silently restricting every search to yesterday's imports.
  // -1 is the sentinel that actually skips date filtering (it falls through
  // to DateText, which Default(...) already left empty). Confirmed against
  // a real 525k-book collection: without this, search_books returned zero
  // rows for every query.
  Criteria.DateIdx := -1;

  // min_lib_rate is documented (and named) as a *minimum* rating, but
  // `Criteria.LibRate := IntToStr(MinRate)` (the previous code) went through
  // PrepareQuery(S, UP=False, ConverToFull=False), which wraps a plain
  // number as `="N"` -- an EXACT match, silently turning "4 and up" into
  // "exactly 4". Criteria.LibRate is spliced by AddToFilter the same
  // untrusted-text way every other field here is, but MinRate itself is
  // always our own IntToStr of a parsed Integer, never caller text, so no
  // literal-escaping is needed for this one -- only the operator needs
  // fixing. '>= N' (no '=' immediately after a space, so AddToFilter's
  // ' =' token does not fire; its ' >' token does, splicing in the column
  // name as `b.LibRate >= N`) gives the documented "at least" semantics.
  MinRate := ArgInt(Args, 'min_lib_rate', 0);
  if MinRate > 0 then
    Criteria.LibRate := Format('>= %d', [MinRate]);

  // PrepareSearchData raises a plain Exception (message
  // rstrCheckFilterParams, "Перевірте параметри фільтра") whenever it built
  // no WHERE clause at all, and that exception is not an EMcpToolError, so
  // it would otherwise fall through Guarded/HandleToolsCall uncaught and
  // surface to the client as a raw JSON-RPC -32603 carrying the DAO's own
  // message text. That happens whenever every one of the fields above is
  // blank AND include_deleted=true (Criteria.Deleted=False skips the one
  // filter -- b.IsDeleted = 0 -- that a call with every other field left at
  // its default would otherwise always pick up). Detect the same condition
  // here first and fail with a stable, machine-readable domain error
  // instead of letting that raw text leak through.
  if (Criteria.Title = '') and (Criteria.FullName = '') and (Criteria.Series = '') and
     (Criteria.Genre = '') and (Criteria.Lang = '') and (Criteria.KeyWord = '') and
     (Criteria.Annotation = '') and (Criteria.LibRate = '') and (not Criteria.Deleted) then
    raise EMcpToolError.Create('empty_filter',
      'Вкажіть хоча б один критерій пошуку (title, author, series, genre, ' +
      'lang, keyword, annotation, min_lib_rate) або залиште include_deleted ' +
      'без змін (false).');

  Limit := ArgIntClamped(Args, 'limit', 25, 1, 200, ClampedAny);
  Offset := ArgIntClamped(Args, 'offset', 0, 0, MaxInt, Clamped);
  ClampedAny := ClampedAny or Clamped;

  Iterator := Collection.Search(Criteria, False);
  Total := Iterator.RecordCount;

  // Same leak-safe accumulator shape as ListCollections/AuthorsToJson: Arr
  // (and, per entry, the TJSONObject from BookToJson) must not leak if
  // anything raises mid-loop.
  Arr := TJSONArray.Create;
  try
    Skipped := 0;
    Taken := 0;
    while Iterator.Next(Book) do
    begin
      if Skipped < Offset then
      begin
        Inc(Skipped);
        Continue;
      end;

      if Taken >= Limit then
        Break;

      Arr.AddElement(BookToJson(Book, False));
      Inc(Taken);
    end;
  except
    Arr.Free;
    raise;
  end;

  Result := TJSONObject.Create;
  Result.AddPair('books', Arr);
  Result.AddPair('total_count', TJSONNumber.Create(Total));
  Result.AddPair('has_more', TJSONBool.Create(Offset + Taken < Total));
  if ClampedAny then
    Result.AddPair('clamped', TJSONBool.Create(True));
end;

// Whole genre tree, unpaged: genre lists are small and fixed for a given
// collection, and the codes returned here are exactly what a caller needs to
// build a search_books(genre=...) call -- there is no other way to discover
// them, so truncating this list would make that argument unusable.
function ListGenres(const Args: TJSONObject): TJSONObject;
var
  Collection: IBookCollection;
  Iterator: IGenreIterator;
  Genre: TGenreData;
  Arr: TJSONArray;
  Entry: TJSONObject;
begin
  Collection := CollectionOrFail(RequireInt(Args, 'collection_id'));

  // Same leak-safe accumulator shape as ListCollections/SearchBooks: Arr (and,
  // per entry, Entry) must not leak if anything raises mid-loop.
  Arr := TJSONArray.Create;
  try
    Iterator := Collection.GetGenreIterator(gmAll, nil);
    while Iterator.Next(Genre) do
    begin
      Entry := TJSONObject.Create;
      try
        Entry.AddPair('code', Genre.GenreCode);
        Entry.AddPair('parent_code', Genre.ParentCode);
        Entry.AddPair('alias', Genre.GenreAlias);
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
  Result.AddPair('genres', Arr);
end;

// Series list with an optional case-insensitive substring filter, applied in
// Delphi over the iterator -- GetSeriesIterator's smAll mode takes no
// free-text filter of its own (smFullFilter instead reads alpha/local/deleted
// state off the collection object, not a caller-supplied string, and is not
// used here).
//
// Loop shape note: the limit is checked with `while Taken < Limit do` before
// calling Iterator.Next, rather than folding both into one `Next(...) and
// (Taken < Limit)` condition. With the latter, Pascal's short-circuit `and`
// still evaluates Next(...) first (it is the left operand), so on the
// iteration where Taken reaches Limit, Next would already have fetched and
// discarded one more record before the condition as a whole came back False.
// Checking Limit first means Next is called only when a record taken from it
// can actually still be used.
function ListSeries(const Args: TJSONObject): TJSONObject;
var
  Collection: IBookCollection;
  Iterator: ISeriesIterator;
  Series: TSeriesData;
  Arr: TJSONArray;
  Entry: TJSONObject;
  Filter: string;
  Limit, Taken: Integer;
  Clamped: Boolean;
begin
  Collection := CollectionOrFail(RequireInt(Args, 'collection_id'));
  Filter := ArgStr(Args, 'filter').ToLower;
  Limit := ArgIntClamped(Args, 'limit', 100, 1, 500, Clamped);

  Arr := TJSONArray.Create;
  try
    Taken := 0;
    Iterator := Collection.GetSeriesIterator(smAll);
    while Taken < Limit do
    begin
      if not Iterator.Next(Series) then
        Break;

      if (Filter <> '') and (not Series.SeriesTitle.ToLower.Contains(Filter)) then
        Continue;

      Entry := TJSONObject.Create;
      try
        Entry.AddPair('series_id', TJSONNumber.Create(Series.SeriesID));
        Entry.AddPair('title', Series.SeriesTitle);
      except
        Entry.Free;
        raise;
      end;
      Arr.AddElement(Entry);
      Inc(Taken);
    end;
  except
    Arr.Free;
    raise;
  end;

  Result := TJSONObject.Create;
  Result.AddPair('series', Arr);
  if Clamped then
    Result.AddPair('clamped', TJSONBool.Create(True));
end;

// Author list with the same optional substring-filter/limit shape as
// ListSeries (same loop-order reasoning applies). Uses ComposeAuthorFullName,
// not TAuthorData.GetFullName -- GetFullName asserts LastName <> '', and
// assertions are enabled in this build, so a blank-last-name row (a real
// possibility in hand-edited or badly-imported metadata) would otherwise
// raise EAssertionFailed carrying a build-machine source path straight out to
// the client, uncaught by anything between here and the transport.
function ListAuthors(const Args: TJSONObject): TJSONObject;
var
  Collection: IBookCollection;
  Iterator: IAuthorIterator;
  Author: TAuthorData;
  Arr: TJSONArray;
  Entry: TJSONObject;
  Filter: string;
  FullName: string;
  Limit, Taken: Integer;
  Clamped: Boolean;
begin
  Collection := CollectionOrFail(RequireInt(Args, 'collection_id'));
  Filter := ArgStr(Args, 'filter').ToLower;
  Limit := ArgIntClamped(Args, 'limit', 100, 1, 500, Clamped);

  Arr := TJSONArray.Create;
  try
    Taken := 0;
    Iterator := Collection.GetAuthorIterator(amAll, nil);
    while Taken < Limit do
    begin
      if not Iterator.Next(Author) then
        Break;

      FullName := ComposeAuthorFullName(Author);
      if (Filter <> '') and (not FullName.ToLower.Contains(Filter)) then
        Continue;

      Entry := TJSONObject.Create;
      try
        Entry.AddPair('author_id', TJSONNumber.Create(Author.AuthorID));
        Entry.AddPair('full_name', FullName);
        Entry.AddPair('last_name', Author.LastName);
      except
        Entry.Free;
        raise;
      end;
      Arr.AddElement(Entry);
      Inc(Taken);
    end;
  except
    Arr.Free;
    raise;
  end;

  Result := TJSONObject.Create;
  Result.AddPair('authors', Arr);
  if Clamped then
    Result.AddPair('clamped', TJSONBool.Create(True));
end;

procedure RegisterLibraryTools(Server: TMcpServer);
begin
  Server.RegisterTool(
    'list_collections',
    'Список усіх зареєстрованих колекцій MyHomeLib.',
    TJSONObject.ParseJSONValue('{"type":"object","properties":{}}') as TJSONObject,
    Guarded(ListCollections));

  Server.RegisterTool(
    'get_book',
    'Повні відомості про книгу за її ідентифікатором.',
    TJSONObject.ParseJSONValue(
      '{"type":"object","properties":{' +
      '"collection_id":{"type":"integer","description":"ID колекції"},' +
      '"book_id":{"type":"integer","description":"ID книги"}},' +
      '"required":["collection_id","book_id"]}') as TJSONObject,
    Guarded(GetBook));

  Server.RegisterTool(
    'search_books',
    'Пошук книг у колекції за назвою, автором, серією, жанром чи мовою.',
    TJSONObject.ParseJSONValue(
      '{"type":"object","properties":{' +
      '"collection_id":{"type":"integer","description":"ID колекції"},' +
      '"title":{"type":"string","description":"Підрядок назви (без урахування регістру; лапки, % та _ шукаються буквально, не як спецсимволи)"},' +
      '"author":{"type":"string","description":"Повне або часткове ім''я автора (без урахування регістру, буквально)"},' +
      '"series":{"type":"string","description":"Підрядок назви серії (без урахування регістру, буквально)"},' +
      '"genre":{"type":"string","description":"Код жанру зі списку list_genres"},' +
      '"lang":{"type":"string","description":"Підрядок коду мови (без урахування регістру, буквально)"},' +
      '"keyword":{"type":"string","description":"Підрядок ключових слів (без урахування регістру, буквально)"},' +
      '"annotation":{"type":"string","description":"Підрядок анотації (без урахування регістру, буквально)"},' +
      '"min_lib_rate":{"type":"integer","description":"Мінімальний рейтинг книги (LibRate) -- повертає книги з таким рейтингом і вище"},' +
      '"include_deleted":{"type":"boolean"},' +
      '"limit":{"type":"integer","description":"Типово 25, максимум 200"},' +
      '"offset":{"type":"integer"}},' +
      '"required":["collection_id"]}') as TJSONObject,
    Guarded(SearchBooks));

  Server.RegisterTool(
    'list_genres',
    'Дерево жанрів колекції. Коди жанрів потрібні для search_books.',
    TJSONObject.ParseJSONValue(
      '{"type":"object","properties":{' +
      '"collection_id":{"type":"integer"}},' +
      '"required":["collection_id"]}') as TJSONObject,
    Guarded(ListGenres));

  Server.RegisterTool(
    'list_series',
    'Перелік серій у колекції.',
    TJSONObject.ParseJSONValue(
      '{"type":"object","properties":{' +
      '"collection_id":{"type":"integer"},' +
      '"filter":{"type":"string","description":"Підрядок назви серії"},' +
      '"limit":{"type":"integer","description":"Типово 100, максимум 500"}},' +
      '"required":["collection_id"]}') as TJSONObject,
    Guarded(ListSeries));

  Server.RegisterTool(
    'list_authors',
    'Перелік авторів у колекції.',
    TJSONObject.ParseJSONValue(
      '{"type":"object","properties":{' +
      '"collection_id":{"type":"integer"},' +
      '"filter":{"type":"string","description":"Підрядок імені автора"},' +
      '"limit":{"type":"integer","description":"Типово 100, максимум 500"}},' +
      '"required":["collection_id"]}') as TJSONObject,
    Guarded(ListAuthors));
end;

end.
