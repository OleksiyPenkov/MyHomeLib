(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           eg
  *                     Nick Rymanov    nrymanov@gmail.com
  * Created             04.09.2010
  * Description
  *
  * $Id: unit_Database_SQLite.pas 1132 2013-12-11 16:35:00Z Demsa $
  *
  * History
  *
  ****************************************************************************** *)

unit unit_Database_SQLite;

interface

uses
  Classes,
  SQLiteWrap,
  unit_UserData,
  unit_Globals,
  unit_Interfaces,
  unit_Database_Abstract;

type
  TBookCollection_SQLite = class(TBookCollection, IBookCollection)
  strict private type
    //-------------------------------------------------------------------------
    TBookIteratorImpl = class(TInterfacedObject, IBookIterator)
    public
      constructor Create(
        Collection: TBookCollection_SQLite;
        SystemData: ISystemData;
        const Mode: TBookIteratorMode;
        const LoadMemos: Boolean;
        const FilterValue: PFilterValue;
        const SearchCriteria: TBookSearchCriteria
      );
      destructor Destroy; override;

    protected
      // IBookIterator
      function Next(out BookRecord: TBookRecord): Boolean;
      function RecordCount: Integer;

    strict private
      FCollection: TBookCollection_SQLite;
      FSystemData: ISystemData;
      FBooks: TSQLiteQuery;
      FCount: TSQLiteQuery;
      FCollectionID: Integer; // Active collection's ID at the time the iterator was created
      FLoadMemos: Boolean;

      procedure PrepareData(const Mode: TBookIteratorMode; const FilterValue: PFilterValue; const SearchCriteria: TBookSearchCriteria);
      procedure PrepareSearchData(const SearchCriteria: TBookSearchCriteria);
    end;
    // << TBookIteratorImpl

    //-------------------------------------------------------------------------
    TAuthorIteratorImpl = class(TInterfacedObject, IAuthorIterator)
    public
      constructor Create(
        Collection: TBookCollection_SQLite;
        SystemData: ISystemData;
        const Mode: TAuthorIteratorMode;
        const FilterValue: PFilterValue
      );
      destructor Destroy; override;

    protected
      // IAuthorIterator
      function Next(out AuthorData: TAuthorData): Boolean;
      function RecordCount: Integer;

    strict private
      FCollection: TBookCollection_SQLite;
      FSystemData: ISystemData;
      FAuthors: TSQLiteQuery;
      FCount: TSQLiteQuery;
      FCollectionID: Integer; // Active collection's ID at the time the iterator was created

      procedure PrepareData(const Mode: TAuthorIteratorMode; const FilterValue: PFilterValue);
    end;
    // << TAuthorIteratorImpl

    //-------------------------------------------------------------------------
    TGenreIteratorImpl = class(TInterfacedObject, IGenreIterator)
    public
      constructor Create(Collection: TBookCollection_SQLite; SystemData: ISystemData; const Mode: TGenreIteratorMode; const FilterValue: PFilterValue);
      destructor Destroy; override;

    protected
      // IGenreIterator
      function Next(out GenreData: TGenreData): Boolean;
      function RecordCount: Integer;

    strict private
      FCollection: TBookCollection_SQLite;
      FSystemData: ISystemData;
      FGenres: TSQLiteQuery;
      FCount: TSQLiteQuery;
      FCollectionID: Integer; // Active collection's ID at the time the iterator was created

      procedure PrepareData(const Mode: TGenreIteratorMode; const FilterValue: PFilterValue);
    end;
    // << TGenreIteratorImpl

    //-------------------------------------------------------------------------
    TSeriesIteratorImpl = class(TInterfacedObject, ISeriesIterator)
    public
      constructor Create(Collection: TBookCollection_SQLite; SystemData: ISystemData; const Mode: TSeriesIteratorMode);
      destructor Destroy; override;

    protected
      //
      // ISeriesIterator
      //
      function Next(out SeriesData: TSeriesData): Boolean;
      function RecordCount: Integer;

    strict private
      FCollection: TBookCollection_SQLite;
      FSystemData: ISystemData;
      FSeries: TSQLiteQuery;
      FCount: TSQLiteQuery;
      FCollectionID: Integer; // Active collection's ID at the time the iterator was created

      procedure PrepareData(const Mode: TSeriesIteratorMode);
    end;
    // << TSeriesIteratorImpl

  private const
    //
    // При изменении схемы базы данных необходимо изменить следующее значение
    //
    DATABASE_VERSION = '{FEC8CB6F-300A-4b92-86D1-7B40867F782B}';

  public
    class procedure CreateCollection(
      const SystemData: ISystemData;
      const DBFileName: string;
      CollectionType: COLLECTION_TYPE;
      const GenresFileName: string
    );

    class function IsValidCollection(
      const DBFileName: string;
      out CollectionType: COLLECTION_TYPE
    ): Boolean;

  public
    constructor Create(const CollectionInfo: TCollectionInfo; const SystemData: ISystemData);
    constructor CreateTemp(const DBFileName: string; const SystemData: ISystemData);
    destructor Destroy; override;

  protected
    //
    // IBookCollection
    //

    // Iterators:
    function GetAuthorIterator(const Mode: TAuthorIteratorMode; const FilterValue: PFilterValue = nil): IAuthorIterator; override;
    function GetGenreIterator(const Mode: TGenreIteratorMode; const FilterValue: PFilterValue = nil): IGenreIterator; override;
    function GetSeriesIterator(const Mode: TSeriesIteratorMode): ISeriesIterator;
    function GetBookIterator(const Mode: TBookIteratorMode; const LoadMemos: Boolean; const FilterValue: PFilterValue = nil): IBookIterator;
    function Search(const SearchCriteria: TBookSearchCriteria; const LoadMemos: Boolean): IBookIterator;

    //
    //
    //
    function InsertBook(BookRecord: TBookRecord; const CheckFileName: Boolean; const FullCheck: Boolean): Integer;
    procedure GetBookRecord(const BookKey: TBookKey; out BookRecord: TBookRecord; const LoadMemos: Boolean); override;
    procedure UpdateBook(BookRecord: TBookRecord);
    procedure DeleteBook(const BookKey: TBookKey);

    procedure UpdateAuthor(Author : PAuthorData);

    function GetReview(const BookKey: TBookKey): string;
    function SetReview(const BookKey: TBookKey; const Review: string): Integer;
    procedure SetAnnotation(const BookKey: TBookKey; const Annotation: string);
    function GetAnnotation(const BookKey: TBookKey): string;
    procedure SetProgress(const BookKey: TBookKey; const Progress: Integer);
    procedure SetRate(const BookKey: TBookKey; const Rate: Integer);
    procedure SetLocal(const BookKey: TBookKey; const AState: Boolean);
    procedure SetFolder(const BookKey: TBookKey; const Folder: string);
    procedure SetFileName(const BookKey: TBookKey; const FileName: string);
    procedure SetSeriesID(const BookKey: TBookKey; const SeriesID: Integer);

    //
    // манипуляции с авторами и жанрами книги
    //
    procedure SetBookAuthors(const BookID: Integer; const Authors: TBookAuthors; Replace: Boolean);
    procedure SetBookGenres(const BookID: Integer; const Genres: TBookGenres; Replace: Boolean);

    function FindOrCreateSeries(const Title: string): Integer;
    procedure SetSeriesTitle(const SeriesID: Integer; const NewSeriesTitle: string);
    procedure ChangeBookSeriesID(const OldSeriesID: Integer; const NewSeriesID: Integer; const DatabaseID: Integer);

    //
    // Свойства коллекции
    //
    procedure SetProperty(const PropID: TPropertyID; const Value: Variant);
    function GetProperty(const PropID: TPropertyID): Variant; override;
    procedure UpdateProperies;

    procedure ImportUserData(data: TUserData; guiUpdateCallback: TGUIUpdateExtraProc);
    procedure ExportUserData(data: TUserData);

    function CheckFileInCollection(const FileName: string; const FullNameSearch: Boolean; const ZipFolder: Boolean): Boolean;

    //
    // Bulk operation
    //
    procedure BeginBulkOperation;
    procedure EndBulkOperation(Commit: Boolean = True);

    procedure CompactDatabase;
    procedure RepairDatabase;
    procedure ReloadGenres(const FileName: string);
    procedure GetStatistics(out AuthorsCount: Integer; out BooksCount: Integer; out SeriesCount: Integer);

    procedure TruncateTablesBeforeImport;

    procedure StartBatchUpdate;
    procedure AfterBatchUpdate;
    procedure FinishBatchUpdate;

  protected
    procedure InsertGenreIfMissing(const GenreData: TGenreData); override;

  private
    FTriggersEnabled: Boolean;

  strict private
    FDatabase: TSQLiteDatabase;

    procedure InternalLoadGenres;
    procedure InternalUpdateField(const BookID: Integer; const UpdateSQL: string; const NewValue: string);
    procedure GetAuthor(AuthorID: Integer; var Author: TAuthorData);
    function GetSeriesTitle(SeriesID: Integer): string;
    function InsertAuthorIfMissing(const Author: TAuthorData): Integer;
    function IsFileNameConflict(const BookRecord: TBookRecord; const IncludeFolder: Boolean): Boolean;
  end;

implementation

uses
  SysUtils,
  Windows,
  Character,
  Generics.Collections,
  Variants,
  SQLite3,
  DateUtils,
  Math,
  StrUtils,
  IOUtils,
  unit_Consts,
  unit_Logger,
  unit_SearchUtils,
  dm_user,
  unit_Errors,
  unit_SQLiteUtils;

// Generate table structure and minimal data for a new collection
class procedure TBookCollection_SQLite.CreateCollection(
  const SystemData: ISystemData;
  const DBFileName: string;
  CollectionType: COLLECTION_TYPE;
  const GenresFileName: string
);
var
  ADatabase: TSQLiteDatabase;
  StringList: TStringList;
  StructureDDL: string;
  BookCollection: IBookCollection;
begin
  ADatabase := TSQLiteDatabase.Create(DBFileName);
  try
    StringList := ReadResourceAsStringList('CreateCollectionDB_SQLite');
    try
      ADatabase.Start;
      try
        for StructureDDL in StringList do
        begin
          if Trim(StructureDDL) <> '' then
            ADatabase.ExecSQL(StructureDDL);
        end;
        ADatabase.Commit;
      except
        ADatabase.Rollback;
        raise;
      end;
    finally
      FreeAndNil(StringList);
    end;
  finally
    FreeAndNil(ADatabase);
  end;

  //
  // Now that we have the DB structure in place, can create a collection instance
  //
  BookCollection := TBookCollection_SQLite.CreateTemp(DBFileName, SystemData);
  BookCollection.BeginBulkOperation;
  try
    //
    // Fill metadata version and creation date
    //
    BookCollection.SetProperty(PROP_SCHEMA_VERSION, DATABASE_VERSION);
    BookCollection.SetProperty(PROP_CODE, CollectionType);
    BookCollection.SetProperty(PROP_CREATIONDATE, Now);

    //
    // Fill the Genres table
    //
    BookCollection.LoadGenres(GenresFileName);

    BookCollection.EndBulkOperation(True);
  except
    BookCollection.EndBulkOperation(False);
    raise;
  end;
