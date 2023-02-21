(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Authors Oleksiy Penkov   oleksiy.penkov@gmail.com
  *         Nick Rymanov     nrymanov@gmail.com
  * Created                  20.08.2008
  * Description              
  *
  * $Id: frm_edit_book_info.pas 854 2010-10-08 13:43:19Z eg_ $
  *
  * History
  *
  ****************************************************************************** *)

unit frm_edit_book_info;

interface

uses
  Windows,
  Messages,
  Classes,
  Graphics,
  Controls,
  StdCtrls,
  ExtCtrls,
  ComCtrls,
  Forms,
  Dialogs,
  unit_Globals,
  unit_Interfaces,
  unit_Events;

type
  TfrmEditBookInfo = class(TForm)
    edSN: TEdit;
    edT: TEdit;
    lvAuthors: TListView;
    btnADelete: TButton;
    btnAChange: TButton;
    btnAddAuthor: TButton;
    lblGenre: TEdit;
    btnGenres: TButton;
    cbSeries: TComboBox;
    edKeyWords: TEdit;
    cbLang: TComboBox;
    btnNextBook: TButton;
    btnPrevBook: TButton;
    pnButtons: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    gbAuthors: TGroupBox;
    gbExtraInfo: TGroupBox;
    btnOpenBook: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGenresClick(Sender: TObject);
    procedure btnAddAuthorClick(Sender: TObject);
    procedure btnAChangeClick(Sender: TObject);
    procedure btnADeleteClick(Sender: TObject);
    procedure edTChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnNextBookClick(Sender: TObject);
    procedure btnPrevBookClick(Sender: TObject);
    procedure btnOpenBookClick(Sender: TObject);

  private
    FCollection: IBookCollection;
    FBookRecord: TBookRecord;
    FChanged: Boolean;

    FOnHelp: TOnHelpEvent;
    FOnGetBook: TGetBookEvent;
    FOnReadBook: TBookEvent;
    FOnUpdateBook: TBookEvent;
    FOnSelectBook: TSelectBookEvent;

    procedure PrepareForm;
    function SaveData: Boolean;
    procedure DoNextBook(const MoveForward: Boolean);

  public
    property Collection: IBookCollection read FCollection write FCollection;

    property OnReadBook: TBookEvent read FOnReadBook write FOnReadBook;
    property OnHelp: TOnHelpEvent read FOnHelp write FOnHelp;
    property OnGetBook: TGetBookEvent read FOnGetBook write FOnGetBook;
    property OnSelectBook: TSelectBookEvent read FOnSelectBook write FOnSelectBook;
    property OnUpdateBook: TBookEvent read FOnUpdateBook write FOnUpdateBook;
  end;

var
  frmEditBookInfo: TfrmEditBookInfo;

implementation

uses
  SysUtils,
  frm_genre_tree,
  frm_edit_author,
  unit_TreeUtils,
  VirtualTrees,
  unit_Consts;

resourcestring
  rstrProvideAtLeastOneAuthor = '”кажите минимум одного автора!';
  rstrProvideBookTitle = '”кажите название книги!';

{$R *.dfm}

procedure TfrmEditBookInfo.FormShow(Sender: TObject);
var
  SeriesIterator: ISeriesIterator;
  SeriesData: TSeriesData;
begin
  Assert(Assigned(FCollection));

  FChanged := False;

  if frmGenreTree.tvGenresTree.GetFirstSelected = nil then
    FillGenresTree(frmGenreTree.tvGenresTree, FCollection.GetGenreIterator(gmAll));

  cbSeries.Items.BeginUpdate;
  try
    cbSeries.Items.Clear;
    SeriesIterator := FCollection.GetSeriesIterator(smAll);
    while SeriesIterator.Next(SeriesData) do
      cbSeries.Items.Add(SeriesData.SeriesTitle);
  finally
    cbSeries.Items.EndUpdate;
  end;

  FillGenresTree(frmGenreTree.tvGenresTree, FCollection.GetGenreIterator(gmAll));

  PrepareForm;
end;

procedure TfrmEditBookInfo.PrepareForm;
var
  Author: TAuthorData;
  Family: TListItem;
begin
  Assert(Assigned(FOnGetBook));
  FOnGetBook(FBookRecord);

  lvAuthors.Items.Clear;
  for Author in FBookRecord.Authors do
  begin
    Family := lvAuthors.Items.Add;
    Family.Caption := Author.LastName;
    Family.SubItems.Add(Author.FirstName);
    Family.SubItems.Add(Author.MiddleName);
  end;

  frmGenreTree.SelectGenres(FBookRecord.Genres);
  lblGenre.Text := TGenresHelper.GetList(FBookRecord.Genres);

  edT.Text := FBookRecord.Title;
  cbSeries.Text := FBookRecord.Series;
  edSN.Text := IntToStr(FBookRecord.SeqNumber);
  edKeyWords.Text := FBookRecord.KeyWords;
  cbLang.Text := FBookRecord.Lang;
