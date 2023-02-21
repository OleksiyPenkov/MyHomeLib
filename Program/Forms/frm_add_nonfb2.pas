(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Oleksiy Penkov   oleksiy.penkov@gmail.com
  *                     Nick Rymanov     nrymanov@gmail.com
  * Created             22.02.2010
  * Description
  *
  * $Id: frm_add_nonfb2.pas 1127 2013-06-13 05:45:32Z koreec $
  *
  * History
  * NickR 02.03.2010    Код переформатирован
  *
  ****************************************************************************** *)

unit frm_add_nonfb2;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  VirtualTrees,
  StdCtrls,
  ShellApi,
  Mask,
  ComCtrls,
  Menus,
  files_list,
  unit_globals,
  unit_Interfaces,
  FBDDocument,
  FBDAuthorTable,
  Buttons,
  MHLSimplePanel;

type
  TfrmAddnonfb2 = class(TForm)
    pmEdit: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    flFiles: TFilesList;
    N5: TMenuItem;
    miClearAll: TMenuItem;
    pmMain: TPopupMenu;
    N6: TMenuItem;
    miOpenExplorer: TMenuItem;
    miOpenFile: TMenuItem;
    pcPages: TPageControl;
    tsFiles: TTabSheet;
    Tree: TVirtualStringTree;
    tsBookInfo: TTabSheet;
    edFileName: TEdit;
    btnCopyToFamily: TButton;
    btnCopyToName: TButton;
    btnCopyToTitle: TButton;
    btnCopyToSeries: TButton;
    btnRenameFile: TBitBtn;
    gbExtraInfo: TGroupBox;
    lblGenre: TLabel;
    btnShowGenres: TButton;
    cbLang: TComboBox;
    edKeyWords: TEdit;
    edSN: TEdit;
    cbSeries: TComboBox;
    edTitle: TEdit;
    btnNext: TBitBtn;
    btnClose: TBitBtn;
    btnOpenBook: TBitBtn;
    FBD: TFBDDocument;
    gbOptions: TGroupBox;
    cbAutoSeries: TCheckBox;
    cbSelectFileName: TCheckBox;
    cbNoAuthorAllowed: TCheckBox;
    cbClearOptions: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    cbForceConvertToFBD: TCheckBox;
    Label3: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    gbFDBCover: TGroupBox;
    FCover: TImage;
    btnPasteCover: TButton;
    btnLoad: TButton;
    MHLSimplePanel1: TMHLSimplePanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    alBookAuthors: TFBDAuthorTable;
    TabSheet2: TTabSheet;
    alFBDAuthors: TFBDAuthorTable;
    TabSheet3: TTabSheet;
    mmAnnotation: TMemo;
    TabSheet4: TTabSheet;
    RzLabel4: TLabel;
    RzLabel6: TLabel;
    RzLabel7: TLabel;
    RzLabel5: TLabel;
    edISBN: TEdit;
    edPublisher: TEdit;
    edYear: TEdit;
    edCity: TEdit;

    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure TreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
    procedure TreeDblClick(Sender: TObject);
    procedure TreeChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure TreePaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
    procedure TreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure TreeClick(Sender: TObject);

    procedure flFilesDirectory(Sender: TObject; const Dir: string);
    procedure flFilesFile(Sender: TObject; const F: TSearchRec);

    procedure RzButton3Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnShowGenresClick(Sender: TObject);
    procedure btnCopyToTitleClick(Sender: TObject);
    procedure btnCopyToSeriesClick(Sender: TObject);
    procedure btnCopyToFamilyClick(Sender: TObject);
    procedure btnCopyToNameClick(Sender: TObject);
    procedure miClearAllClick(Sender: TObject);
    procedure miOpenExplorerClick(Sender: TObject);
    procedure miRenameFileClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnPasteCoverClick(Sender: TObject);
    procedure dtnConvertClick(Sender: TObject);
    procedure btnFileOpenClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure AddAuthorFromList(Sender: TObject);

  private
    FCollection: IBookCollection;
    FRootPath: string;

    FBookRecord: TBookRecord;

    procedure PrepareBookRecord;
    procedure CommitData;

    procedure ScanFolder;
    procedure FillLists;
    procedure SortTree;
    procedure FillFBDData;

    function CheckEmptyFields(Data: PFileData): Boolean;

  public
    property Collection: IBookCollection read FCollection write FCollection;
  end;

