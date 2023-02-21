(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Authors             eg
  * Created             12.09.2010
  * Description
  *
  * $Id: unit_SystemDatabase_Abstract.pas 1070 2011-09-16 18:43:06Z eg_ $
  *
  * History
  *
  ****************************************************************************** *)

unit unit_SystemDatabase_Abstract;

interface

uses
  Classes,
  Windows,
  unit_Globals,
  unit_Consts,
  unit_Interfaces,
  unit_MHLGenerics,
  unit_UserData;

type
  // --------------------------------------------------------------------------
  TBookCollectionCache = TInterfaceCache<Integer, IBookCollection>;

  // --------------------------------------------------------------------------

  TSystemData = class abstract(TInterfacedObject)
  protected
    FCollectionCache: TBookCollectionCache;

    function InternalCreateCollection(const CollectionID: Integer): IBookCollection; virtual; abstract;

  protected
    //
    // ISystemData
    //
    function HasCollections: Boolean;
    function FindFirstExistingCollectionID(const PreferredID: Integer): Integer;

    function GetCollection(const CollectionID: Integer; const RefreshCache: Boolean): IBookCollection;

    //
    // Пользовательские данные
    //
    procedure ExportUserData(data: TUserData; const DatabaseID: Integer);

    //Iterators:
    function GetBookIterator(const GroupID: Integer; const DatabaseID: Integer = INVALID_COLLECTION_ID): IBookIterator; virtual; abstract;
    function GetGroupIterator: IGroupIterator; virtual; abstract;
    function GetCollectionInfoIterator: ICollectionInfoIterator; virtual; abstract;

    //
    // Служебные методы
    //
    procedure ClearCollectionCache;

  public
    constructor Create;
    destructor Destroy; override;
  end;

resourcestring
  rstrNamelessColection = 'безымянная коллекция';
  rstrUnknownCollection = 'неизвестная коллекция';
  rstrFavoritesGroupName = 'Избранное';
  rstrToReadGroupName = 'К прочтению';

implementation

uses
  SysUtils;

{ TSystemData }

constructor TSystemData.Create;
begin
  inherited Create;

  FCollectionCache := TBookCollectionCache.Create;
end;

destructor TSystemData.Destroy;
begin
  FreeAndNil(FCollectionCache);
  inherited Destroy;
end;

function TSystemData.HasCollections: Boolean;
begin
  Result := (GetCollectionInfoIterator.RecordCount > 0);
end;

function TSystemData.FindFirstExistingCollectionID(const PreferredID: Integer): Integer;
var
  it: ICollectionInfoIterator;
  Info: TCollectionInfo;
begin
  Result := INVALID_COLLECTION_ID;

  it := GetCollectionInfoIterator;
  while it.Next(Info) do
  begin
    if FileExists(Info.DBFileName) then
    begin
      if Info.ID = PreferredID then
      begin
        //
        // Пользователь предпочитает эту коллекцию, она доступна -> выходим
        //
        Result := Info.ID;
        Break;
      end;

      if Result = INVALID_COLLECTION_ID then
      begin
        //
        // Запомним первую доступную коллекцию
        //
        Result := Info.ID;
      end;
    end;
  end;
end;

procedure TSystemData.ExportUserData(data: TUserData; const DatabaseID: Integer);
var
  BookGroup: TBookGroup;
  GroupIterator: IGroupIterator;
  GroupData: TGroupData;
  BookIterator: IBookIterator;
  BookRecord: TBookRecord;
begin
  Assert(Assigned(data));

  GroupIterator := GetGroupIterator;
  while GroupIterator.Next(GroupData) do
  begin
    BookGroup := data.Groups.AddGroup(GroupData.GroupID, GroupData.Text);

    BookIterator := GetBookIterator(GroupData.GroupID, DatabaseID);
    while BookIterator.Next(BookRecord) do
      BookGroup.AddBook(BookRecord.BookKey.BookID, BookRecord.LibID);
  end;
end;

function TSystemData.GetCollection(const CollectionID: Integer; const RefreshCache: Boolean): IBookCollection;
begin
  Assert(INVALID_COLLECTION_ID <> CollectionID);
  FCollectionCache.LockMap;
  try
    if RefreshCache then
    begin
      FCollectionCache.Remove(CollectionID);
    end;

    if FCollectionCache.ContainsKey(CollectionID) then
    begin
      Result := FCollectionCache.Get(CollectionID);
    end
    else
    begin
      Result := InternalCreateCollection(CollectionID);
      FCollectionCache.Add(CollectionID, Result);
    end;
  finally
    FCollectionCache.UnlockMap;
  end;
end;

procedure TSystemData.ClearCollectionCache;
begin
  FCollectionCache.Clear;
end;

end.