end;

procedure TfrmEditBookInfo.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Dummy: boolean;
begin
  if Key = VK_F1 then
  begin
    Assert(Assigned(FOnHelp));
    FOnHelp(0, 0, Dummy)
  end;
end;

procedure TfrmEditBookInfo.btnGenresClick(Sender: TObject);
begin
  if frmGenreTree.ShowModal = mrOk then
  begin
    frmGenreTree.GetSelectedGenres(FBookRecord);
    lblGenre.Text := TGenresHelper.GetList(FBookRecord.Genres);
    FChanged := True;
  end;
end;

procedure TfrmEditBookInfo.btnAddAuthorClick(Sender: TObject);
var
  Family: TListItem;
  frmEditAuthor: TfrmEditAuthorData;
begin
  frmEditAuthor := TfrmEditAuthorData.Create(Self);
  try
    if frmEditAuthor.ShowModal = mrOk then
    begin
      Family := lvAuthors.Items.Add;
      Family.Caption := frmEditAuthor.LastName;
      Family.SubItems.Add(frmEditAuthor.FirstName);
      Family.SubItems.Add(frmEditAuthor.MidName);

      FChanged := True;
    end;
  finally
    frmEditAuthor.Free;
  end;
end;

procedure TfrmEditBookInfo.btnAChangeClick(Sender: TObject);
var
  Family: TListItem;
  frmEditAuthor: TfrmEditAuthorData;
begin
  Family := lvAuthors.Selected;
  if not Assigned(Family) then
    Exit;

  frmEditAuthor := TfrmEditAuthorData.Create(Self);
  try
    frmEditAuthor.LastName := Family.Caption;
    frmEditAuthor.FirstName := Family.SubItems[0];
    frmEditAuthor.MidName := Family.SubItems[1];

    if frmEditAuthor.ShowModal = mrOk then
    begin
      Family.Caption := frmEditAuthor.LastName;
      Family.SubItems[0] := frmEditAuthor.FirstName;
      Family.SubItems[1] := frmEditAuthor.MidName;

      FChanged := True;
    end;
  finally
    frmEditAuthor.Free;
  end;
end;

procedure TfrmEditBookInfo.btnADeleteClick(Sender: TObject);
begin
  lvAuthors.DeleteSelected;
end;

procedure TfrmEditBookInfo.edTChange(Sender: TObject);
begin
  FChanged := True;
end;

procedure TfrmEditBookInfo.btnSaveClick(Sender: TObject);
begin
  if SaveData then
    ModalResult := mrOk;
end;

procedure TfrmEditBookInfo.btnNextBookClick(Sender: TObject);
begin
  DoNextBook(True);
end;

procedure TfrmEditBookInfo.btnOpenBookClick(Sender: TObject);
begin
  Assert(Assigned(FOnReadBook));
  FOnReadBook(FBookRecord);
end;

procedure TfrmEditBookInfo.btnPrevBookClick(Sender: TObject);
begin
  DoNextBook(False);
end;

function TfrmEditBookInfo.SaveData: boolean;
var
 i: Integer;
begin
  if not FChanged then
  begin
    Result := True;
    Exit;
  end;

  Result := False;

  if lvAuthors.Items.Count = 0 then
  begin
    MessageDlg(rstrProvideAtLeastOneAuthor, mtError, [mbOk], 0);
    Exit;
  end;

  if edT.Text = '' then
  begin
    MessageDlg(rstrProvideBookTitle, mtError, [mbOk], 0);
    Exit;
  end;

  FBookRecord.Title := edT.Text;
  FBookRecord.ClearAuthors;
  for i := 0 to lvAuthors.Items.Count - 1 do
    TAuthorsHelper.Add(FBookRecord.Authors, lvAuthors.Items[i].Caption, lvAuthors.Items[i].SubItems[0], lvAuthors.Items[i].SubItems[1]);
  FBookRecord.Series := cbSeries.Text;
  FBookRecord.SeqNumber := StrToIntDef(edSN.Text, 0);
  FBookRecord.KeyWords := edKeyWords.Text;
  FBookRecord.Lang := cbLang.Text;

  FOnUpdateBook(FBookRecord);
  FChanged := False;

  Result := True;
end;

// Update the current book if changed and move on to another book.
procedure TfrmEditBookInfo.DoNextBook(const MoveForward: Boolean);
begin
  Assert(Assigned(FOnUpdateBook) and Assigned(FOnSelectBook));

  if SaveData then
  begin
    FOnSelectBook(MoveForward);

    PrepareForm;
  end;
end;

end.