var
  frmAddnonfb2: TfrmAddnonfb2;

implementation

uses
  IOUtils,
  frm_genre_tree,
  unit_TreeUtils,
  unit_Consts,
  dm_user,
  unit_MHLHelpers,
  unit_Helpers,
  frm_author_list,
  unit_MHLArchiveHelpers;

resourcestring
  rstrFileNotSelected = 'Файл не выбран!';
  rstrProvideAtLeastOneAuthor = 'Укажите минимум одного автора!';
  rstrProvideBookTitle = 'Укажите название книги!';
  rstrFailedToRename = 'Переименование не удалось!' + CRLF + 'Возможно, файл заблокирован другой программой.';

{$R *.dfm}

procedure TfrmAddnonfb2.FillLists;
var
  SeriesIterator: ISeriesIterator;
  SeriesData: TSeriesData;
begin
  Assert(Assigned(FCollection));

  cbSeries.Items.BeginUpdate;
  try
    SeriesIterator := FCollection.GetSeriesIterator(smAll);
    while SeriesIterator.Next(SeriesData) do
      cbSeries.Items.Add(SeriesData.SeriesTitle);
  finally
    cbSeries.Items.EndUpdate;
  end;
end;

procedure TfrmAddnonfb2.btnShowGenresClick(Sender: TObject);
var
  Data: PGenreData;
  Node: PVirtualNode;
begin

  if frmGenreTree.ShowModal = mrOk then
  begin
    lblGenre.Caption := '';
    Node := frmGenreTree.tvGenresTree.GetFirstSelected;
    while Node <> nil do
    begin
      Data := frmGenreTree.tvGenresTree.GetNodeData(Node);
      lblGenre.Caption := lblGenre.Caption + Data^.GenreAlias + ' ; ';
      Node := frmGenreTree.tvGenresTree.GetNextSelected(Node);
    end;
  end;
end;

procedure TfrmAddnonfb2.btnCopyToFamilyClick(Sender: TObject);
var
  Author: TAuthorRecord;
begin
  Author.Last := Trim(edFileName.SelText);
  alBookAuthors.AddAuthor(Author);
end;

procedure TfrmAddnonfb2.btnCopyToNameClick(Sender: TObject);
var
  Author: TAuthorRecord;
begin
  if alBookAuthors.Count > 0 then
  begin
    Author := alBookAuthors.ActiveRecord;
    Author.First := Trim(edFileName.SelText);
    alBookAuthors.ActiveRecord := Author;
  end;
end;

procedure TfrmAddnonfb2.btnCopyToSeriesClick(Sender: TObject);
begin
  cbSeries.Text := Trim(edFileName.SelText);
end;

procedure TfrmAddnonfb2.btnCopyToTitleClick(Sender: TObject);
begin
  edTitle.Text := Trim(edFileName.SelText);
end;

procedure TfrmAddnonfb2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Settings.ForceConvertToFBD := cbForceConvertToFBD.Checked;
  CanClose := True;
end;

procedure TfrmAddnonfb2.FormShow(Sender: TObject);
begin
  Assert(Assigned(FCollection));

  cbForceConvertToFBD.Checked := Settings.ForceConvertToFBD;

  miClearAllClick(Sender);
  lblGenre.Caption := '';

  ScanFolder;

  FillLists;
  FillGenresTree(frmGenreTree.tvGenresTree, FCollection.GetGenreIterator(gmAll), True);
  pcPages.ActivePageIndex := 0;

  FBD.CoverSizeCode := 4;

  alBookAuthors.AddAuthorFromListButton.OnClick := AddAuthorFromList;
  alBookAuthors.AddAuthorFromListButton.Visible := True;
