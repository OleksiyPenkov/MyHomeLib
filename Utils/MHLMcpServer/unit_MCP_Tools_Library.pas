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

implementation

uses
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
function Guarded(Handler: TMcpToolHandler): TMcpToolHandler;
begin
  Result :=
    function(const Args: TJSONObject): TJSONObject
    begin
      EnsureLibraryInitialized;
      try
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

function CollectionOrFail(const CollectionID: Integer): IBookCollection;
begin
  try
    Result := SystemDB.GetCollection(CollectionID);
  except
    on E: Exception do
      raise EMcpToolError.Create('collection_not_found',
        Format('Collection %d not found: %s', [CollectionID, E.Message]));
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

function AuthorsToJson(const Authors: TBookAuthors): TJSONArray;
var
  I: Integer;
  Entry: TJSONObject;
begin
  Result := TJSONArray.Create;
  for I := 0 to High(Authors) do
  begin
    Entry := TJSONObject.Create;
    Entry.AddPair('author_id', TJSONNumber.Create(Authors[I].AuthorID));
    Entry.AddPair('last_name', Authors[I].LastName);
    Entry.AddPair('first_name', Authors[I].FirstName);
    Entry.AddPair('middle_name', Authors[I].MiddleName);
    Entry.AddPair('full_name', Authors[I].GetFullName);
    Result.AddElement(Entry);
  end;
end;

function GenresToJson(const Genres: TBookGenres): TJSONArray;
var
  I: Integer;
  Entry: TJSONObject;
begin
  Result := TJSONArray.Create;
  for I := 0 to High(Genres) do
  begin
    Entry := TJSONObject.Create;
    Entry.AddPair('code', Genres[I].GenreCode);
    Entry.AddPair('alias', Genres[I].GenreAlias);
    Result.AddElement(Entry);
  end;
end;

function BookToJson(const Book: TBookRecord; Full: Boolean): TJSONObject;
begin
  Result := TJSONObject.Create;
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
end;

function GetBook(const Args: TJSONObject): TJSONObject;
var
  Collection: IBookCollection;
  BookKey: TBookKey;
  Book: TBookRecord;
begin
  Collection := CollectionOrFail(RequireInt(Args, 'collection_id'));

  BookKey.BookID := RequireInt(Args, 'book_id');
  BookKey.DatabaseID := RequireInt(Args, 'collection_id');

  try
    Collection.GetBookRecord(BookKey, Book, True);
  except
    on E: Exception do
      raise EMcpToolError.Create('book_not_found',
        Format('Book %d not found: %s', [BookKey.BookID, E.Message]));
  end;

  Result := BookToJson(Book, True);
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
end;

end.