end;

class function TBookCollection_SQLite.IsValidCollection(
  const DBFileName: string;
  out CollectionType: COLLECTION_TYPE
  ): Boolean;
const
  GET_SETTING_SQL = 'SELECT SettingValue FROM Settings WHERE SettingID = ?';
var
  FDatabase: TSQLiteDatabase;
begin
  try
    FDatabase := TSQLiteDatabase.Create(DBFileName);
    try
      //
      // Получим из таблицы Settings значение версии и если оно совпадает, то считаем, что это нормальная коллекция
      //
      Result := (DATABASE_VERSION = FDatabase.QuerySingleString(GET_SETTING_SQL, [PROP_SCHEMA_VERSION]));
      if Result then
      begin
        CollectionType := FDatabase.QuerySingleInt(GET_SETTING_SQL, [PROP_CODE]);
      end;
    finally
      FDatabase.Free;
    end;
  except
    Result := False;
  end;
end;

// ------------------------------------------------------------------------------

{ TBookIteratorImpl }

constructor TBookCollection_SQLite.TBookIteratorImpl.Create(
  Collection: TBookCollection_SQLite;
  SystemData: ISystemData;
  const Mode: TBookIteratorMode;
  const LoadMemos: Boolean;
  const FilterValue: PFilterValue;
  const SearchCriteria: TBookSearchCriteria
);
begin
  inherited Create;

  Assert(Assigned(Collection));
  Assert(Assigned(SystemData));

  FLoadMemos := LoadMemos;
  FSystemData := SystemData;
  FCollection := Collection;
  FCollectionID := FCollection.CollectionID;
  Assert(FCollectionID > 0);

  if Mode = bmSearch then
  begin
    Assert(not Assigned(FilterValue));
    PrepareSearchData(SearchCriteria);
  end
  else
    PrepareData(Mode, FilterValue, SearchCriteria);
end;

destructor TBookCollection_SQLite.TBookIteratorImpl.Destroy;
begin
  FreeAndNil(FBooks);
  FreeAndNil(FCount);

  inherited Destroy;
end;

// Read next record (if present), return True if read
function TBookCollection_SQLite.TBookIteratorImpl.Next(out BookRecord: TBookRecord): Boolean;
var
  BookID: Integer;
begin
  Result := not FBooks.Eof;

  if Result then
  begin
    BookID := FBooks.FieldAsInt(0);
    FCollection.GetBookRecord(CreateBookKey(BookID, FCollectionID), BookRecord, FLoadMemos);
    FBooks.Next;
  end;
end;

function TBookCollection_SQLite.TBookIteratorImpl.RecordCount: Integer;
begin
  Assert(Assigned(FCount), 'Calling RecordCount more than once!');

  FCount.Open;
  Result := FCount.FieldAsInt(0);
  FreeAndNil(FCount);
end;

procedure TBookCollection_SQLite.TBookIteratorImpl.PrepareData(
  const Mode: TBookIteratorMode;
  const FilterValue: PFilterValue;
  const SearchCriteria: TBookSearchCriteria
);
var
  Where: string;
  SQLRows: string;
  SQLCount: string;

  procedure SetParams(query: TSQLiteQuery; const Mode: TBookIteratorMode);
  begin
    case Mode of
      bmByGenre:
      begin
        if isFB2Collection(FCollection.CollectionCode) or not Settings.ShowSubGenreBooks then
          query.SetParam(':GenreCode', FilterValue^.ValueString)
        else
          query.SetParam(':GenreCode', FilterValue^.ValueString + '%');
      end;

      bmByAuthor:
      begin
        query.SetParam(':AuthorID', FilterValue^.ValueInt);
      end;

      bmBySeries:
      begin
        query.SetParam(':SeriesID', FilterValue^.ValueInt);
      end;
    end;

    if Mode in [bmByGenre, bmByAuthor, bmBySeries] then
    begin
      if FCollection.GetHideDeleted then
        query.SetParam(':IsDeleted', False);

      if FCollection.GetShowLocalOnly then
        query.SetParam(':IsLocal', True);
    end;
  end;

begin
  Where := '';

  case Mode of
    bmAll:
    begin
      SQLRows := 'SELECT BookID FROM Books';
    end;

    bmByGenre:
    begin
      Assert(Assigned(FilterValue));
      SQLRows := 'SELECT DISTINCT b.BookID FROM Genre_List gl INNER JOIN Books b ON gl.BookID = b.BookID ';
      if isFB2Collection(FCollection.CollectionCode) or not Settings.ShowSubGenreBooks then
        AddToWhere(Where, 'gl.GenreCode = :GenreCode')
      else
        AddToWhere(Where, 'gl.GenreCode LIKE :GenreCode');
    end;

    bmByAuthor:
    begin
      Assert(Assigned(FilterValue));
      SQLRows := 'SELECT b.BookID FROM Author_List al INNER JOIN Books b ON al.BookID = b.BookID ';
      AddToWhere(Where, 'al.AuthorID = :AuthorID ');
    end;

    bmBySeries:
    begin
      Assert(Assigned(FilterValue));
      SQLRows := 'SELECT b.BookID FROM Books b ';
      AddToWhere(Where, 'b.SeriesID = :SeriesID ');
    end;

    else
      Assert(False);
  end;

  if Mode in [bmByGenre, bmByAuthor, bmBySeries] then
  begin
    if FCollection.GetHideDeleted then
      AddToWhere(Where, ' b.IsDeleted = :IsDeleted');

    if FCollection.GetShowLocalOnly then
      AddToWhere(Where, ' b.IsLocal = :IsLocal ');
  end;

  SQLRows := SQLRows + Where;
  SQLCount := 'SELECT COUNT(*) FROM (' + SQLRows + ') ROWS ';

  FCount := FCollection.FDatabase.NewQuery(SQLCount);
  SetParams(FCount, Mode);

  FBooks := FCollection.FDatabase.NewQuery(SQLRows);
  try
    SetParams(FBooks, Mode);
    FBooks.Open;
  except
    FreeAndNil(FBooks);
    raise;
  end;
end;

// Original code was extracted from TfrmMain.DoApplyFilter
procedure TBookCollection_SQLite.TBookIteratorImpl.PrepareSearchData(const SearchCriteria: TBookSearchCriteria);
const
  SQL_START_STR = 'SELECT DISTINCT b.BookID ';
  DT_FORMAT = 'yyyy-mm-dd';
var
  FilterString: string;
  SQLRows: string;
  SQLCount: string;
begin
  SQLRows := '';

  try
    // ------------------------ авторы ----------------------------------------
    FilterString := '';
    if SearchCriteria.FullName <> '' then
    begin
      AddToFilter('a.SearchName ',
      PrepareQuery(SearchCriteria.FullName, True),
        False, FilterString);
      if FilterString <> '' then
      begin
        FilterString := SQL_START_STR +
          ' FROM Authors a INNER JOIN Author_List b ON (a.AuthorID = b.AuthorID) WHERE '
          + FilterString;

        SQLRows := SQLRows + FilterString;
      end;
    end;

    // ------------------------ серия -----------------------------------------
    FilterString := '';
    if SearchCriteria.Series <> '' then
    begin
      AddToFilter('s.SearchSeriesTitle', PrepareQuery(SearchCriteria.Series, True), False, FilterString);

      if FilterString <> '' then
      begin
        FilterString := SQL_START_STR +
          ' FROM Series s JOIN Books b ON b.SeriesID = s.SeriesID WHERE ' +
           FilterString;
              if SQLRows <> '' then
          SQLRows := SQLRows + ' INTERSECT ';

        SQLRows := SQLRows + FilterString;
      end;
    end;

    // -------------------------- жанр ----------------------------------------
    FilterString := '';
    if (SearchCriteria.Genre <> '') then
    begin
      FilterString := SQL_START_STR +
        ' FROM Genre_List g JOIN Books b ON b.BookID = g.BookID WHERE (' +
       SearchCriteria.Genre + ')';

      if SQLRows <> '' then
        SQLRows := SQLRows + ' INTERSECT ';

      SQLRows := SQLRows + FilterString;
    end;

    // -------------------  все остальное   -----------------------------------
    FilterString := '';
    AddToFilter('b.SearchAnnotation', PrepareQuery(SearchCriteria.Annotation, True), False, FilterString);
    AddToFilter('b.SearchTitle', PrepareQuery(SearchCriteria.Title, True), False, FilterString);
    AddToFilter('b.SearchFileName', PrepareQuery(SearchCriteria.FileName, True), False, FilterString);
    AddToFilter('b.SearchFolder', PrepareQuery(SearchCriteria.Folder, True), False, FilterString);
    AddToFilter('b.SearchExt', PrepareQuery(SearchCriteria.FileExt, True), False, FilterString);
    AddToFilter('b.SearchLang', PrepareQuery(SearchCriteria.Lang, True, False), False, FilterString);
    AddToFilter('b.LibRate', PrepareQuery(SearchCriteria.LibRate, False, False), False, FilterString);
    AddToFilter('b.SearchKeyWords', PrepareQuery(SearchCriteria.KeyWord, True), False, FilterString);
    //
    if SearchCriteria.DateIdx = -1 then
      AddToFilter('b.UpdateDate', PrepareQuery(SearchCriteria.DateText, False), False, FilterString)
    else
      case SearchCriteria.DateIdx of
        0: AddToFilter('b.UpdateDate', Format('> "%s"', [FormatDateTime(DT_FORMAT, IncDay(Now, -1))]), False, FilterString);
        1: AddToFilter('b.UpdateDate', Format('> "%s"', [FormatDateTime(DT_FORMAT, IncDay(Now, -3))]), False, FilterString);
        2: AddToFilter('b.UpdateDate', Format('> "%s"', [FormatDateTime(DT_FORMAT, IncDay(Now, -7))]), False, FilterString);
        3: AddToFilter('b.UpdateDate', Format('> "%s"', [FormatDateTime(DT_FORMAT, IncDay(Now, -14))]), False, FilterString);
        4: AddToFilter('b.UpdateDate', Format('> "%s"', [FormatDateTime(DT_FORMAT, IncDay(Now, -30))]), False, FilterString);
        5: AddToFilter('b.UpdateDate', Format('> "%s"', [FormatDateTime(DT_FORMAT, IncDay(Now, -90))]), False, FilterString);
      end;

    case SearchCriteria.DownloadedIdx of
      1: AddToFilter('b.IsLocal ', '= 1', False, FilterString);
      2: AddToFilter('b.IsLocal ', '= 0', False, FilterString);
    end;

    if SearchCriteria.Deleted then
      AddToFilter('b.IsDeleted ', '= 0', False, FilterString);

     // Книга прочитанна
    if SearchCriteria.Readed then
     AddToFilter('b.Progress ', '> 0', False, FilterString);

    if FilterString <> '' then
    begin
      if SQLRows <> '' then
        SQLRows := SQLRows + ' INTERSECT ';
      SQLRows := SQLRows + SQL_START_STR + ' FROM Books b WHERE ' + FilterString;
    end;
  except
    on E: Exception do
      raise Exception.Create(rstrFilterParamError);
  end;

  if SQLRows = '' then
    raise Exception.Create(rstrCheckFilterParams);

  // InitRows - workaround for the need to reset params between invocations to receive a new dataset
  SQLCount := 'SELECT COUNT(*) FROM (' + SQLRows + ') ROWS ';
  FCount := FCollection.FDatabase.NewQuery(SQLCount);

  FBooks := FCollection.FDatabase.NewQuery(SQLRows);
  FBooks.Open;