end;

procedure TfrmAddnonfb2.FillFBDData;
var
  Cover: TCover;
  Genre: TGenreData;
begin
  FBD.ProgramUsed := GetProgramUsed(Application.ExeName);
  Cover := FBD.Cover;

  FBD.New(FRootPath + FBookRecord.Folder, FBookRecord.FileName, FBookRecord.FileExt);
  FBD.Title.Genre.Clear;
  FBD.Custom.Clear;

  FBD.Title.Booktitle.Text := edTitle.Text;
  FBD.Title.Keywords.Text := edKeyWords.Text;
  FBD.Title.Lang := cbLang.Text;

  for Genre in FBookRecord.Genres do
    FBD.Title.Genre.Add(Genre.FB2GenreCode);

  FBD.SetAuthors(alBookAuthors.Items, atlBook);
  FBD.SetAuthors(alFBDAuthors.Items, atlFBD);

  FBD.AddSeries(sltBook, cbSeries.Text, StrToIntDef(edSN.Text, 0));

  FBD.Publisher.Publisher.Text := edPublisher.Text;
  FBD.Publisher.City.Text := edCity.Text;
  FBD.Publisher.ISBN.Text := edISBN.Text;
  FBD.Publisher.Year := edYear.Text;

  FBD.AutoLoadCover;

  FBD.Cover := Cover;
  FBD.Save(False);
  FBookRecord.FileName := FBookRecord.FileName + ZIP_EXTENSION;
end;

procedure TfrmAddnonfb2.miClearAllClick(Sender: TObject);
begin
  edTitle.Text := '';
  edFileName.Text := '';
  alBookAuthors.Clear;
  alFBDAuthors.Clear;
  cbSeries.Text := '';
  edSN.Text := '0';
  edKeyWords.Text := '';

  edPublisher.Clear;
  edCity.Clear;
  edISBN.Clear;
  edYear.Clear;

  mmAnnotation.Lines.Clear;
  FBD.ClearCover;
  FCover.Picture := nil;
end;

procedure TfrmAddnonfb2.miOpenExplorerClick(Sender: TObject);
var
  Data: PFileData;
begin
  Data := Tree.GetNodeData(Tree.GetFirstSelected);
  if (Data = nil) or (Data.DataType = dtFolder) then
    Exit;
  SimpleShellExecute(Handle, ExtractFilePath(Data^.FullPath), '', 'explore');
end;

function TfrmAddnonfb2.CheckEmptyFields(Data: PFileData): Boolean;
begin
  Result := False;
  try
    if not Assigned(Data) then
      raise EInvalidOp.Create(rstrFileNotSelected);

    if (not cbNoAuthorAllowed.Checked) and (alBookAuthors.Count = 0) then
      raise EInvalidOp.Create(rstrProvideAtLeastOneAuthor);

    if edTitle.Text = '' then
      raise EInvalidOp.Create(rstrProvideBookTitle);

    if Data^.DataType = dtFolder then
      Result := False
    else
      Result := True;
  finally
  end;
end;

procedure TfrmAddnonfb2.CommitData;
var
  Next: PVirtualNode;
  Data: PFileData;
begin
  Assert(Assigned(FCollection));

  FCollection.InsertBook(FBookRecord, True, True);

  FBookRecord.Clear;

  Next := Tree.GetNext(Tree.GetFirstSelected);
  Tree.DeleteNode(Tree.GetFirstSelected);
  if Assigned(Next) then
    Tree.Selected[Next] := True;

  case cbClearOptions.ItemIndex of
    0: miClearAllClick(nil);
    1: alBookAuthors.Clear;
    2: edTitle.Text := '';
  end;

  FillLists;

  if cbAutoSeries.Checked then
    edSN.Text := IntToStr(StrToIntDef(edSN.Text, 0) + 1);

  TreeChange(Tree, Next);

  Data := Tree.GetNodeData(Next);
  if Assigned(Data) and (Data^.DataType = dtFile) then
    pcPages.ActivePage := tsBookInfo
  else
    pcPages.ActivePage := tsFiles;
