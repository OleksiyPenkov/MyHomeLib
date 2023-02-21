(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Authors             Nick Rymanov     nrymanov@gmail.com
  * Created             05.10.2010
  * Description
  *
  * $Id: unit_treeController.pas 975 2011-03-26 01:37:06Z koreec $
  *
  * History
  *
  ****************************************************************************** *)

unit unit_treeController;

interface

uses
  Types,
  Classes,
  Graphics,
  VirtualTrees,
  BookTreeView,
  pngimage,
  unit_Globals,
  unit_Interfaces;

type
  TTreeController = class
  private
    FSystemData: ISystemData;

    FStarImage: TPngImage;
    FEmptyStarImage: TPngImage;

    FRemoteReadImage: TPngImage;
    FRemoteReviewImage: TPngImage;
    FRemoteReadReviewImage: TPngImage;

    FLocalImage: TPngImage;
    FLocalReadImage: TPngImage;
    FLocalReviewImage: TPngImage;
    FLocalReadReviewImage: TPngImage;

    FBookStateImages: array[0 .. 7] of TPngImage;

  private
    function BooksGetColumnTag(const Sender: TBaseVirtualTree; const Column: Integer): Integer;
    function BooksGetColumnText(Tag: Integer; Data: PBookRecord): string;

    procedure GetNodeDataSize<T>(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure FreeNodeData<T>(Sender: TBaseVirtualTree; Node: PVirtualNode);

    //
    // Список авторов
    //
    procedure AuthorsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);

    //
    // Список серий
    //
    procedure SeriesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);

    //
    // Список жанров
    //
    procedure GenresGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);

    //
    // Список групп
    //
    procedure GroupsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);

    //
    // Список книг
    //
    procedure BooksInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure BooksGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure BooksGetCellIsEmpty(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var IsEmpty: Boolean);
    procedure BooksBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure BooksPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
    procedure BooksAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; CellRect: TRect);
    procedure BooksCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);

    //
    // Список закачек
    //
    procedure DownloadsLoadNode(Sender: TBaseVirtualTree; Node: PVirtualNode; Stream: TStream);
    procedure DownloadsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure DownloadsPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
    procedure DownloadsSaveNode(Sender: TBaseVirtualTree; Node: PVirtualNode; Stream: TStream);

  public
    constructor Create(SystemData: ISystemData);
    destructor Destroy; override;

    procedure ConnectAuthorsTree(tree: TVirtualStringTree);
    procedure ConnectSeriesTree(tree: TVirtualStringTree);
    procedure ConnectGenresTree(tree: TVirtualStringTree);
    procedure ConnectGroupsTree(tree: TVirtualStringTree);
    procedure ConnectBooksTree(tree: TBookTree);
    procedure ConnectDownloadTree(tree: TBookTree);
  end;

implementation

uses
  SysUtils,
  Math,
  StrUtils,
  unit_Consts,
  dm_user,
  unit_Helpers,
  unit_MHLHelpers;

resourcestring
  rstrSingleSeries = 'Серия: %s';
  rstrDownloadStateWaiting = 'Ожидание';
  rstrDownloadStateDownloading = 'Закачка';
  rstrDownloadStateDone = 'Готово';
  rstrDownloadStateError = 'Ошибка';

{ TMainController }

const
  STATE_REMOTE   = $0;
  STATE_LOCAL    = $1;

  STATE_UNREAD   = $0;
  STATE_READ     = $2;

  STATE_NOREVIEW = $0;
  STATE_REVIEW   = $4;