end;

{ TAuthorIteratorImpl }

constructor TBookCollection_SQLite.TAuthorIteratorImpl.Create(
  Collection: TBookCollection_SQLite;
  SystemData: ISystemData;
  const Mode: TAuthorIteratorMode;
  const FilterValue: PFilterValue
);
begin
  inherited Create;

  Assert(Assigned(Collection));
  Assert(Assigned(SystemData));

  FSystemData := SystemData;
  FCollection := Collection;
  FCollectionID := FCollection.CollectionID;
  Assert(FCollectionID > 0);

  PrepareData(Mode, FilterValue);
end;

destructor TBookCollection_SQLite.TAuthorIteratorImpl.Destroy;
begin
  FreeAndNil(FAuthors);
  FreeAndNil(FCount);

  inherited Destroy;
end;

// Read next record (if present), return True if read
function TBookCollection_SQLite.TAuthorIteratorImpl.Next(out AuthorData: TAuthorData): Boolean;
begin
  Result := not FAuthors.Eof;

  if Result then
  begin
    AuthorData.AuthorID := FAuthors.FieldAsInt(0);
    AuthorData.LastName := FAuthors.FieldAsString(1);
    AuthorData.FirstName := FAuthors.FieldAsString(2);
    AuthorData.MiddleName := FAuthors.FieldAsString(3);

    FAuthors.Next;
  end;
end;

function TBookCollection_SQLite.TAuthorIteratorImpl.RecordCount: Integer;
begin
  Assert(Assigned(FCount), 'Calling RecordCount more than once!');

  FCount.Open;
  Result := FCount.FieldAsInt(0);
  FreeAndNil(FCount);
end;

procedure TBookCollection_SQLite.TAuthorIteratorImpl.PrepareData(const Mode: TAuthorIteratorMode; const FilterValue: PFilterValue);
var
  FromList: string;
  Where: string;
  SQLRows: string;
  SQLCount: string;

  procedure SetParams(query: TSQLiteQuery; const Mode: TAuthorIteratorMode);
  begin
    case Mode of
      amByBook:
        begin
          query.SetParam(0, FilterValue^.ValueInt);
        end;

      amFullFilter:
        begin
          if FCollection.GetHideDeleted then
            query.SetParam(':IsDeleted', False);

          if FCollection.GetShowLocalOnly then
            query.SetParam(':IsLocal', True);

          if
            (FCollection.GetAuthorFilterType <> '') and
            (FCollection.GetAuthorFilterType <> ALPHA_FILTER_ALL) and
            (FCollection.GetAuthorFilterType <> ALPHA_FILTER_NON_ALPHA)
          then
            query.SetParam(':FilterType', FCollection.GetAuthorFilterType + '%');
        end;
    end;
  end;

begin
  Where := '';

  case Mode of
    amAll:
      begin
        SQLRows := 'SELECT AuthorID, LastName, FirstName, MiddleName FROM Authors ORDER BY LastName, FirstName, MiddleName';
        SQLCount := 'SELECT COUNT(*) FROM Authors';
      end;

    amByBook:
      begin
        Assert(Assigned(FilterValue));
        SQLRows := 'SELECT a.AuthorID, a.LastName, a.FirstName, a.MiddleName FROM Author_List al INNER JOIN Authors a ON al.AuthorID = a.AuthorID WHERE BookID = :v0 ORDER BY a.LastName, a.FirstName, a.MiddleName ';
//        SQLRows := 'SELECT a.AuthorID, a.LastName, a.FirstName, a.MiddleName FROM Author_List al INNER JOIN Authors a ON al.AuthorID = a.AuthorID WHERE BookID = :v0 ';
        SQLCount := 'SELECT COUNT(*) FROM Author_List WHERE BookID = :v0';
      end;

    amFullFilter:
      begin
        FromList := 'Author_List al ';
        if FCollection.GetHideDeleted or FCollection.GetShowLocalOnly then
          FromList := FromList + 'INNER JOIN Books b ON al.BookID = b.BookID ';
        FromList := FromList + 'INNER JOIN Authors a ON a.AuthorID = al.AuthorID ';

        if FCollection.GetHideDeleted then
          AddToWhere(Where, ' b.IsDeleted = :IsDeleted ');

        if FCollection.GetShowLocalOnly then
          AddToWhere(Where, ' b.IsLocal = :IsLocal ');

        if FCollection.GetAuthorFilterType = ALPHA_FILTER_NON_ALPHA then
        begin
          AddToWhere(Where,
            '(SUBSTR(a.SearchName, 1, 1) NOT IN (' + LATIN_ALPHABET_SEPARATORS + ')) AND ' +
            '(SUBSTR(a.SearchName, 1, 1) NOT IN (' + CYRILLIC_ALPHABET_SEPARATORS + '))'
          );
        end
        else if (FCollection.GetAuthorFilterType <> '') and (FCollection.GetAuthorFilterType <> ALPHA_FILTER_ALL) then
        begin
          Assert(Length(FCollection.GetAuthorFilterType) = 1);
          Assert(TCharacter.IsUpper(FCollection.GetAuthorFilterType, 1));
          // TODO -cSQL performance: не оптимизируется при использовании выражения
          AddToWhere(Where,
            'a.SearchName LIKE :FilterType'  // начинается на заданную букву
          );
        end;

        SQLRows := 'SELECT DISTINCT a.AuthorID FROM ' + FromList + Where;
        SQLCount := 'SELECT COUNT(*) FROM (' + SQLRows + ') ROWS ';
        SQLRows := 'SELECT DISTINCT a.AuthorID, a.LastName, a.FirstName, a.MiddleName FROM ' + FromList + Where + ' ORDER BY a.LastName, a.FirstName, a.MiddleName ';
//        SQLRows := 'SELECT DISTINCT a.AuthorID, a.LastName, a.FirstName, a.MiddleName FROM ' + FromList + Where;

      end;

    else
      Assert(False);
  end;

  FCount := FCollection.FDatabase.NewQuery(SQLCount);
  SetParams(FCount, Mode);

  FAuthors := FCollection.FDatabase.NewQuery(SQLRows);
  try
    SetParams(FAuthors, Mode);
    FAuthors.Open;
  except
    FreeAndNil(FAuthors);
    raise;
  end;
end;

{ TGenreIteratorImpl }

constructor TBookCollection_SQLite.TGenreIteratorImpl.Create(Collection: TBookCollection_SQLite; SystemData: ISystemData; const Mode: TGenreIteratorMode; const FilterValue: PFilterValue);
begin
  inherited Create;

  Assert(Assigned(Collection));
  Assert(Assigned(SystemData));

  FSystemData := SystemData;
  FCollection := Collection;
  FCollectionID := FCollection.CollectionID;
  Assert(FCollectionID > 0);

  PrepareData(Mode, FilterValue);
end;

destructor TBookCollection_SQLite.TGenreIteratorImpl.Destroy;
begin
  FreeAndNil(FGenres);
  FreeAndNil(FCount);

  inherited Destroy;
end;

// Read next record (if present), return True if read
function TBookCollection_SQLite.TGenreIteratorImpl.Next(out GenreData: TGenreData): Boolean;
var
  GenreCode: String;
begin
  Result := not FGenres.Eof;

  if Result then
  begin
    GenreCode := FGenres.FieldAsString(0);
    FCollection.GetGenre(GenreCode, GenreData);
    FGenres.Next;
  end;
end;

function TBookCollection_SQLite.TGenreIteratorImpl.RecordCount: Integer;
begin
  Assert(Assigned(FCount), 'Calling RecordCount more than once!');

  FCount.Open;
  Result := FCount.FieldAsInt(0);
  FreeAndNil(FCount);
end;

procedure TBookCollection_SQLite.TGenreIteratorImpl.PrepareData(const Mode: TGenreIteratorMode; const FilterValue: PFilterValue);
var
  SQLRows: String;
  SQLCount: String;
begin
  case Mode of
    gmAll:
    begin
      SQLRows := 'SELECT GenreCode FROM Genres';
      SQLCount := 'SELECT COUNT(*) FROM Genres';
    end;

    gmByBook:
    begin
      Assert(Assigned(FilterValue));
      SQLRows := 'SELECT GenreCode FROM Genre_List WHERE BookID = :v0';
      SQLCount := 'SELECT COUNT(*) FROM Genre_List WHERE BookID = :v0';
    end;

    else
      Assert(False);
  end;

  FCount := FCollection.FDatabase.NewQuery(SQLCount);
  if Mode = gmByBook then
    FCount.SetParam(0, FilterValue^.ValueInt);

  FGenres := FCollection.FDatabase.NewQuery(SQLRows);
  try
    if Mode = gmByBook then
      FGenres.SetParam(0, FilterValue^.ValueInt);
    FGenres.Open;
  except
    FreeAndNil(FGenres);
    raise;
  end;
end;

{ TSeriesIteratorImpl }

constructor TBookCollection_SQLite.TSeriesIteratorImpl.Create(Collection: TBookCollection_SQLite; SystemData: ISystemData; const Mode: TSeriesIteratorMode);
begin
  inherited Create;

  Assert(Assigned(Collection));
  Assert(Assigned(SystemData));

  FSystemData := SystemData;
  FCollection := Collection;
  FCollectionID := FCollection.CollectionID;
  Assert(FCollectionID > 0);

  PrepareData(Mode);
end;

destructor TBookCollection_SQLite.TSeriesIteratorImpl.Destroy;
begin
  FreeAndNil(FSeries);
  FreeAndNil(FCount);

  inherited Destroy;
end;

// Read next record (if present), return True if read
function TBookCollection_SQLite.TSeriesIteratorImpl.Next(out SeriesData: TSeriesData): Boolean;
begin
  Result := not FSeries.Eof;

  if Result then
  begin
    SeriesData.SeriesID := FSeries.FieldAsInt(0);
    SeriesData.SeriesTitle := FSeries.FieldAsString(1);
    FSeries.Next;
  end;