end;

procedure TfrmAddnonfb2.dtnConvertClick(Sender: TObject);
var
  SavedCursor: TCursor;
begin
  Self.Enabled := False;
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    PrepareBookRecord;
    if cbForceConvertToFBD.Checked then
    begin
      FillFBDData;
    end;
    CommitData;
  finally
    Screen.Cursor := SavedCursor;
    Self.Enabled := True;
  end;
end;

procedure TfrmAddnonfb2.miRenameFileClick(Sender: TObject);
var
  NewName: string;
  Data: PFileData;
begin
  btnRenameFile.Enabled := False;
  try
    Data := Tree.GetNodeData(Tree.GetFirstSelected);
    if CheckEmptyFields(Data) then
    begin
      NewName := CheckSymbols(alBookAuthors.ActiveRecord.Last + ' ' + alBookAuthors.ActiveRecord.First + ' ' + edTitle.Text);
      if RenameFile(Data^.FullPath + Data^.FileName + Data^.Ext, Data^.FullPath + NewName + Data^.Ext) then
      begin
        Data^.FileName := NewName;
        edFileName.Text := NewName;
        Tree.RepaintNode(Tree.GetFirstSelected);
      end
      else
        MessageDlg(rstrFailedToRename, mtError, [mbOk], 0);
    end;
  finally
    btnRenameFile.Enabled := True;
  end;
end;

procedure TfrmAddnonfb2.PrepareBookRecord;
var
  Data: PFileData;
  Author: TAuthorRecord;
begin
  Data := Tree.GetNodeData(Tree.GetFirstSelected);
  if not CheckEmptyFields(Data) then
    Exit;

  if alBookAuthors.Count > 0 then
  begin
    for Author in alBookAuthors.Items do
      TAuthorsHelper.Add(FBookRecord.Authors, Author.Last, Author.First, Author.Middle);
  end
  else
    TAuthorsHelper.Add(FBookRecord.Authors, rstrUnknownAuthor, '', '');

  frmGenreTree.GetSelectedGenres(FBookRecord);

  FBookRecord.Title := edTitle.Text;
  FBookRecord.Series := cbSeries.Text;
  if Data^.Folder <> '\' then
    FBookRecord.Folder := Data^.Folder
  else
    FBookRecord.Folder := '';
  FBookRecord.FileName := Data^.FileName;
  FBookRecord.FileExt := Data^.Ext;
  FBookRecord.BookProps := [];
  FBookRecord.SeqNumber := StrToIntDef(edSN.Text, 0);
  FBookRecord.LibID := '';
  FBookRecord.Size := Data^.Size;
  FBookRecord.Date := Now;
  FBookRecord.KeyWords := edKeyWords.Text;
  FBookRecord.Lang := cbLang.Text;
  Include(FBookrecord.BookProps, bpIsLocal);
end;

procedure TfrmAddnonfb2.AddAuthorFromList(Sender: TObject);
var
  frmAuthorList: TfrmAuthorList;
  Row: TAuthorRecord;
  Data: PAuthorData;
  Node: PVirtualNode;
begin
  frmAuthorList := TfrmAuthorList.Create(Application);
  try
    Assert(Assigned(FCollection));
    FillAuthorTree(frmAuthorList.tvAuthorList, FCollection.GetAuthorIterator(amAll));

    if frmAuthorList.ShowModal = mrOk then
    begin
      Node := frmAuthorList.tvAuthorList.GetFirstSelected;
      while Assigned(Node) do
      begin
        Data := frmAuthorList.tvAuthorList.GetNodeData(Node);

        Row.Last := Data^.LastName;
        Row.First := Data^.FirstName;
        Row.Middle := Data^.MiddleName;

        alBookAuthors.AddAuthor(Row);

        Node := frmAuthorList.tvAuthorList.GetNextSelected(Node);
      end;
    end;
  finally
    frmAuthorList.Free;
  end;