//
//
//
constructor TTreeController.Create(SystemData: ISystemData);
begin
  inherited Create;

  FSystemData := SystemData;

  FStarImage := CreateImageFromResource(TPngImage, 'smallStar') as TPngImage;
  FEmptyStarImage := CreateImageFromResource(TPngImage, 'smallStarEmpty') as TPngImage;

  FRemoteReviewImage := CreateImageFromResource(TPngImage, 'bookRemoteReview') as TPngImage;
  FRemoteReadImage := CreateImageFromResource(TPngImage, 'bookRemoteRead') as TPngImage;
  FRemoteReadReviewImage := CreateImageFromResource(TPngImage, 'bookRemoteReadReview') as TPngImage;

  FLocalImage := CreateImageFromResource(TPngImage, 'bookLocalUnread') as TPngImage;
  FLocalReadImage := CreateImageFromResource(TPngImage, 'bookLocalRead') as TPngImage;
  FLocalReviewImage := CreateImageFromResource(TPngImage, 'bookLocalReview') as TPngImage;
  FLocalReadReviewImage := CreateImageFromResource(TPngImage, 'bookLocalReadReview') as TPngImage;

  FBookStateImages[STATE_REMOTE or STATE_UNREAD or STATE_NOREVIEW] := nil;
  FBookStateImages[STATE_REMOTE or STATE_READ or STATE_NOREVIEW]   := FRemoteReadImage;
  FBookStateImages[STATE_REMOTE or STATE_UNREAD or STATE_REVIEW]   := FRemoteReviewImage;
  FBookStateImages[STATE_REMOTE or STATE_READ or STATE_REVIEW]     := FRemoteReadReviewImage;

  FBookStateImages[STATE_LOCAL or STATE_UNREAD or STATE_NOREVIEW]  := FLocalImage;
  FBookStateImages[STATE_LOCAL or STATE_READ or STATE_NOREVIEW]    := FLocalReadImage;
  FBookStateImages[STATE_LOCAL or STATE_UNREAD or STATE_REVIEW]    := FLocalReviewImage;
  FBookStateImages[STATE_LOCAL or STATE_READ or STATE_REVIEW]      := FLocalReadReviewImage;
end;

destructor TTreeController.Destroy;
begin
  FreeAndNil(FRemoteReviewImage);
  FreeAndNil(FRemoteReadImage);
  FreeAndNil(FRemoteReadReviewImage);

  FreeAndNil(FLocalImage);
  FreeAndNil(FLocalReadImage);
  FreeAndNil(FLocalReviewImage);
  FreeAndNil(FLocalReadReviewImage);

  FreeAndNil(FStarImage);
  FreeAndNil(FEmptyStarImage);

  FSystemData := nil;

  inherited Destroy;
end;

//
// Вспомогательные методы для подключения деревьев
//
procedure TTreeController.ConnectAuthorsTree(tree: TVirtualStringTree);
begin
  Assert(Assigned(tree));
  tree.OnGetNodeDataSize := GetNodeDataSize<TAuthorData>;
  tree.OnGetText := AuthorsGetText;
  tree.OnFreeNode := FreeNodeData<TAuthorData>;
end;

procedure TTreeController.ConnectSeriesTree(tree: TVirtualStringTree);
begin
  Assert(Assigned(tree));
  tree.OnGetNodeDataSize := GetNodeDataSize<TSeriesData>;
  tree.OnGetText := SeriesGetText;
  tree.OnFreeNode := FreeNodeData<TSeriesData>;
end;

procedure TTreeController.ConnectGenresTree(tree: TVirtualStringTree);
begin
  Assert(Assigned(tree));
  tree.OnGetNodeDataSize := GetNodeDataSize<TGenreData>;
  tree.OnGetText := GenresGetText;
  tree.OnFreeNode := FreeNodeData<TGenreData>;
end;

procedure TTreeController.ConnectGroupsTree(tree: TVirtualStringTree);
begin
  Assert(Assigned(tree));
  tree.OnGetNodeDataSize := GetNodeDataSize<TGroupData>;
  tree.OnGetText := GroupsGetText;
  tree.OnFreeNode := FreeNodeData<TGroupData>;
end;

procedure TTreeController.ConnectBooksTree(tree: TBookTree);
begin
  Assert(Assigned(tree));
  tree.OnGetNodeDataSize := GetNodeDataSize<TBookRecord>;
  tree.OnInitNode := BooksInitNode;
  tree.OnGetText := BooksGetText;
  tree.OnGetCellIsEmpty := BooksGetCellIsEmpty;
  tree.OnFreeNode := FreeNodeData<TBookRecord>;

  tree.OnBeforeCellPaint := BooksBeforeCellPaint;
  tree.OnPaintText := BooksPaintText;
  tree.OnAfterCellPaint := BooksAfterCellPaint;
  tree.OnCompareNodes := BooksCompareNodes;
end;

procedure TTreeController.ConnectDownloadTree(tree: TBookTree);
begin
  Assert(Assigned(tree));
  tree.OnGetNodeDataSize := GetNodeDataSize<TDownloadData>;
  tree.OnLoadNode := DownloadsLoadNode;
  tree.OnGetText := DownloadsGetText;
  tree.OnPaintText := DownloadsPaintText;
  tree.OnSaveNode := DownloadsSaveNode;
  tree.OnFreeNode := FreeNodeData<TDownloadData>;
end;