end;

function TBookCollection_SQLite.TSeriesIteratorImpl.RecordCount: Integer;
begin
  Assert(Assigned(FCount), 'Calling RecordCount more than once!');

  FCount.Open;
  Result := FCount.FieldAsInt(0);
  FreeAndNil(FCount);
end;

procedure TBookCollection_SQLite.TSeriesIteratorImpl.PrepareData(const Mode: TSeriesIteratorMode);
var
  Where: string;
  SQLRows: string;
  SQLCount: string;

  procedure SetParams(query: TSQLiteQuery; const Mode: TSeriesIteratorMode);
  begin
    if Mode = smFullFilter then
    begin
      if FCollection.GetHideDeleted then
        query.SetParam(':IsDeleted', False);

      if FCollection.GetShowLocalOnly then
        query.SetParam(':IsLocal', True);

      if
        (FCollection.GetSeriesFilterType <> '') and
        (FCollection.GetSeriesFilterType <> ALPHA_FILTER_NON_ALPHA) and
        (FCollection.GetSeriesFilterType <> ALPHA_FILTER_ALL)
      then
        query.SetParam(':FilterType', FCollection.GetSeriesFilterType + '%');
    end;
  end;

begin
  Where := '';

  case Mode of
    smAll:
    begin
      SQLRows := 'SELECT SeriesID, SeriesTitle FROM Series ORDER BY SeriesTitle';
      SQLCount := 'SELECT COUNT(*) FROM Series';
    end;

    smFullFilter:
    begin
      SQLRows := 'SELECT DISTINCT s.SeriesID, s.SeriesTitle FROM Series s ';
      if FCollection.GetHideDeleted or FCollection.GetShowLocalOnly then
      begin
        SQLRows := SQLRows + ' INNER JOIN Books b ON s.SeriesID = b.SeriesID ';
        if FCollection.GetHideDeleted then
          AddToWhere(Where, ' b.IsDeleted = :IsDeleted ');

        if FCollection.GetShowLocalOnly then
          AddToWhere(Where, ' b.IsLocal = :IsLocal ');
      end;

      // Series type filter
      if FCollection.GetSeriesFilterType <> '' then
      begin
        if FCollection.GetSeriesFilterType = ALPHA_FILTER_NON_ALPHA then
        begin
          AddToWhere(Where,
            '(SUBSTR(s.SearchSeriesTitle, 1, 1) NOT IN (' + LATIN_ALPHABET_SEPARATORS + ')) AND ' +
            '(SUBSTR(s.SearchSeriesTitle, 1, 1) NOT IN (' + CYRILLIC_ALPHABET_SEPARATORS + '))'
          );
        end
        else if FCollection.GetSeriesFilterType <> ALPHA_FILTER_ALL then
        begin
          Assert(Length(FCollection.GetSeriesFilterType) = 1);
          Assert(TCharacter.IsUpper(FCollection.GetSeriesFilterType, 1));
          // TODO -cSQL performance: не оптимизируется при использовании выражения
          AddToWhere(Where,
            's.SearchSeriesTitle LIKE :FilterType'   // начинается на заданную букву
          );
        end;
      end;

      SQLRows := SQLRows + Where;
      SQLCount := 'SELECT COUNT(*) FROM (' + SQLRows + ') ROWS ';
      SQLRows := SQLRows + ' ORDER BY s.SeriesTitle';
    end;

    else
      Assert(False);
  end;

  FCount := FCollection.FDatabase.NewQuery(SQLCount);
  SetParams(FCount, Mode);
  FCount.Open;

  FSeries := FCollection.FDatabase.NewQuery(SQLRows);
  try
    SetParams(FSeries, Mode);
    FSeries.Open;
  except
    FreeAndNil(FSeries);
    raise;
  end;
end;

//-----------------------------------------------------------------------------

{ TBookCollection_SQLite }
function CreateFullAuthorName(pCtx: TSQLite3Context; nArgs: Integer; Args: TSQLite3Value): string; inline;
var
  LastName: string;
  FirstName: string;
  MiddleName: string;
begin
  LastName := SQLite3_Value_text16(Args^); Inc(Args);
  FirstName := SQLite3_Value_text16(Args^); Inc(Args);
  MiddleName := SQLite3_Value_text16(Args^);

  Result := TAuthorData.FormatName(LastName, FirstName, MiddleName);
end;

procedure fullAuthorName(pCtx: TSQLite3Context; nArgs: Integer; Args: TSQLite3Value); cdecl;
var
  FullName: string;
begin
  FullName := CreateFullAuthorName(pCtx, nArgs, Args);
  SQLite3_Result_Text16(pCtx, PWideChar(FullName), -1, SQLITE_TRANSIENT);
end;

procedure fullAuthorNameEx(pCtx: TSQLite3Context; nArgs: Integer; Args: TSQLite3Value); cdecl;
var
  FullName: string;
begin
  FullName := TCharacter.ToUpper(CreateFullAuthorName(pCtx, nArgs, Args));
  SQLite3_Result_Text16(pCtx, PWideChar(FullName), -1, SQLITE_TRANSIENT);
end;

procedure getIsTriggersOn(pCtx: TSQLite3Context; nArgs: Integer; Args: TSQLite3Value); cdecl;
var
  db: TBookCollection_SQLite;
begin
  db := TBookCollection_SQLite(SQLite3_User_Data(pCtx));
  if Assigned(db) then
    SQLite3_Result_Int(pCtx, IfThen(db.FTriggersEnabled, 1, 0))
  else
    SQLite3_Result_Int(pCtx, 1);
end;

constructor TBookCollection_SQLite.Create(const CollectionInfo: TCollectionInfo; const SystemData: ISystemData);
begin
  Assert(Assigned(SystemData));

  inherited Create(SystemData, CollectionInfo);

  FDatabase := TSQLiteDatabase.Create(CollectionInfo.DBFileName);

  FTriggersEnabled := True;

  FDatabase.AddFunction('MHL_FULLNAME',    3, fullAuthorName);
  FDatabase.AddFunction('MHL_FULLNAME',    4, fullAuthorNameEx);
  FDatabase.AddFunction('MHL_TRIGGERS_ON', 0, getIsTriggersOn, SQLITE_ANY, Self);

  InternalLoadGenres;
end;

constructor TBookCollection_SQLite.CreateTemp(const DBFileName: string; const SystemData: ISystemData);
begin
  Assert(Assigned(SystemData));

  inherited CreateTemp(SystemData);

  FDatabase := TSQLiteDatabase.Create(DBFileName);

  FTriggersEnabled := True;

  FDatabase.AddFunction('MHL_FULLNAME',    3, fullAuthorName);
  FDatabase.AddFunction('MHL_FULLNAME',    4, fullAuthorNameEx);
  FDatabase.AddFunction('MHL_TRIGGERS_ON', 0, getIsTriggersOn, SQLITE_ANY, Self);

  InternalLoadGenres;
end;

destructor TBookCollection_SQLite.Destroy;
begin
  FreeAndNil(FDatabase);

  inherited Destroy;
end;

procedure TBookCollection_SQLite.SetProperty(const PropID: TPropertyID; const Value: Variant);
const
  SQL_DELETE = 'DELETE FROM Settings WHERE SettingID = ?';
  SQL_INSERT = 'INSERT INTO Settings (SettingID, SettingValue) VALUES (?, ?)';
var
  query: TSQLiteQuery;
begin
  if isCollectionProp(PropID) then
  begin
    FDatabase.ExecSQL(SQL_DELETE, [PropID]);

    if VarIsNull(Value) or VarIsEmpty(Value) then
      Exit;

    query := FDatabase.NewQuery(SQL_INSERT);
    try
      query.SetParam(0, PropID);

      case propertyType(PropID) of
        PROP_TYPE_INTEGER:  query.SetParam(1, Integer(Value));
        PROP_TYPE_DATETIME: query.SetParam(1, TDateTime(Value));
        PROP_TYPE_BOOLEAN:  query.SetParam(1, Boolean(Value));
        PROP_TYPE_STRING:   query.SetParam(1, string(Value));
      end;

      query.ExecSQL;
    finally
      query.Free;
    end;
  end;

  if isSystemProp(PropID) and (INVALID_COLLECTION_ID <>  CollectionID) then
  begin
    FSystemData.SetProperty(CollectionID, PropID, Value);
  end;
end;

function TBookCollection_SQLite.GetProperty(const PropID: TPropertyID): Variant;
const
  SQL = 'SELECT SettingValue FROM Settings WHERE SettingID = ?';
var
  query: TSQLiteQuery;
begin
  if isCollectionProp(PropID) then
  begin
    query := FDatabase.NewQuery(SQL);
    try
      query.SetParam(0, PropID);

      query.Open;
      if not query.Eof then
      begin
        case propertyType(PropID) of
          PROP_TYPE_INTEGER:  Result := query.FieldAsInt(0);
          PROP_TYPE_DATETIME: Result := query.FieldAsDateTime(0);
          PROP_TYPE_BOOLEAN:  Result := query.FieldAsBoolean(0);
          PROP_TYPE_STRING:   Result := query.FieldAsString(0);
        end;
      end;
    finally
      query.Free;
    end;
  end
  else
  begin
    Assert(INVALID_COLLECTION_ID <>  CollectionID);
    Result := FSystemData.GetProperty(CollectionID, PropID);
  end;
end;

procedure TBookCollection_SQLite.UpdateProperies;
const
  SQL = 'SELECT SettingID, SettingValue FROM Settings';
var
  query: TSQLiteQuery;
  PropID: TPropertyID;
  Value: Variant;
begin
  query := FDatabase.NewQuery(SQL);
  try
    query.Open;

    while not query.Eof do
    begin
      PropID := query.FieldAsInt(0);
      if isSystemProp(PropID) then
      begin
        case propertyType(PropID) of
          PROP_TYPE_INTEGER:  Value := query.FieldAsInt(1);
          PROP_TYPE_DATETIME: Value := query.FieldAsDateTime(1);
          PROP_TYPE_BOOLEAN:  Value := query.FieldAsBoolean(1);
          PROP_TYPE_STRING:   Value := query.FieldAsString(1);
        end;
        FSystemData.SetProperty(CollectionID, PropID, Value);
      end;
      query.Next;
    end;
  finally
    query.Free;
  end;
end;