end;

procedure TfrmAddnonfb2.btnAddClick(Sender: TObject);
begin
  PrepareBookRecord;
  CommitData;
end;

procedure TfrmAddnonfb2.btnLoadClick(Sender: TObject);
var
  FileName: string;
begin
  if GetFileName(fnOpenCoverImage, FileName) then
    FBD.LoadCoverFromFile(FileName);
end;

procedure TfrmAddnonfb2.btnNextClick(Sender: TObject);
var
  archiver: TMHLZip;
begin
  // Конвертация в FBD и добавление в базу
  Screen.Cursor := crHourGlass;
  Enabled := False;
  try
    PrepareBookRecord;
    if cbForceConvertToFBD.Checked then
    begin
      FillFBDData;

      // после создания архива нужно узнать реальный номер внутри
      FBookRecord.CollectionRoot := FRootPath;
      try
        archiver := TMHLZip.Create(FBookRecord.GetBookFileName, True);
        FBookRecord.InsideNo := archiver.GetIdxByExt(FBookRecord.FileExt);
      finally
        FreeAndNil(archiver);
      end;
      // заносим данные в БД
      CommitData;
    end
      else CommitData;
  finally
    Enabled := True;
    Screen.Cursor := crDefault;
    pcPages.ActivePageIndex := 0;
  end;
 end;

procedure TfrmAddnonfb2.btnPasteCoverClick(Sender: TObject);
begin
  FBD.LoadCoverFromClpbrd;
end;

procedure TfrmAddnonfb2.flFilesDirectory(Sender: TObject; const Dir: string);
var
  Data: PFileData;
  ParentNode: PVirtualNode;
  CurrentNode: PVirtualNode;
  ParentName: string;
  Path: string;

  procedure InsertNodeData(Node: PVirtualNode);
  begin
    Data := Tree.GetNodeData(Node);

    Initialize(Data^);
    Data^.Title := ExtractFileName(ExcludeTrailingPathdelimiter(Path));
    Data^.Folder := Path;
    Data^.DataType := dtFolder;
    Include(Node^.States, vsInitialized);
  end;

begin
  Path := ExtractRelativePath(FRootPath, Dir);
  if Path = '' then
    Exit;

  ParentName := ExtractFilePath(ExcludeTrailingPathdelimiter(Path));
  ParentNode := FindParentInTree(Tree, ParentName);
  if ParentNode <> nil then
  begin
    CurrentNode := Tree.AddChild(ParentNode);
    InsertNodeData(CurrentNode);
  end
  else if (FindParentInTree(Tree, Path) = nil) then
  begin
    CurrentNode := Tree.AddChild(Nil);
    InsertNodeData(CurrentNode);
  end;
end;

procedure TfrmAddnonfb2.flFilesFile(Sender: TObject; const F: TSearchRec);
var
  FullName: string;
  FileName: string;
  Data: PFileData;
  Path: String;
  ParentNode: PVirtualNode;
  CurrentNode: PVirtualNode;
  Ext: string;
begin
  if (F.Name = '.') or (F.Name = '..') then
    Exit;

  Ext := ExtractFileExt(F.Name);
  if Ext = '' then
    Exit;

  //
  // Пропустим fb2-документы и зипы
  //
  if (CompareText(Ext, FB2_EXTENSION) = 0) or (CompareText(Ext, ZIP_EXTENSION) = 0) then
    Exit;

  //
  // Проверим, есть ли у нас ридер для этого документа
  //

  if Settings.Readers.Find(Ext) = nil then
    Exit;

  Assert(Assigned(FCollection));
  if FCollection.CheckFileInCollection(F.Name, False, True) then
    Exit;

  FullName := ExtractRelativePath(FRootPath, flFiles.LastDir + F.Name);
  FileName := TPath.GetFileNameWithoutExtension(F.Name);
  Path := ExtractRelativePath(FRootPath, flFiles.LastDir);

  ParentNode := FindParentInTree(Tree, Path);

  CurrentNode := Tree.AddChild(ParentNode);
  Data := Tree.GetNodeData(CurrentNode);

  Initialize(Data^);
  Data^.DataType := dtFile;
  Data^.FileName := FileName;
  Data^.Size := F.Size;
  Data^.FullPath := flFiles.LastDir;
  Data^.Folder := Path;
  Data^.Ext := Ext;
  Data^.Date := F.Time;
  Include(CurrentNode.States, vsInitialized);
