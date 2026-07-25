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

implementation

uses
  dm_user,
  unit_Settings,
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

procedure RegisterLibraryTools(Server: TMcpServer);
begin
  Server.RegisterTool(
    'list_collections',
    'Список усіх зареєстрованих колекцій MyHomeLib.',
    TJSONObject.ParseJSONValue('{"type":"object","properties":{}}') as TJSONObject,
    Guarded(ListCollections));
end;

end.