procedure TBookCollection_SQLite.ImportUserData(data: TUserData; guiUpdateCallback: TGUIUpdateExtraProc);
var
  extra: TBookExtra;
  group: TBookGroup;
  groupBook: TGroupBook;
  Sql: string;
  query: TSQLiteQuery;
  BookKey: TBookKey;

  function GetBookKey(bookInfo: TBookInfo; out BookKey: TBookKey): Boolean;
  const
    SQL_BY_BOOKID = 'SELECT b.BookID FROM Books b WHERE b.BookID = ?';
    SQL_BY_LIBID = 'SELECT b.BookID FROM Books b WHERE b.LibID = ?';
  var
    query: TSQLiteQuery;
    BookID: Integer;
  begin
    query := FDatabase.NewQuery(IfThen(bookInfo.LibID = '', SQL_BY_BOOKID, SQL_BY_LIBID));
    try
      if bookInfo.LibID = '' then
        query.SetParam(0, bookInfo.BookID)
      else
        query.SetParam(0, bookInfo.LibID);
      query.Open;
      if query.Eof then
        BookID := 0
      else
        BookID := query.FieldAsInt(0);
    finally
      query.Free;
    end;

    Result := BookID > 0;
    if Result then
    begin
      BookKey := CreateBookKey(BookID, CollectionID);
    end;
  end;

begin
  Assert(Assigned(data));

  //
  // Заполним рейтинги, review и признак прочитанности
  //
  for extra in data.Extras do
  begin
    Sql := ''; //UPDATE Books SET
    if GetBookKey(extra, BookKey) then
    begin
      if extra.Rating <> 0 then
        Sql := 'Rate = :NewRate ';

      if extra.Progress <> 0 then
      begin
        if Sql <> '' then
          Sql := Sql + ', ';
        Sql := Sql + 'Progress = :NewProgress ';
      end;

      if Sql <> '' then
      begin
        Sql := 'UPDATE Books SET ' + Sql + ' WHERE BookID = :BookID ';

        query := FDatabase.NewQuery(Sql);
        try
          if extra.Rating <> 0 then
            query.SetParam(':NewRate', extra.Rating);

          if extra.Progress <> 0 then
            query.SetParam(':NewProgress', extra.Progress);

          query.SetParam(':BookID', BookKey.BookID);

          query.ExecSQL;
        finally
          query.Free;
        end;
      end;

      if extra.Review <> '' then
        SetReview(BookKey, extra.Review);
    end;

    //
    // Обновим информацию в группах
    //
    FSystemData.SetExtra(BookKey, extra);

    //
    // Дадим возможность главному окну обновить измененные ноды
    //
    if Assigned(guiUpdateCallback) then
      guiUpdateCallback(BookKey, extra);
  end;

  //
  // Создадим пользовательские группы
  //
  FSystemData.ImportUserData(data);

  //
  // Добавим книги в группы
  //
  for group in data.Groups do
  begin
    for groupBook in group do
    begin
      if GetBookKey(groupBook, BookKey) then
      begin
        AddBookToGroup(BookKey, group.GroupID);
      end;
    end;
  end;
end;

procedure TBookCollection_SQLite.ExportUserData(data: TUserData);
const
  SQL = 'SELECT b.BookID, b.LibID, b.Rate, b.Progress, b.Review FROM Books b ' +
    'WHERE b.Rate > 0 OR b.Progress > 0 OR b.Review IS NOT NULL ' +
    'ORDER BY b.BookID ';
var
  query: TSQLiteQuery;
begin
  Assert(Assigned(data));

  query := FDatabase.NewQuery(SQL);
  try
    query.Open;
    while not query.Eof do
    begin
      data.Extras.AddExtra(
        query.FieldAsInt(0),        // BookID
        query.FieldAsString(1),     // LibID
        query.FieldAsInt(2),        // Rate
        query.FieldAsInt(3),        // Progress
        query.FieldAsBlobString(4)  // Review
      );
      query.Next;
    end;
  finally
    query.Free;
  end;
  FSystemData.ExportUserData(data, CollectionID);
end;

function TBookCollection_SQLite.CheckFileInCollection(const FileName: string; const FullNameSearch: Boolean; const ZipFolder: Boolean): Boolean;
const
  SQL_BY_FOLDER = 'SELECT 1 FROM Books b WHERE b.Folder = ?';
  SQL_BY_FILENAME = 'SELECT 1 FROM Books b WHERE b.FileName = ?';
var
  S: string;
  query: TSQLiteQuery;
begin
  query := FDatabase.NewQuery(IfThen(ZipFolder, SQL_BY_FOLDER, SQL_BY_FILENAME));
  try
    if ZipFolder then
      S := FileName
    else if FullNameSearch then
      S := ExtractFileName(FileName)
    else
      S := TPath.GetFileNameWithoutExtension(FileName);

    query.SetParam(0, s);

    query.Open;

    Result := not query.Eof;
  finally
    query.Free;
  end;
end;

function TBookCollection_SQLite.IsFileNameConflict(const BookRecord: TBookRecord; const IncludeFolder: Boolean): Boolean;
const
  SQL_SELECT_BY_FOLDER_AND_FILENAME = 'SELECT 1 FROM Books b WHERE b.FileName = ? AND b.Folder = ?';
  SQL_SELECT_BY_FILENAME = 'SELECT 1 FROM Books b WHERE b.FileName = ?';
var
  query: TSQLiteQuery;
begin
  query := FDatabase.NewQuery(IfThen(IncludeFolder, SQL_SELECT_BY_FOLDER_AND_FILENAME, SQL_SELECT_BY_FILENAME));
  try
    query.SetParam(0, BookRecord.FileName);
    if IncludeFolder then
      query.SetParam(1, BookRecord.Folder);

    query.Open;

    Result := not query.Eof;
  finally
    query.Free;
  end;
end;

procedure TBookCollection_SQLite.InsertGenreIfMissing(const GenreData: TGenreData);
const
  SQL_INSERT = 'INSERT INTO Genres (GenreCode, ParentCode, FB2Code, GenreAlias) VALUES(?, ?, ?, ?)';
var
  insertQuery: TSQLiteQuery;
begin
  //
  // Если такой жанр уже существует => пропустим его
  //
  { TODO -oNickR : может стоит проверить и остальные поля? }
  if FGenreCache.HasGenre(GenreData.GenreCode) then
    Exit;

  insertQuery := FDatabase.NewQuery(SQL_INSERT);
  try
    insertQuery.SetParam(0, GenreData.GenreCode);
    insertQuery.SetParam(1, GenreData.ParentCode);
    insertQuery.SetParam(2, GenreData.FB2GenreCode);
    insertQuery.SetParam(3, GenreData.GenreAlias);
    insertQuery.ExecSQL;

    FGenreCache.Add(GenreData);
  finally
    insertQuery.Free;
  end;
end;

procedure TBookCollection_SQLite.InternalLoadGenres;
const
  SQL = 'SELECT GenreCode, ParentCode, FB2Code, GenreAlias FROM Genres';
var
  query: TSQLiteQuery;
  Genre: TGenreData;
begin
  FGenreCache.Clear;

  query := FDatabase.NewQuery(SQL);
  try
    query.Open;
    while not query.EOF do
    begin
      Genre.GenreCode := query.FieldAsString(0);
      Genre.ParentCode := query.FieldAsString(1);
      Genre.FB2GenreCode := query.FieldAsString(2);
      Genre.GenreAlias := query.FieldAsString(3);

      FGenreCache.Add(Genre);

      query.Next;
    end;
  finally
    FreeAndNil(query);
  end;
end;

function TBookCollection_SQLite.GetBookIterator(const Mode: TBookIteratorMode; const LoadMemos: Boolean; const FilterValue: PFilterValue = nil): IBookIterator;
var
  EmptySearchCriteria: TBookSearchCriteria;
begin
  Result := TBookIteratorImpl.Create(Self, FSystemData, Mode, LoadMemos, FilterValue, EmptySearchCriteria);
end;

function TBookCollection_SQLite.Search(const SearchCriteria: TBookSearchCriteria; const LoadMemos: Boolean): IBookIterator;
begin
  Result := TBookIteratorImpl.Create(Self, FSystemData, bmSearch, LoadMemos, nil, SearchCriteria);
end;

function TBookCollection_SQLite.GetAuthorIterator(const Mode: TAuthorIteratorMode; const FilterValue: PFilterValue = nil): IAuthorIterator;
begin
  Result := TAuthorIteratorImpl.Create(Self, FSystemData, Mode, FilterValue);
end;

function TBookCollection_SQLite.GetSeriesIterator(const Mode: TSeriesIteratorMode): ISeriesIterator;
begin
  Result := TSeriesIteratorImpl.Create(Self, FSystemData, Mode);
end;

function TBookCollection_SQLite.GetGenreIterator(const Mode: TGenreIteratorMode; const FilterValue: PFilterValue = nil): IGenreIterator;
begin
  Result := TGenreIteratorImpl.Create(Self, FSystemData, Mode, FilterValue);
end;

function TBookCollection_SQLite.GetAnnotation(const BookKey: TBookKey): string;
const
  SQL = 'SELECT Annotation FROM Books WHERE BookID = ?';
var
  query: TSQLiteQuery;
begin
  if BookKey.DatabaseID = CollectionID then
  begin
    query := FDatabase.NewQuery(SQL);
    try
      query.SetParam(0, BookKey.BookID);
      query.Open;

      if not query.Eof then
        Result := query.FieldAsBlobString(0)
      else
        Result := '';
    finally
      query.Free;
    end;
  end
  else
    Result := FSystemData.GetAnnotation(BookKey);

end;

procedure TBookCollection_SQLite.GetAuthor(AuthorID: Integer; var Author: TAuthorData);
const
  SQL = 'SELECT LastName, FirstName, MiddleName FROM Authors WHERE AuthorID = ?';
var
  query: TSQLiteQuery;
begin
  query := FDatabase.NewQuery(SQL);
  try
    query.SetParam(0, AuthorID);
    query.Open;

    if not query.Eof then
    begin
      Author.AuthorID := AuthorID;
      Author.LastName := query.FieldAsString(0);
      Author.FirstName := query.FieldAsString(1);
      Author.MiddleName := query.FieldAsString(2);
    end
    else
      Author.Clear;
  finally
    FreeAndNil(query);
  end;
end;

// Insert an Author if the name combination doesn't exist
// Return AuthorID of the existing/added Author record
function TBookCollection_SQLite.InsertAuthorIfMissing(const Author: TAuthorData): Integer;
const
  SQL_SELECT = 'SELECT AuthorID FROM Authors WHERE LastName = ? AND FirstName = ? AND MiddleName = ?';
  SQL_INSERT = 'INSERT INTO Authors (LastName, FirstName, MiddleName) VALUES(?, ?, ?)';
var
  searchQuery: TSQLiteQuery;
  insertQuery: TSQLiteQuery;