//
// Общие методы
//
procedure TTreeController.GetNodeDataSize<T>(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(T);
end;

procedure TTreeController.FreeNodeData<T>(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: ^T;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then
    Finalize(Data^);
end;

//
// Список авторов
//
procedure TTreeController.AuthorsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Data: PAuthorData;
begin
  Data := Sender.GetNodeData(Node);
  Assert(Assigned(Data));

  CellText := Data^.GetFullName;
end;

//
// Список серий
//
procedure TTreeController.SeriesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Data: PSeriesData;
begin
  Data := Sender.GetNodeData(Node);
  Assert(Assigned(Data));

  CellText := Data^.SeriesTitle;
end;

//
// Список жанров
//
procedure TTreeController.GenresGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Data: PGenreData;
begin
  Data := Sender.GetNodeData(Node);
  Assert(Assigned(Data));

  CellText := Data^.GenreAlias;
end;

//
// Список групп
//
procedure TTreeController.GroupsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Data: PGroupData;
begin
  Data := Sender.GetNodeData(Node);
  Assert(Assigned(Data));
  CellText := Data^.Text;
end;

//
// Список книг
//
procedure TTreeController.BooksInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  Node.CheckType := ctTriStateCheckBox;
  Sender.CheckState[Node] := csUncheckedNormal;
end;

function TTreeController.BooksGetColumnTag(const Sender: TBaseVirtualTree; const Column: Integer): Integer;
begin
  if Column < 0 then
    Result := -1
  else
    Result := (Sender as TBookTree).Header.Columns[Column].Tag;
end;

function TTreeController.BooksGetColumnText(Tag: Integer; Data: PBookRecord): string;
begin
  Assert(Assigned(Data));
  case Tag of
    COL_AUTHOR:
      Result := TAuthorsHelper.GetList(Data^.Authors);
    COL_TITLE:
      Result := Data^.Title;
    COL_SERIES:
      Result := Data^.Series;
    COL_NO:
      Result := IfThen(Data^.SeqNumber = 0, '', IntToStr(Data^.SeqNumber));
    COL_SIZE:
      Result := GetFormattedSize(Data^.Size);
    COL_DATE:
      Result := DateToStr(Data^.Date);
    COL_GENRE:
      Result := TGenresHelper.GetList(Data^.Genres);
    COL_TYPE:
      Result := Data^.GetFileType;
    COL_LANG:
      Result := Data^.Lang;
    // COL_LIBRATE   : Result := IntToStr(Data^.LibRate);
    COL_COLLECTION:
      Result := Data^.CollectionName;
  end;
end;

procedure TTreeController.BooksGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Page: Integer;
  Data: PBookRecord;
  ColumnID: Integer;
begin
  Page := Sender.Tag;
  Data := Sender.GetNodeData(Node);
  Assert(Assigned(Data));

  ColumnID := BooksGetColumnTag(Sender, Column);
  CellText := '';
  if Settings.TreeModes[Page] = tmTree then
  begin
    case Data^.nodeType of
      ntAuthorInfo:
        begin
          if COL_TITLE = ColumnID then
              CellText := TAuthorsHelper.GetList(Data^.Authors);
        end;

      ntSeriesInfo:
        begin
          if COL_TITLE = ColumnID then
            CellText := Format(rstrSingleSeries, [Data^.Series]);
        end;

      ntBookInfo:
        begin
          CellText := BooksGetColumnText(ColumnID, Data);
        end;
    end
  end
  else
    CellText := BooksGetColumnText(ColumnID, Data);
end;

procedure TTreeController.BooksGetCellIsEmpty(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var IsEmpty: Boolean);
var
  Data: PBookRecord;
  ColumnID: Integer;
begin
  Data := Sender.GetNodeData(Node);
  Assert(Assigned(Data));

  ColumnID := BooksGetColumnTag(Sender, Column);

  case Data^.nodeType of
    ntAuthorInfo, ntSeriesInfo:
      IsEmpty := (COL_TITLE <> ColumnID);
    else
      IsEmpty := False;
  end;
end;

procedure TTreeController.BooksBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
var
  Data: PBookRecord;
  Color: TColor;
begin
  Data := Sender.GetNodeData(Node);
  Assert(Assigned(Data));

  Color := Settings.BGColor;
  case Data^.nodeType of
    ntAuthorInfo:
      Color := Settings.AuthorColor;

    ntSeriesInfo:
      Color := Settings.SeriesColor;

    ntBookInfo:
      begin
        if Data^.Series = '' then
          Color := Settings.BookColor
        else
          Color := Settings.SeriesBookColor;
      end;
  end;

  TargetCanvas.Brush.Color := Color;
  TargetCanvas.FillRect(CellRect);
end;

procedure TTreeController.BooksPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
var
  Data: PBookRecord;
begin
  Data := Sender.GetNodeData(Node);
  if Data^.nodeType <> ntBookInfo then
    TargetCanvas.Font.Style := [fsBold]
  else if not Sender.Selected[Node] then
  begin
    if (bpIsLocal in Data^.BookProps) then
      TargetCanvas.Font.Color := Settings.LocalColor;
    if (bpIsDeleted in Data^.BookProps) then
      TargetCanvas.Font.Color := Settings.DeletedColor;
  end;
end;

procedure TTreeController.BooksAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; CellRect: TRect);
var
  Data: PBookRecord;
  ColumnID: Integer;

  procedure Stars(Value: Integer);
  var
    i: Integer;
    X, Y: Integer;
    w, h: Integer;
  begin
    w := FStarImage.Width;
    h := FStarImage.Height;
    X := CellRect.Left + (CellRect.Right - CellRect.Left - 10 {w} * 5) div 2;
    Y := CellRect.Top + (CellRect.Bottom - CellRect.Top - h) div 2;
    for i := 0 to 4 do
    begin
      if Value > i then
        FStarImage.Draw(TargetCanvas, Rect(X, Y, X + w, Y + h))
      else
        FEmptyStarImage.Draw(TargetCanvas, Rect(X, Y, X + w, Y + h));
      Inc(X, 10 {w});
    end;
  end;

  procedure DrawState;
  var
    CollectionInfo: TCollectionInfo;
    CollectionType: COLLECTION_TYPE;
    BookState: Integer;
    StateImage: TPngImage;
    X, Y: Integer;
    w, h: Integer;
  begin
    CollectionInfo := FSystemData.GetCollectionInfo(Data^.BookKey.DatabaseID);
    CollectionType := CollectionInfo.CollectionType;

    BookState := STATE_REMOTE or STATE_UNREAD or STATE_NOREVIEW;

    if (bpIsLocal in Data^.BookProps) or isLocalCollection(CollectionType) then
      BookState := BookState or STATE_LOCAL;

    if (Data^.Progress = 100) then
      BookState := BookState or STATE_READ;

    if (bpHasReview in Data^.BookProps) then
      BookState := BookState or STATE_REVIEW;

    if isLocalCollection(CollectionType) and (BookState = (STATE_LOCAL or STATE_UNREAD or STATE_NOREVIEW)) then
    begin
      //
      // Для локальных коллекций показываем картинку только если есть хоть один признак из "Прочитана" или "Есть рецензия"
      //
      Exit;
    end;

    StateImage := FBookStateImages[BookState];

    if Assigned(StateImage) then
    begin
      w := StateImage.Width;
      h := StateImage.Height;
      X := CellRect.Left + (CellRect.Right - CellRect.Left - w) div 2;
      Y := CellRect.Top + (CellRect.Bottom - CellRect.Top - h) div 2;
      StateImage.Draw(TargetCanvas, Rect(X, Y, X + w, Y + h));
    end;
  end;

begin
  Data := Sender.GetNodeData(Node);
  Assert(Assigned(Data));

  if Data^.nodeType <> ntBookInfo then
    Exit;

  ColumnID := BooksGetColumnTag(Sender, Column);

  if (ColumnID = COL_STATE) then
    DrawState
  else if (ColumnID = COL_RATE) then
    Stars(Data^.Rate)
  else if (ColumnID = COL_LIBRATE) then
  begin
    if Data^.LibRate <= 5 then
      Stars(Data^.LibRate)
    else
      Stars(0);
  end;
end;

procedure TTreeController.BooksCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Data1, Data2: PBookRecord;
begin
  Data1 := Sender.GetNodeData(Node1);
  Data2 := Sender.GetNodeData(Node2);

  if NoColumn = Column then
  begin
    if Data1^.nodeType = Data2^.nodeType then
    begin
      Result := 0;
      if Data1^.nodeType = ntAuthorInfo then
        Result := CompareStr(TAuthorsHelper.GetList(Data1^.Authors), TAuthorsHelper.GetList(Data2^.Authors))
      else if Data1^.nodeType = ntSeriesInfo then
        Result := CompareStr(Data1^.Series, Data2^.Series)
      else
      begin
        Result := CompareSeqNumber(Data1^.SeqNumber, Data2^.SeqNumber);
        if Result = 0 then
          Result := CompareStr(Data1^.Title, Data2^.Title);
        if Result = 0 then
          Result := CompareStr(Data1^.Series, Data2^.Series);
      end;
    end
    else
      Result := Sign(Ord(Data1^.nodeType) - Ord(Data2^.nodeType));
  end
  else
  begin
    case (Sender as TBookTree).Header.Columns[Column].Tag of
      COL_AUTHOR:  Result := CompareStr(TAuthorsHelper.GetList(Data1^.Authors), TAuthorsHelper.GetList(Data2^.Authors));
      COL_TITLE:   Result := CompareStr(Data1^.Title, Data2^.Title);
      COL_SERIES:  Result := CompareStr(Data1^.Series, Data2^.Series);
      COL_NO:      Result := CompareSeqNumber(Data1^.SeqNumber, Data2^.SeqNumber);
      COL_SIZE:    Result := CompareInt(Data1^.Size, Data2^.Size);
      COL_RATE:    Result := CompareInt(Data1^.Rate, Data2^.Rate);
      COL_GENRE:   Result := CompareStr(TGenresHelper.GetList(Data1^.Genres), TGenresHelper.GetList(Data2^.Genres));
      COL_DATE:    Result := CompareDate(Data1^.Date, Data2^.Date);
      COL_LANG:    Result := CompareStr(Data1^.Lang, Data2^.Lang);
      COL_LIBRATE: Result := CompareInt(Data1^.LibRate, Data2^.LibRate);
    end;
  end;
end;

//
// Список закачек
//
procedure TTreeController.DownloadsLoadNode(Sender: TBaseVirtualTree; Node: PVirtualNode; Stream: TStream);
var
  Data: PDownloadData;
  Size: Integer;
  StrBuffer: PChar;

  function GetString: string;
  begin
    Stream.Read(Size, SizeOf(Size));
    StrBuffer := AllocMem(Size);
    Stream.Read(StrBuffer^, Size);
    Result := (StrBuffer);
    FreeMem(StrBuffer);
  end;

begin
  Assert(Assigned(Sender));
  Assert(Assigned(Node));
  Assert(Assigned(Stream));

  Data := Sender.GetNodeData(Node);

  // ID
  Stream.Read(Data^.BookKey, SizeOf(Data^.BookKey));

  Data^.Title := GetString;
  Data^.Author := GetString;

  // Size
  Stream.Read(Data^.Size, SizeOf(Data^.Size));

  Data^.FileName := GetString;
  Data^.URL := GetString;

  // State
  Stream.Read(Data^.State, SizeOf(Data^.State));
end;

procedure TTreeController.DownloadsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
const
  States: array [TDownloadState] of string = (rstrDownloadStateWaiting, rstrDownloadStateDownloading, rstrDownloadStateDone, rstrDownloadStateError);
var
  Data: PDownloadData;
begin
  Data := Sender.GetNodeData(Node);
  Assert(Assigned(Data));
  case Column of
    0: CellText := Data^.Author;
    1: CellText := Data^.Title;
    2: CellText := GetFormattedSize(Data^.Size);
    3: CellText := States[Data^.State];
  end;
end;

procedure TTreeController.DownloadsPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
var
  Data: PDownloadData;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) and not Sender.Selected[Node] then
    case Data.State of
      dsRun: TargetCanvas.Font.Color := clGreen;
      dsError: TargetCanvas.Font.Color := clRed;
    end;
end;

procedure TTreeController.DownloadsSaveNode(Sender: TBaseVirtualTree; Node: PVirtualNode; Stream: TStream);
var
  Data: PDownloadData;
  Size: Integer;

  procedure WriteString(const S: string);
  begin
    Size := ByteLength(S) + 1;
    Stream.Write(Size, SizeOf(Size));
    Stream.Write(PChar(S)^, Size);
  end;

begin
  Assert(Assigned(Sender));
  Assert(Assigned(Node));
  Assert(Assigned(Stream));

  Data := Sender.GetNodeData(Node);

  if not Assigned(Data) then
    Exit;

  // ID
  Stream.Write(Data^.BookKey, SizeOf(Data^.BookKey));

  WriteString(Data^.Title);
  WriteString(Data^.Author);

  // Size
  Stream.Write(Data^.Size, SizeOf(Data^.Size));

  WriteString(Data^.FileName);
  WriteString(Data^.URL);

  // State
  Stream.Write(Data^.State, SizeOf(Data^.State));
end;

end.
