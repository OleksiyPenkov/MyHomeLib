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
  SQLiteWrap,
  unit_MCP_Json;

// Wraps a handler so SQLite lock contention becomes a domain error instead of
// an opaque internal one. SQLiteWrap exposes no read-only or busy-timeout open
// mode, so a write by the running app surfaces here as "database is locked".
function Guarded(Handler: TMcpToolHandler): TMcpToolHandler;
begin
  Result :=
    function(const Args: TJSONObject): TJSONObject
    begin
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
  Arr := TJSONArray.Create;

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