begin
  searchQuery := FDatabase.NewQuery(SQL_SELECT);
  try
    searchQuery.SetParam(0, Author.LastName);
    searchQuery.SetParam(1, Author.FirstName);
    searchQuery.SetParam(2, Author.MiddleName);
    searchQuery.Open;

    if searchQuery.Eof then
    begin
      insertQuery := FDatabase.NewQuery(SQL_INSERT);
      try
        insertQuery.SetParam(0, Author.LastName);
        insertQuery.SetParam(1, Author.FirstName);
        insertQuery.SetParam(2, Author.MiddleName);
        insertQuery.ExecSQL;

        Result := FDatabase.LastInsertRowID;
      finally
        insertQuery.Free;
      end;
    end
    else
      Result := searchQuery.FieldAsInt(0);
  finally
    searchQuery.Free;
  end;
end;

function TBookCollection_SQLite.FindOrCreateSeries(const Title: string): Integer;
const
  SQL_SELECT = 'SELECT SeriesID FROM Series WHERE SeriesTitle = ?';
  SQL_INSERT = 'INSERT INTO Series (SeriesTitle) VALUES (?)';
var
  searchQuery: TSQLiteQuery;
  insertQuery: TSQLiteQuery;
  SearchExpr: string;
begin
  if NO_SERIES_TITLE = Title then
    Result := NO_SERIES_ID
  else
  begin
    SearchExpr := ToUpper(Trim(Title));

    searchQuery := FDatabase.NewQuery(SQL_SELECT);
    try
      searchQuery.SetParam(0, Title);
      searchQuery.Open;

      if searchQuery.Eof then
      begin
        insertQuery := FDatabase.NewQuery(SQL_INSERT);
        try
          insertQuery.SetParam(0, Title);
          insertQuery.ExecSQL;

          Result := FDatabase.LastInsertRowID;
        finally
          insertQuery.Free;
        end;
      end
      else
        Result := searchQuery.FieldAsInt(0);
    finally
      searchQuery.Free;
    end;
  end;
end;

procedure TBookCollection_SQLite.SetSeriesTitle(const SeriesID: Integer; const NewSeriesTitle: string);
const
  SQL_UPDATE = 'UPDATE Series Set SeriesTitle = ? WHERE BookID = ? ';
begin
  Assert(SeriesID <> NO_SERIES_ID);
  Assert(NewSeriesTitle <> NO_SERIES_TITLE);

  FDatabase.ExecSQL(SQL_UPDATE, [NewSeriesTitle, SeriesID]);
end;

// Change SeriesID value for all books in the current database with old SeriesID value
procedure TBookCollection_SQLite.ChangeBookSeriesID(const OldSeriesID: Integer; const NewSeriesID: Integer; const DatabaseID: Integer);
const
  SQL_UPDATE_BOOKS = 'UPDATE Books SET SeriesID = ? WHERE SeriesID = ? ';
  SQL_DELETE_SERIES = 'DELETE FROM Series WHERE SeriesID = ? ';
var
  Query: TSQLiteQuery;
begin
  Assert(OldSeriesID <> NewSeriesID);

  if (DatabaseID <> CollectionID) then
    FSystemData.GetCollection(DatabaseID).ChangeBookSeriesID(OldSeriesID, NewSeriesID, DatabaseID)
  else
  begin
    Query := FDatabase.NewQuery(SQL_UPDATE_BOOKS);
    try
      if (NewSeriesID <> NO_SERIES_ID) then
        Query.SetParam(0, NewSeriesID);
      if (OldSeriesID <> NO_SERIES_ID) then
        Query.SetParam(1, OldSeriesID);
      Query.ExecSQL;
    finally
      FreeAndNil(Query);
    end;

    // Clean up empty series:
    if NO_SERIES_ID <> OldSeriesID then
    begin
      Query := FDatabase.NewQuery(SQL_DELETE_SERIES);
      try
        Query.SetParam(0, OldSeriesID);
        //
        // TODO : а где ExecSQL ?
        //
      finally
        FreeAndNil(Query);
      end;
    end;

    // Обновим информацию в группах
    FSystemData.ChangeBookSeriesID(OldSeriesID, NewSeriesID, DatabaseID);
  end;
end;

function TBookCollection_SQLite.InsertBook(BookRecord: TBookRecord; const CheckFileName: Boolean; const FullCheck: Boolean): Integer;
const
  SQL_INSERT =
    'INSERT INTO Books (' +
    'Title,     Folder,    FileName,   Ext,      InsideNo, ' +  // 0  .. 04
    'SeriesID,  SeqNumber, BookSize,   LibID, ' +               // 05 .. 08
    'IsDeleted, IsLocal,   UpdateDate, Lang,     LibRate, ' +   // 09 .. 13
    'KeyWords,  Rate,      Progress,   Review,   Annotation' +  // 14 .. 18
    ') ' +
    'VALUES (' +
    '?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ' +
    ')';
var
  i: Integer;
  NameConflict: Boolean;
  query: TSQLiteQuery;
begin
  Result := 0;

  if BookRecord.FileName = '' then
    Exit;

  BookRecord.Normalize;

  //
  // Создадим отсутствующих авторов
  //
  Assert(BookRecord.AuthorCount > 0);
  for i := 0 to BookRecord.AuthorCount - 1 do
    BookRecord.Authors[i].AuthorID := InsertAuthorIfMissing(BookRecord.Authors[i]);

  //
  // Определяем код жанра
  //
  Assert(BookRecord.GenreCount > 0);
  for i := 0 to BookRecord.GenreCount - 1 do
  begin
    //
    // Если fb2 код указан, переводим его в универсальный код
    //
    if BookRecord.Genres[i].FB2GenreCode <> '' then
      BookRecord.Genres[i] := FGenreCache.ByFB2Code[BookRecord.Genres[i].FB2GenreCode]
    else
      BookRecord.Genres[i] := FGenreCache[BookRecord.Genres[i].GenreCode];
  end;

  //
  // создадим отсутствующую серию
  //
  BookRecord.SeriesID := FindOrCreateSeries(BookRecord.Series);

  //
  // Собственно сохраним информацию о книге
  //
  NameConflict := CheckFileName and IsFileNameConflict(BookRecord, FullCheck);

  if not NameConflict then
  begin
    if BookRecord.SeqNumber > 5000 then
      BookRecord.SeqNumber := 0;

    BookRecord.Review := Trim(BookRecord.Review);
    if BookRecord.Review <> '' then
      Include(BookRecord.BookProps, bpHasReview)
    else
      Exclude(BookRecord.BookProps, bpHasReview);
    BookRecord.Annotation := BookRecord.Annotation;

    query := FDatabase.NewQuery(SQL_INSERT);
    try
      query.SetParam(0, BookRecord.Title);
      query.SetParam(1, BookRecord.Folder);
      query.SetParam(2, BookRecord.FileName);
      query.SetParam(3, BookRecord.FileExt);
      query.SetParam(4, BookRecord.InsideNo);
      if NO_SERIES_ID <> BookRecord.SeriesID then
      begin
        query.SetParam(5, BookRecord.SeriesID);
        query.SetParam(6, BookRecord.SeqNumber);
      end
      else
      begin
        query.SetNullParam(5);
        query.SetNullParam(6);
      end;
      query.SetParam(7, BookRecord.Size);
      query.SetParam(8, BookRecord.LibID);
      query.SetParam(9, bpIsDeleted in BookRecord.BookProps);
      query.SetParam(10, bpIsLocal in BookRecord.BookProps);
      query.SetParam(11, BookRecord.Date);
      query.SetParam(12, BookRecord.Lang);
      query.SetParam(13, BookRecord.LibRate);
      query.SetParam(14, BookRecord.KeyWords);
      query.SetParam(15, BookRecord.Rate);
      query.SetParam(16, BookRecord.Progress);

      if BookRecord.Review = '' then
        query.SetNullParam(17)
      else
        query.SetBlobParam(17, BookRecord.Review);

      if BookRecord.Annotation = '' then
        query.SetNullParam(18)
      else
        query.SetParam(18, BookRecord.Annotation);

      query.ExecSQL;

      BookRecord.BookKey.BookID := FDatabase.LastInsertRowID;
      BookRecord.BookKey.DatabaseID := CollectionID;
    finally
      query.Free;
    end;

    SetBookGenres(BookRecord.BookKey.BookID, BookRecord.Genres, False);
    SetBookAuthors(BookRecord.BookKey.BookID, BookRecord.Authors, False);

    Result := BookRecord.BookKey.BookID;
  end;
end;

procedure TBookCollection_SQLite.GetBookRecord(const BookKey: TBookKey; out BookRecord: TBookRecord; const LoadMemos: Boolean);
const
  SQL =
    'SELECT ' +
    'b.Title, b.Folder, b.FileName, b.Ext, b.InsideNo, ' +        // 0  .. 4
    'b.SeriesID, b.SeqNumber, b.BookSize, b.LibID, ' +            // 5  .. 8
    'b.IsDeleted, b.IsLocal, b.UpdateDate, b.Lang, b.LibRate, ' + // 09 .. 13
    'b.KeyWords, b.Rate, b.Progress, b.Review, b.Annotation ' +   // 14 .. 18
    'FROM Books b ' +
    'WHERE BookID = ?';
var
  Table: TSQLiteQuery;
begin
  BookRecord.Clear;

  if BookKey.DatabaseID = CollectionID then
  begin
    Table := FDatabase.NewQuery(SQL);
    try
      Table.SetParam(0, BookKey.BookID);
      Table.Open;

      Assert(not Table.Eof);

      BookRecord.NodeType := ntBookInfo;
      BookRecord.BookKey := BookKey;
      BookRecord.Title := Table.FieldAsString(0);
      BookRecord.Folder := Table.FieldAsString(1);
      BookRecord.FileName := Table.FieldAsString(2);
      BookRecord.FileExt := Table.FieldAsString(3);
      BookRecord.InsideNo := Table.FieldAsInt(4);
      if not Table.FieldIsNull(5) then
      begin
        BookRecord.SeriesID := Table.FieldAsInt(5);
        BookRecord.Series := GetSeriesTitle(BookRecord.SeriesID);
        BookRecord.SeqNumber := Table.FieldAsInt(6);
      end;
      BookRecord.Size := Table.FieldAsInt(7);
      BookRecord.LibID := Table.FieldAsString(8);

      if Table.FieldAsBoolean(9) then
        Include(BookRecord.BookProps, bpIsDeleted)
      else
        Exclude(BookRecord.BookProps, bpIsDeleted);

      if Table.FieldAsBoolean(10) then
        Include(BookRecord.BookProps, bpIsLocal)
      else
        Exclude(BookRecord.BookProps, bpIsLocal);

      BookRecord.Date := Table.FieldAsDateTime(11);
      BookRecord.Lang := Table.FieldAsString(12);
      BookRecord.LibRate := Table.FieldAsInt(13);
      BookRecord.KeyWords := Table.FieldAsString(14);
      BookRecord.Rate := Table.FieldAsInt(15);
      BookRecord.Progress := Table.FieldAsInt(16);
      BookRecord.CollectionRoot := CollectionRoot;
      BookRecord.CollectionName := GetProperty(PROP_DISPLAYNAME);

      if (not Table.FieldIsNull(17)) then // review
        Include(BookRecord.BookProps, bpHasReview)
      else
        Exclude(BookRecord.BookProps, bpHasReview);

      GetBookGenres(BookRecord.BookKey.BookID, BookRecord.Genres, @(BookRecord.RootGenre));
      GetBookAuthors(BookRecord.BookKey.BookID, BookRecord.Authors);

      if LoadMemos then
      begin
        // TODO - rethink when to load the memo fields.
        //
        BookRecord.Review := Table.FieldAsBlobString(17);
        BookRecord.Annotation := Table.FieldAsString(18);
      end;
    finally
      FreeAndNil(Table);
    end;
  end
  else
    FSystemData.GetBookRecord(BookKey, BookRecord);
