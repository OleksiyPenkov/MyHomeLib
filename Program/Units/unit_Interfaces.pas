(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           eg_
  *                     Nick Rymanov (nrymanov@gmail.com)
  * Created             03.09.2010
  * Description
  *
  * $Id: unit_Interfaces.pas 1131 2013-12-04 10:12:58Z koreec $
  *
  * History
  *
  ****************************************************************************** *)

unit unit_Interfaces;

interface

uses
  Classes,
  unit_Globals,
  unit_Consts,
  unit_UserData;

type
  IIterator<T: record> = interface
    function Next(out v: T): Boolean;
    function RecordCount: Integer;
  end;

  IObjectIterator<T: TPersistent> = interface
    function Next(v: T): Boolean;
    function RecordCount: Integer;
  end;

  IInterfaceIterator<T: IInterface> = interface
    function Next(out v: T): Boolean;
    function RecordCount: Integer;
  end;

  IBookIterator = IIterator<TBookRecord>;
  IAuthorIterator = IIterator<TAuthorData>;
  IGenreIterator = IIterator<TGenreData>;
  ISeriesIterator = IIterator<TSeriesData>;
  IGroupIterator = IIterator<TGroupData>;
  ICollectionInfoIterator = IIterator<TCollectionInfo>;

  TGUIUpdateExtraProc = reference to procedure(
    const BookKey: TBookKey;
    extra: TBookExtra
  );

  IBookCollection = interface;

  ISystemData = interface
    ['{3896E4C6-8E2F-42F3-9FB2-91753258E9B7}']

    //
    // Создание, регистрация и удаление коллекций
    //

    //
    // Создание новой коллекции
    //
    function CreateCollection(
      const DisplayName: string;
      const RootFolder: string;
      const DBFileName: string;
      CollectionType: COLLECTION_TYPE;
      const GenresFileName: string
    ): Integer;

    //
    // Регистрация существующей коллекции
    //
    function RegisterCollection(
      const DBFileName: string;
      const DisplayName: string;
      const RootFolder: string
    ): Integer;

    //
    // Удаление коллекции
    //
    procedure DeleteCollection(const CollectionID: Integer; const RemoveFromDisk: Boolean = True);

    function HasCollections: Boolean;
    function HasCollectionWithProp(PropID: TPropertyID; const Value: string; IgnoreID: Integer = INVALID_COLLECTION_ID): Boolean;
    function FindFirstExistingCollectionID(const PreferredID: Integer): Integer;

    //
    // Свойства коллекции
    //
    procedure SetProperty(const CollectionID: Integer; const PropID: TPropertyID; const Value: Variant);
    function GetProperty(const CollectionID: Integer; const PropID: TPropertyID): Variant;

    function GetCollectionInfo(const CollectionID: Integer): TCollectionInfo;

    function GetCollection(const CollectionID: Integer; const RefreshCache: Boolean = False): IBookCollection;

    function ActivateGroup(const ID: Integer): Boolean; //deprecated;

    //
    // Работа с книгами
    //
    procedure GetBookRecord(const BookKey: TBookKey; var BookRecord: TBookRecord);
    procedure DeleteBook(const BookKey: TBookKey);
    procedure UpdateBook(const BookRecord: TBookRecord);

    procedure SetExtra(const BookKey: TBookKey; extra: TBookExtra);
    procedure SetRate(const BookKey: TBookKey; Rate: Integer);
    procedure SetProgress(const BookKey: TBookKey; Progress: Integer);

    function GetReview(const BookKey: TBookKey): string;
    function SetReview(const BookKey: TBookKey; const Review: string): Integer;

    function GetAnnotation(const BookKey: TBookKey): string;
    procedure SetAnnotation(const BookKey: TBookKey; const Annotation: string);

    procedure SetLocal(const BookKey: TBookKey; Value: Boolean);
    procedure SetFileName(const BookKey: TBookKey; const FileName: string);
    procedure SetBookSeriesID(const BookKey: TBookKey; const SeriesID: Integer);
    procedure SetFolder(const BookKey: TBookKey; const Folder: string);

    //
    // Работа с группами
    //
    function AddGroup(const GroupName: string; const AllowDelete: Boolean = True): Boolean;
    function GetGroup(const GroupID: Integer): TGroupData;
    function RenameGroup(GroupID: Integer; const NewName: string): Boolean;
    procedure ClearGroup(GroupID: Integer);
    procedure DeleteGroup(GroupID: Integer);

    procedure AddBookToGroup(const BookKey: TBookKey; GroupID: Integer; const BookRecord: TBookRecord);
    procedure CopyBookToGroup(const BookKey: TBookKey; SourceGroupID: Integer; TargetGroupID: Integer; MoveBook: Boolean);
    procedure DeleteFromGroup(const BookKey: TBookKey; GroupID: Integer);

    //
    // Пользовательские данные
    //
    procedure ImportUserData(data: TUserData);
    procedure ExportUserData(data: TUserData; const DatabaseID: Integer);

    //
    // Batch update methods:
    //
    procedure ChangeBookSeriesID(const OldSeriesID: Integer; const NewSeriesID: Integer; const DatabaseID: Integer);

    //
    // Iterators
    //
    function GetBookIterator(const GroupID: Integer; const DatabaseID: Integer = INVALID_COLLECTION_ID): IBookIterator;
    function GetGroupIterator: IGroupIterator;
    function GetCollectionInfoIterator: ICollectionInfoIterator;

    //
    // Служебные методы
    //
    procedure ClearCollectionCache;
    procedure RemoveUnusedBooks;
  end;

  IBookCollection = interface
    ['{B1BB5762-2942-48C3-90E3-3154405EC01B}']

    //
    //
    //
    function GetAuthorIterator(const Mode: TAuthorIteratorMode; const FilterValue: PFilterValue = nil): IAuthorIterator;
    function GetGenreIterator(const Mode: TGenreIteratorMode; const FilterValue: PFilterValue = nil): IGenreIterator;
    function GetSeriesIterator(const Mode: TSeriesIteratorMode): ISeriesIterator;
    function GetBookIterator(const Mode: TBookIteratorMode; const LoadMemos: Boolean; const FilterValue: PFilterValue = nil): IBookIterator;
    function Search(const SearchCriteria: TBookSearchCriteria; const LoadMemos: Boolean): IBookIterator;


    // работа с авторами

    procedure UpdateAuthor(Author : PAuthorData);
    //
    //
    //
    function InsertBook(BookRecord: TBookRecord; const CheckFileName: Boolean; const FullCheck: Boolean): Integer; // превратить в процедуру
    procedure GetBookRecord(const BookKey: TBookKey; out BookRecord: TBookRecord; const LoadMemos: Boolean);
    procedure UpdateBook(BookRecord: TBookRecord);
    procedure DeleteBook(const BookKey: TBookKey);
    procedure AddBookToGroup(const BookKey: TBookKey; const GroupID: Integer);


    function GetReview(const BookKey: TBookKey): string;

    function SetReview(const BookKey: TBookKey; const Review: string): Integer; // превратить в процедуру
    procedure SetAnnotation(const BookKey: TBookKey; const Annotation: string);
    procedure SetProgress(const BookKey: TBookKey; const Progress: Integer);
    procedure SetRate(const BookKey: TBookKey; const Rate: Integer);
    procedure SetLocal(const BookKey: TBookKey; const AState: Boolean);
    procedure SetFolder(const BookKey: TBookKey; const Folder: string);
    procedure SetFileName(const BookKey: TBookKey; const FileName: string);
    procedure SetSeriesID(const BookKey: TBookKey; const SeriesID: Integer);

    //
    // манипуляции с авторами и жанрами книги
    //
    procedure SetBookAuthors(const BookID: Integer; const Authors: TBookAuthors; Replace: Boolean); // заменить Integer на TBookKey
    procedure SetBookGenres(const BookID: Integer; const Genres: TBookGenres; Replace: Boolean); // заменить Integer на TBookKey

    //
    //
    //
    function FindOrCreateSeries(const Title: string): Integer;
    procedure SetSeriesTitle(const SeriesID: Integer; const NewSeriesTitle: string);
    procedure ChangeBookSeriesID(const OldSeriesID: Integer; const NewSeriesID: Integer; const DatabaseID: Integer);

    //
    // Свойства коллекции
    //
    function CollectionID: Integer;
    function CollectionCode: COLLECTION_TYPE;
    function CollectionRoot: string;
    function CollectionDisplayName: string;
    function CollectionURL: string;

    procedure SetProperty(const PropID: TPropertyID; const Value: Variant);
    function GetProperty(const PropID: TPropertyID): Variant;
    procedure UpdateProperies;

    procedure ImportUserData(data: TUserData; guiUpdateCallback: TGUIUpdateExtraProc);
    procedure ExportUserData(data: TUserData);

    function CheckFileInCollection(const FileName: string; const FullNameSearch: Boolean; const ZipFolder: Boolean): Boolean;

    procedure BeginBulkOperation;
    procedure EndBulkOperation(Commit: Boolean = True);

    procedure CompactDatabase;
    procedure RepairDatabase;

    function GetTopGenreAlias(const FB2Code: string): string;
    procedure ReloadGenres(const FileName: string);
    procedure LoadGenres(const GenresFileName: string);

    procedure GetStatistics(out AuthorsCount: Integer; out BooksCount: Integer; out SeriesCount: Integer);

    procedure TruncateTablesBeforeImport;

    procedure StartBatchUpdate;
    procedure AfterBatchUpdate;
    procedure FinishBatchUpdate;

    procedure VerifyCurrentCollection(const DatabaseID: Integer);

    procedure SetHideDeleted(const HideDeleted: Boolean);
    function GetHideDeleted: Boolean;
    procedure SetShowLocalOnly(const ShowLocalOnly: Boolean);
    function GetShowLocalOnly: Boolean;
    procedure SetSeriesFilterType(const SeriesFilterType: string);
    function GetSeriesFilterType: string;
    procedure SetAuthorFilterType(const AuthorFilterType: string);
    function GetAuthorFilterType: string;
  end;

{$IFDEF USELOGGER}
  ILogger = interface
    ['{E0BE38F4-2911-4FD7-8CA2-B6E3981BBFC0}']
    procedure Log(const logMessage: string; const extraInfo: string);
  end;

  IIntervalLogger = interface(ILogger)
    ['{F1E77E3D-7D8C-421D-9647-8E11B9105271}']
    procedure Restart(const extraInfo: string);
  end;

  IScopeLogger = interface(ILogger)
    ['{B3497AEA-D495-4425-8C1A-24EBA789E3DE}']
  end;
{$ENDIF}

  IParamsParser<T> = interface
    function CheckLiteral(const literalValue: string): Boolean;
    function CheckParam(const paramName: string): Boolean;
    function GetValue(const params: T; const paramName: string): string;
  end;

implementation

end.