end;

procedure TfrmAddnonfb2.ScanFolder;
begin
  Tree.Clear;
  Tree.NodeDataSize := SizeOf(TFileData);

  FRootPath := FCollection.CollectionRoot;

  flFiles.TargetPath := FRootPath;
  flFiles.Process;
  SortTree;
end;

procedure TfrmAddnonfb2.SortTree;
var
  A, B: PVirtualNode;
  Data, DataA, DataB: PFileData;
  Parent: PVirtualNode;
begin
  Parent := Tree.GetFirst;
  Data := Tree.GetNodeData(Parent);
  while Parent <> nil do
  begin
    if (Data.DataType = dtFolder) and (Tree.HasChildren[Parent]) then
    begin
      A := Tree.GetFirstChild(Parent);
      while (A <> Parent.LastChild) do
      begin
        DataA := Tree.GetNodeData(A);
        B := Tree.GetNext(A);
        DataB := Tree.GetNodeData(B);
        if (A.Parent = B.Parent) and (DataA.DataType = dtFile) and (DataB.DataType = dtFolder) then
        begin
          Tree.MoveTo(B, A, amInsertBefore, False);
          A := Parent.FirstChild;
        end
        else
          A := B;
        B := Tree.GetNext(B);
      end;
    end;

    if (Data.DataType = dtFolder) and (Parent.ChildCount = 0) then
      Tree.DeleteNode(Parent);

    Parent := Tree.GetNext(Parent);
    Data := Tree.GetNodeData(Parent);
  end;
end;

procedure TfrmAddnonfb2.btnFileOpenClick(Sender: TObject);
var
  Data: PFileData;
  S: string;
begin
  Data := Tree.GetNodeData(Tree.GetFirstSelected);
  if Data <> nil then
  begin
    S := AnsiLowercase(Data^.FullPath + Data^.FileName + Data^.Ext);
    SimpleShellExecute(Handle, S);
  end;
end;

procedure TfrmAddnonfb2.RzButton3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmAddnonfb2.TreeChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  TreeClick(Sender);
end;

procedure TfrmAddnonfb2.TreeClick(Sender: TObject);
var
  Data: PFileData;
begin
  Data := Tree.GetNodeData(Tree.GetFirstSelected);
  if not Assigned(Data) or (Data^.DataType = dtFolder) then
    Exit;

  edFileName.Text := Data^.FileName;

  if cbSelectFileName.Checked then
    edFileName.SelectAll;
end;

procedure TfrmAddnonfb2.TreeDblClick(Sender: TObject);
begin
  pcPages.ActivePageIndex := 1;
end;

procedure TfrmAddnonfb2.TreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PFileData;
begin
  Data := Tree.GetNodeData(Node);
  if Assigned(Data) then
    Finalize(Data^);
end;

procedure TfrmAddnonfb2.TreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
var
  Data: PFileData;
begin
  Data := Sender.GetNodeData(Node);
  case Data^.DataType of
    dtFolder:
      if Column = 0 then
        CellText := Data^.Title
      else
        CellText := '';

    dtFile:
      case Column of
        0: CellText := Data^.FileName;
        1: CellText := CleanExtension(Data^.Ext);
        2: CellText := GetFormattedSize(Data^.Size);
        3: CellText := '';
      end;
  end;
end;

procedure TfrmAddnonfb2.TreePaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
var
  Data: PFileData;
begin
  Data := Tree.GetNodeData(Node);
  if Data.DataType = dtFolder then
    TargetCanvas.Font.Style := [fsBold]
end;

end.