end;

procedure TBookCollection_SQLite.UpdateAuthor(Author : PAuthorData);
const
  SQL_INSERT =
    'UPDATE Authors SET ' +
    'FirstName = ?,     MiddleName = ?,    LastName = ? ' +
    'WHERE AuthorID = ? ';
var
  query: TSQLiteQuery;
begin
  try
    query := FDatabase.NewQuery(SQL_INSERT);
    query.SetParam(0, Author.FirstName);
    query.SetParam(1, Author.MiddleName);
    query.SetParam(2, Author.LastName);
    query.SetParam(3, Author.AuthorID);
    query.ExecSQL;
  finally
    query.Free;
  end;
end;

procedure TBookCollection_SQLite.UpdateBook(BookRecord: TBookRecord);
const
  SQL_INSERT =
    'UPDATE Books SET ' +
    'Title = ?,     Folder = ?,    FileName = ?,   Ext = ?,      InsideNo = ?, ' +  // 0  .. 04
    'SeqNumber = ?, BookSize = ?, LibID = ?, ' +                                    // 05 .. 07
    'IsDeleted = ?, IsLocal = ?,   UpdateDate = ?, Lang = ?,     LibRate = ?, ' +   // 08 .. 12
    'KeyWords = ?,  Rate = ?,      Progress = ?,   Review = ?,   Annotation = ?' +  // 13 .. 17
    'WHERE BookID = ? ';
var
  i: Integer;
  query: TSQLiteQuery;
begin
  Assert(BookRecord.FileName <> '');

  if (BookRecord.BookKey.DatabaseID <> CollectionID) then
    FSystemData.GetCollection(BookRecord.BookKey.DatabaseID).UpdateBook(BookRecord)
  else
  begin
    BookRecord.Normalize;

    //
    // Создадим отсутствующих авторов
    //
    Assert(BookRecord.AuthorCount > 0);
    for i := 0 to BookRecord.AuthorCount - 1 do
      BookRecord.Authors[i].AuthorID := InsertAuthorIfMissing(BookRecord.Authors[i]);

    //
    // Определяем код жанра
    //
    Assert(BookRecord.GenreCount > 0);
    for i := 0 to BookRecord.GenreCount - 1 do
    begin
      //
      // Если fb2 код указан, переводим его в универсальный код
      //
      if BookRecord.Genres[i].FB2GenreCode <> '' then
        BookRecord.Genres[i] := FGenreCache.ByFB2Code[BookRecord.Genres[i].FB2GenreCode]
      else
        BookRecord.Genres[i] := FGenreCache[BookRecord.Genres[i].GenreCode];
    end;

    //
    // создадим отсутствующую серию
    //
    BookRecord.SeriesID := FindOrCreateSeries(BookRecord.Series);

    if BookRecord.SeqNumber > 5000 then
      BookRecord.SeqNumber := 0;

    BookRecord.Review := Trim(BookRecord.Review);
    if BookRecord.Review <> '' then
      Include(BookRecord.BookProps, bpHasReview)
    else
      Exclude(BookRecord.BookProps, bpHasReview);
    BookRecord.Annotation := BookRecord.Annotation;

    // Update the book's series and clean up unused series:
    SetSeriesID(BookRecord.BookKey, BookRecord.SeriesID);

    query := FDatabase.NewQuery(SQL_INSERT);
    try
      query.SetParam(0, BookRecord.Title);
      query.SetParam(1, BookRecord.Folder);
      query.SetParam(2, BookRecord.FileName);
      query.SetParam(3, BookRecord.FileExt);
      query.SetParam(4, BookRecord.InsideNo);
      // SeriesID was set by SetSeriesID, so just change the SeqNumber
      if NO_SERIES_ID <> BookRecord.SeriesID then
        query.SetParam(5, BookRecord.SeqNumber)
      else
        query.SetNullParam(5);
      query.SetParam(6, BookRecord.Size);
      query.SetParam(7, BookRecord.LibID);
      query.SetParam(8, bpIsDeleted in BookRecord.BookProps);
      query.SetParam(9, bpIsLocal in BookRecord.BookProps);
      query.SetParam(10, BookRecord.Date);
      query.SetParam(11, BookRecord.Lang);
      query.SetParam(12, BookRecord.LibRate);
      query.SetParam(13, BookRecord.KeyWords);
      query.SetParam(14, BookRecord.Rate);
      query.SetParam(15, BookRecord.Progress);

      if BookRecord.Review = '' then
        query.SetNullParam(16)
      else
        query.SetBlobParam(16, BookRecord.Review);

      if BookRecord.Annotation = '' then
        query.SetNullParam(17)
      else
        query.SetParam(17, BookRecord.Annotation);

      query.SetParam(18, BookRecord.BookKey.BookID);

      query.ExecSQL;
    finally
      query.Free;
    end;

    SetBookGenres(BookRecord.BookKey.BookID, BookRecord.Genres, True);
    SetBookAuthors(BookRecord.BookKey.BookID, BookRecord.Authors, True);

    FSystemData.UpdateBook(BookRecord);
  end;
end;

// Delete the book, all dependent tables are cleared by a matching trigger
//procedure TBookCollection_SQLite.DeleteBook(const BookKey: TBookKey);
//const
//  SQL_DELETE_BOOKS = 'DELETE FROM Books WHERE BookID = ?';
//begin
//  if BookKey.DatabaseID <> CollectionID then
//    FSystemData.GetCollection(BookKey.DatabaseID).DeleteBook(BookKey)
//  else
//  begin
//    FDatabase.ExecSQL(SQL_DELETE_BOOKS, [BookKey.BookID]);
//    FSystemData.DeleteBook(BookKey);
//  end;
//end;

procedure TBookCollection_SQLite.DeleteBook(const BookKey: TBookKey);
const
  SQL_DELETE_BOOKS = 'DELETE FROM Books WHERE BookID = ?';
var
  query1, query2: TSQLiteQuery;
  Count: Integer;
  AuthorID: integer;
  ID: Integer;
begin
  if BookKey.DatabaseID <> CollectionID then
    FSystemData.GetCollection(BookKey.DatabaseID).DeleteBook(BookKey)
  else
  begin
    ID := BookKey.BookID;
    query1 := FDatabase.NewQuery('SELECT AuthorID FROM Author_List al WHERE al.BookID = ?;');
    query1.SetParam(0, ID);
    query1.Open;

    while not query1.Eof do
    begin
      AuthorID := query1.FieldAsInt(0);
      query2 := FDatabase.NewQuery('SELECT Count(*) FROM Author_List WHERE AuthorID = ?;');
      query2.SetParam(0, AuthorID);
      query2.Open;
      Count := query2.FieldAsInt(0);
      query2.Free;
      if Count <= 1 then
        FDatabase.ExecSQL('DELETE FROM Authors WHERE AuthorID = ?',[AuthorID]);
      query1.Next;
    end;
    query1.Free;
    FDatabase.ExecSQL(SQL_DELETE_BOOKS, [ID]);
    FSystemData.DeleteBook(BookKey);
  end;
end;

function TBookCollection_SQLite.GetReview(const BookKey: TBookKey): string;
const
  SQL = 'SELECT Review FROM Books WHERE BookID = ?';
var
  query: TSQLiteQuery;
begin
  if BookKey.DatabaseID = CollectionID then
  begin
    query := FDatabase.NewQuery(SQL);
    try
      query.SetParam(0, BookKey.BookID);
      query.Open;

      if not query.Eof then
        Result := query.FieldAsBlobString(0)
      else
        Result := '';
    finally
      query.Free;
    end;
  end
  else
    Result := FSystemData.GetReview(BookKey);
end;

function TBookCollection_SQLite.SetReview(const BookKey: TBookKey; const Review: string): Integer;
const
  SQL_UPDATE = 'UPDATE Books SET Review = ? WHERE BookID = ?';
var
  NewReview: string;
  NewCode: Integer;
  query: TSQLiteQuery;
begin
  if BookKey.DatabaseID <> CollectionID then
    NewCode := FSystemData.GetCollection(BookKey.DatabaseID).SetReview(BookKey, Review)
  else
  begin
    NewReview := Trim(Review);
    NewCode := IfThen(NewReview = '', 0, 1);

    query := FDatabase.NewQuery(SQL_UPDATE);
    try
      query.SetBlobParam(0, NewReview);
      query.SetParam(1, BookKey.BookID);

      query.ExecSQL;
    finally
      query.Free;
    end;

    //
    // Обновим информацию в группах
    //
    Result := NewCode or FSystemData.SetReview(BookKey, NewReview);
  end;
end;

procedure TBookCollection_SQLite.SetProgress(const BookKey: TBookKey; const Progress: Integer);
const
  SQL_UPDATE = 'UPDATE Books SET Progress = ? WHERE BookID = ?';
begin
  if BookKey.DatabaseID <> CollectionID then
    FSystemData.GetCollection(BookKey.DatabaseID).SetProgress(BookKey, Progress)
  else
  begin
    FDatabase.ExecSQL(SQL_UPDATE, [Progress, BookKey.BookID]);

    //
    // Обновим информацию в группах
    //
    FSystemData.SetProgress(BookKey, Progress);
  end;
end;

procedure TBookCollection_SQLite.SetRate(const BookKey: TBookKey; const Rate: Integer);
const
  SQL_UPDATE = 'UPDATE Books SET Rate = ? WHERE BookID = ?';
begin
  if BookKey.DatabaseID <> CollectionID then
    FSystemData.GetCollection(BookKey.DatabaseID).SetRate(BookKey, Rate)
  else
  begin
    FDatabase.ExecSQL(SQL_UPDATE, [Rate, BookKey.BookID]);

    //
    // Обновим информацию в группах
    //
    FSystemData.SetRate(BookKey, Rate);
  end;
end;

procedure TBookCollection_SQLite.SetLocal(const BookKey: TBookKey; const AState: Boolean);
const
  SQL_UPDATE = 'UPDATE Books SET IsLocal = ? WHERE BookID = ?';
begin
  if BookKey.DatabaseID <> CollectionID then
    FSystemData.GetCollection(BookKey.DatabaseID).SetLocal(BookKey, AState)
  else
  begin
    FDatabase.ExecSQL(SQL_UPDATE, [AState, BookKey.BookID]);

    //
    // Обновим информацию в группах
    //
    FSystemData.SetLocal(BookKey, AState);
  end;
end;

procedure TBookCollection_SQLite.InternalUpdateField(const BookID: Integer; const UpdateSQL: string; const NewValue: string);
var
  query: TSQLiteQuery;
begin
  query := FDatabase.NewQuery(UpdateSQL);
  try
    query.SetParam(0, NewValue);
    query.SetParam(1, BookID);

    query.ExecSQL;
  finally
    query.Free;
  end;
end;

procedure TBookCollection_SQLite.SetFolder(const BookKey: TBookKey; const Folder: string);
const
  SQL_UPDATE = 'UPDATE Books SET Folder = ? WHERE BookID = ?';
begin
  if BookKey.DatabaseID <> CollectionID then
    FSystemData.GetCollection(BookKey.DatabaseID).SetFolder(BookKey, Folder)
  else
  begin
    InternalUpdateField(BookKey.BookID, SQL_UPDATE, Folder);

    //
    // Обновим информацию в группах
    //
    FSystemData.SetFolder(BookKey, Folder);
  end;
end;

procedure TBookCollection_SQLite.SetFileName(const BookKey: TBookKey; const FileName: string);
const
  SQL_UPDATE = 'UPDATE Books SET FileName = ? WHERE BookID = ?';
begin
  if BookKey.DatabaseID <> CollectionID then
    FSystemData.GetCollection(BookKey.DatabaseID).SetFileName(BookKey, FileName)
  else
  begin
    InternalUpdateField(BookKey.BookID, SQL_UPDATE, FileName);

    //
    // Обновим информацию в группах
    //
    FSystemData.SetFileName(BookKey, FileName);
  end;
end;

procedure TBookCollection_SQLite.SetSeriesID(const BookKey: TBookKey; const SeriesID: Integer);
const
  SQL_SELECT_OLD_SERIES = 'SELECT IFNULL(b.SeriesID, 0) FROM Books b WHERE b.BookID = ? ';
  SQL_UPDATE = 'UPDATE Books SET SeriesID = ? WHERE BookID = ? ';
  SQL_SELECT_COUNT_BOOKS_IN_SERIES = 'SELECT COUNT(*) FROM Books b WHERE b.SeriesID = ? ';
  SQL_DELETE = 'DELETE FROM Series WHERE SeriesID = ? ';
var
  Query: TSQLiteQuery;
  OldSeriesID: Integer;
  CountBooksInASeries: Integer;
begin
  if BookKey.DatabaseID <> CollectionID then
    FSystemData.GetCollection(BookKey.DatabaseID).SetSeriesID(BookKey, SeriesID)
  else
  begin
    OldSeriesID := FDatabase.QuerySingleInt(SQL_SELECT_OLD_SERIES, [BookKey.BookID]);

    Query := FDatabase.NewQuery(SQL_UPDATE);
    try
      if NO_SERIES_ID = SeriesID then
        Query.SetNullParam(0)
      else
        Query.SetParam(0, SeriesID);
      Query.SetParam(1, BookKey.BookID);
      Query.ExecSQL;
    finally
      FreeAndNil(Query);
    end;

    CountBooksInASeries := FDatabase.QuerySingleInt(SQL_SELECT_COUNT_BOOKS_IN_SERIES, [OldSeriesID]);

    if (CountBooksInASeries = 0) then
    begin
      // was a single book in a series and was just removed from it
      Query := FDatabase.NewQuery(SQL_DELETE);
      try
        Query.SetParam(0, OldSeriesID);
        Query.ExecSQL;
      finally
        FreeAndNil(Query);
      end;
    end;

    // Обновим информацию в группах
    FSystemData.SetBookSeriesID(BookKey, SeriesID);
  end;
end;

function TBookCollection_SQLite.GetSeriesTitle(SeriesID: Integer): string;
const
  SQL = 'SELECT s.SeriesTitle FROM Series s WHERE s.SeriesID = ?';
begin
  Result := NO_SERIES_TITLE;

  if (NO_SERIES_ID <> SeriesID) then
  begin
    Result := FDatabase.QuerySingleString(SQL, [SeriesID]);
  end
end;

procedure TBookCollection_SQLite.BeginBulkOperation;
begin
  Assert(not FDatabase.InTransaction);

  FDatabase.Start;
end;

procedure TBookCollection_SQLite.EndBulkOperation(Commit: Boolean = True);
begin
  Assert(FDatabase.InTransaction);

  if Commit then
    FDatabase.Commit
  else
    FDatabase.Rollback;
end;

procedure TBookCollection_SQLite.CompactDatabase;
begin
  FDatabase.CompactDatabase;
end;

procedure TBookCollection_SQLite.RepairDatabase;
begin
  // Not supported for SQLite, skip
end;

procedure TBookCollection_SQLite.ReloadGenres(const FileName: string);
const
  SQL_DELETE_GENRES = 'DELETE FROM Genres ';
  SQL_DELETE_GENRE_LIST = 'DELETE FROM Genre_List WHERE GenreCode NOT IN (SELECT GenreCode FROM Genres) ';
begin
  //
  // почистить таблицу Genres
  //
  FDatabase.ExecSQL(SQL_DELETE_GENRES);
  FGenreCache.Clear;

  LoadGenres(FileName);

  // Remove missing genre reference:
  FDatabase.ExecSQL(SQL_DELETE_GENRE_LIST);
end;

procedure TBookCollection_SQLite.GetStatistics(out AuthorsCount: Integer; out BooksCount: Integer; out SeriesCount: Integer);
const
  SQL_SELECT = 'SELECT COUNT(*) FROM %s ';
var
  Sql: string;
begin
  Sql := Format(SQL_SELECT, ['Authors']);
  AuthorsCount := FDatabase.QuerySingleInt(Sql);

  Sql := Format(SQL_SELECT, ['Books']);
  BooksCount := FDatabase.QuerySingleInt(Sql);

  Sql := Format(SQL_SELECT, ['Series']);
  SeriesCount := FDatabase.QuerySingleInt(Sql);
end;

// Clear contents of collection tables (except for Settings and Genres)
procedure TBookCollection_SQLite.TruncateTablesBeforeImport;
const
  SQL_TRUNCATE = 'DROP TABLE %s';
  TABLE_NAMES: array [0 .. 4] of string = ('Author_List', 'Genre_List', 'Books', 'Authors', 'Series');
var
  TableName: string;
  StringList: TStringList;
  StructureDDL: string;
  BookCollection: IBookCollection;

begin
  for TableName in TABLE_NAMES do
    FDatabase.ExecSQL(Format(SQL_TRUNCATE, [TableName]));

  StringList := ReadResourceAsStringList('RecreateCollectionTables');
  for StructureDDL in StringList do
  begin
    if Trim(StructureDDL) <> '' then
      FDatabase.ExecSQL(StructureDDL);
  end;

end;

procedure TBookCollection_SQLite.StartBatchUpdate;
begin
  FTriggersEnabled := False;
end;

procedure TBookCollection_SQLite.AfterBatchUpdate;
begin
  FDatabase.ExecSQL(
    'UPDATE Series ' +
    'SET ' +
    '  SearchSeriesTitle = MHL_UPPER(SeriesTitle) ' +
    'WHERE ' +
    '  SearchSeriesTitle IS NULL'
  );

  FDatabase.ExecSQL(
    'UPDATE Authors ' +
    'SET ' +
    '  SearchName = MHL_FULLNAME(LastName, FirstName, MiddleName, 1) ' +
    'WHERE ' +
    '  SearchName IS NULL'
  );

  FDatabase.ExecSQL(
    'UPDATE Books ' +
    'SET ' +
    '  SearchTitle      = MHL_UPPER(Title), ' +
    '  SearchLang       = MHL_UPPER(Lang), ' +
    '  SearchFolder     = MHL_UPPER(Folder), ' +
    '  SearchFileName   = MHL_UPPER(FileName), ' +
    '  SearchExt        = MHL_UPPER(Ext), ' +
    '  SearchKeyWords   = MHL_UPPER(KeyWords), ' +
    '  SearchAnnotation = MHL_UPPER(Annotation) ' +
    'WHERE ' +
    '  SearchTitle IS NULL'
  );

  FDatabase.ReindexDatabase;
end;

procedure TBookCollection_SQLite.FinishBatchUpdate;
begin
  FTriggersEnabled := True;
end;

procedure TBookCollection_SQLite.SetAnnotation(const BookKey: TBookKey;
  const Annotation: string);
begin

end;

procedure TBookCollection_SQLite.SetBookAuthors(const BookID: Integer; const Authors: TBookAuthors; Replace: Boolean);
const
  SQL_DELETE = 'DELETE FROM Author_List WHERE BookID = ? ';
  SQL_INSERT = 'INSERT INTO Author_List (AuthorID, BookID) VALUES(?, ?)';
var
  insertedIds: TList<Integer>;
  query: TSQLiteQuery;
  Author: TAuthorData;
begin
  if Replace then
    FDatabase.ExecSQL(SQL_DELETE, [BookID]);

  insertedIds := TList<Integer>.Create;
  try
    query := FDatabase.NewQuery(SQL_INSERT);
    try
      for Author in Authors do
      begin
        if -1 = insertedIds.IndexOf(Author.AuthorID) then
        begin
            query.SetParam(0, Author.AuthorID);
            query.SetParam(1, BookID);
            query.ExecSQL;
            insertedIds.Add(Author.AuthorID);
        end;
      end;
    finally
      query.Free;
    end;
  finally
    insertedIds.Free;
  end;
end;

//
// Add or replace book genres for the book specified by BookID
//
procedure TBookCollection_SQLite.SetBookGenres(const BookID: Integer; const Genres: TBookGenres; Replace: Boolean);
const
  SQL_DELETE = 'DELETE FROM Genre_List WHERE BookID = ?';
  SQL_INSERT = 'INSERT INTO Genre_List (BookID, GenreCode) VALUES(?, ?)';
var
  insertedCodes: TList<string>;
  Genre: TGenreData;
  query: TSQLiteQuery;
begin
  if Replace then
    FDatabase.ExecSQL(SQL_DELETE, [BookID]);

  insertedCodes := TList<string>.Create;
  try
    query := FDatabase.NewQuery(SQL_INSERT);
    try
      for Genre in Genres do
      begin
        if -1 = insertedCodes.IndexOf(Genre.GenreCode) then
        begin
          query.SetParam(0, BookID);
          query.SetParam(1, Genre.GenreCode);
          query.ExecSQL;
          insertedCodes.Add(Genre.GenreCode);
        end;
      end;
    finally
      query.Free;
    end;
  finally
    insertedCodes.Free;
  end;
end;

end.
