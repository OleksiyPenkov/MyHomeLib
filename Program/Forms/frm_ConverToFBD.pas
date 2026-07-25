(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov (aka Koreec)
  *
  * Authors Oleksiy Penkov   oleksiy.penkov@gmail.com
  *         Nick Rymanov     nrymanov@gmail.com
  * Created                  22.02.2010
  * Description              
  *
  * $Id: frm_ConverToFBD.pas 1064 2011-09-02 11:33:04Z eg_ $
  *
  * History
  *
  ****************************************************************************** *)

unit frm_ConverToFBD;

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
  StdCtrls,
  Buttons,
  ExtCtrls,
  ImgList,
  FBDDocument,
  FBDAuthorTable,
  unit_Globals,
  unit_Events, System.ImageList;

type
  //
  // Результат обробки однієї книги у пакетному режимі
  //
  TAutoModeResult = (
    amrConverted,  // FBD створено
    amrSkipped,    // книга не потребує перетворення (вже FBD)
    amrLocked,     // файл зайнятий іншим процесом - книгу не чіпали
    amrFailed      // помилка запису; книга лишилась недоторканою
  );

  TfrmConvertToFBD = class(TForm)
    RzPanel1: TPanel;
    pnButtons: TPanel;
    mmAnnotation: TMemo;
    btnSave: TButton;
    RzLabel1: TLabel;
    RzGroupBox2: TGroupBox;
    RzLabel4: TLabel;
    edISBN: TEdit;
    edPublisher: TEdit;
    RzLabel6: TLabel;
    RzLabel7: TLabel;
    edYear: TEdit;
    edCity: TEdit;
    RzLabel5: TLabel;
    ilButtonImages: TImageList;
    btnOpenBook: TButton;
    lblAuthor: TLabel;
    lblTitle: TLabel;
    RzGroupBox3: TGroupBox;
    btnPasteCover: TButton;
    FCover: TImage;
    btnLoad: TButton;
    btnCancel: TButton;
    btnPrevious: TButton;
    btnNext: TButton;
    FBD: TFBDDocument;
    alFBDAuthors: TFBDAuthorTable;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure btnOpenBookClick(Sender: TObject);
    procedure btnPasteCoverClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnPreviousClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);

  private
    FBookRecord: TBookRecord;
    FEditorMode: Boolean;

    FBusy: Boolean;
    FTerminated: Boolean;
    FLastSaveLocked: Boolean;

    // Events:
    FOnReadBook: TBookEvent;
    FOnSelectBook: TSelectBookEvent;
    FOnGetBook: TGetBookEvent;
    FOnChangeBook2Zip: TBookEvent;

    procedure PrepareForm;
    function FillFBDData: Boolean;
    function SaveFBD: Boolean;
    procedure EnableButtons(State: Boolean);

    procedure InternalSelectBook(MoveForward: Boolean);

    function ConvertCurrentBook: TAutoModeResult;

  public
    //
    // Пакетне створення FBD для всіх книг активного дерева.
    //
    procedure AutoMode;

    property OnGetBook: TGetBookEvent read FOnGetBook write FOnGetBook;
    property OnReadBook: TBookEvent read FOnReadBook write FOnReadBook;
    property OnSelectBook: TSelectBookEvent read FOnSelectBook write FOnSelectBook;
    property OnChangeBook2Zip: TBookEvent read FOnChangeBook2Zip write FOnChangeBook2Zip;
  end;

var
  frmConvertToFBD: TfrmConvertToFBD;

implementation

uses
  IOUtils,
  StrUtils,
  //EncdDecd,
  jpeg,
  pngimage,
  Clipbrd,
  unit_MHLHelpers,
  unit_Helpers,
  unit_Errors,
  unit_FileMutex,
  unit_Consts,
  unit_MHL_strings;

resourcestring
  rstrAutoFBDReport = 'Пакетне створення FBD завершено.' + CRLF +
                      'Перетворено: %d' + CRLF +
                      'Пропущено: %d' + CRLF +
                      'Зайнято іншим процесом: %d' + CRLF +
                      'Помилок: %d';

{$R *.dfm}

procedure TfrmConvertToFBD.FormCreate(Sender: TObject);
begin
  FBD.CoverSizeCode := 4;
end;

procedure TfrmConvertToFBD.FormShow(Sender: TObject);
begin
  PrepareForm;
end;

procedure TfrmConvertToFBD.btnOpenBookClick(Sender: TObject);
begin
  Assert(Assigned(FOnReadBook));
  FOnReadBook(FBookRecord);
end;

procedure TfrmConvertToFBD.btnPasteCoverClick(Sender: TObject);
begin
  FBD.LoadCoverFromClpbrd;
end;

procedure TfrmConvertToFBD.btnLoadClick(Sender: TObject);
var
  FileName: string;
begin
  if GetFileName(fnOpenCoverImage, FileName) then
    FBD.LoadCoverFromFile(FileName);
end;

procedure TfrmConvertToFBD.InternalSelectBook(MoveForward: Boolean);
begin
  if FBusy then
    Exit;

  SaveFBD;

  Assert(Assigned(FOnSelectBook));
  FOnSelectBook(MoveForward);

  PrepareForm;
end;

procedure TfrmConvertToFBD.btnPreviousClick(Sender: TObject);
begin
  InternalSelectBook(False);
end;

procedure TfrmConvertToFBD.btnNextClick(Sender: TObject);
begin
  InternalSelectBook(True);
end;

procedure TfrmConvertToFBD.btnSaveClick(Sender: TObject);
begin
  if FBusy then
    Exit;

  //
  // Форму закриваємо лише коли книга справді збережена, інакше користувач
  // втратив би введені дані разом із повідомленням про помилку.
  //
  if SaveFBD then
    ModalResult := mrOk;
end;

procedure TfrmConvertToFBD.btnCancelClick(Sender: TObject);
begin
  FTerminated := True;
end;

procedure TfrmConvertToFBD.PrepareForm;
var
  Folder: string;
begin
  Assert(Assigned(FOnGetBook));
  FOnGetBook(FBookRecord);

  Assert(FBookRecord.GetBookFormat in [bfFbd, bfRaw]);
  FEditorMode := (FBookRecord.GetBookFormat = bfFbd);
  Caption := IfThen(FEditorMode, rstrEditFBD, rstrConvert2FBD);

  lblAuthor.Caption := FBookRecord.Authors[0].GetFullName;
  lblTitle.Caption := FBookRecord.Title;

  // Never bfFb2Zip, so it's always a folder:
  //
  // TODO : POSSIBLE BUG - как насчет смешанных коллекций?
  //
  Folder := FBookRecord.GetBookContainer;

  if FEditorMode
     and
     FBD.Load(Folder, TPath.GetFileNameWithoutExtension(FBookRecord.FileName), FBookRecord.FileExt)
  then
  begin
    alFBDAuthors.Items := FBD.GetAuthors(atlFBD);
    with FBD.Publisher do
    begin
      edPublisher.Text := Publisher.Text;
      edCity.Text := City.Text;
      edISBN.Text := ISBN.Text;
      edYear.Text := Year;
    end;
  end
  else
  begin
    FBD.New(Folder, FBookRecord.FileName, FBookRecord.FileExt);
    edPublisher.Text := '';
    edCity.Text := '';
    edISBN.Text := '';
    edYear.Text := '';
    mmAnnotation.Text := '';
    alFBDAuthors.Clear;
    FCover.Picture := nil;
  end;

  //
  // TODO : зачитывать аннотацию и обложку
  //
end;

function TfrmConvertToFBD.FillFBDData: Boolean;
var
  i: Integer;
  AuthorsFBD: TAuthorDataList;
begin
  SetLength(AuthorsFBD, FBookRecord.AuthorCount);
  for i := 0 to FBookRecord.AuthorCount - 1 do
  begin
    AuthorsFBD[i].Last := FBookRecord.Authors[i].LastName;
    AuthorsFBD[i].First := FBookRecord.Authors[i].FirstName;
    AuthorsFBD[i].Middle := FBookRecord.Authors[i].MiddleName;
    AuthorsFBD[i].Nick := '';
    AuthorsFBD[i].Email := '';
    AuthorsFBD[i].HomePage := '';
  end;

  FBD.SetAuthors(AuthorsFBD, atlBook);
  FBD.SetAuthors(alFBDAuthors.Items, atlFBD);

  with FBD.Title do
  begin
    Booktitle.Text := FBookRecord.Title;
    Keywords.Text := FBookRecord.KeyWords;
    Lang := FBookRecord.Lang;
    FBD.AddSeries(sltBook, FBookRecord.Series, FBookRecord.SeqNumber);

    Genre.Clear;
    for i := 0 to High(FBookRecord.Genres) do
      Genre.Add(FBookRecord.Genres[i].FB2GenreCode);
  end;

  with FBD.Publisher do
  begin
    Publisher.Text := edPublisher.Text;
    City.Text := edCity.Text;
    ISBN.Text := edISBN.Text;
    Year := edYear.Text;
  end;

  FBD.AutoLoadCover;

  Result := True;
end;

//
// Запис FBD у файл книги.
//
// Файл переписується лише під міжпроцесним м'ютексом: поки він наш, жоден інший
// екземпляр MyHomeLib не візьметься за цю саму книгу. Якщо файл зайнятий, нічого
// не робимо - краще пропустити книгу, ніж зіпсувати її.
//
function TfrmConvertToFBD.SaveFBD: Boolean;
var
  SavedCursor: TCursor;
  Lock: TFileMutex;
begin
  Result := False;

  EnableButtons(False);
  FBusy := True;
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    if not FillFBDData then
      Exit;

    Lock := TFileMutex.Create(FBD.ArchiveFileName);
    try
      if not Lock.TryAcquire then
      begin
        FLastSaveLocked := True;
        Exit;
      end;

      FBD.ProgramUsed := GetProgramUsed(Application.ExeName);
      Result := FBD.Save(FEditorMode);
    finally
      FreeAndNil(Lock);
    end;

    //
    // Ім'я у базі змінюємо лише після того, як архів справді створено.
    //
    if Result and not FEditorMode then
    begin
      Assert(Assigned(FOnChangeBook2Zip));
      FOnChangeBook2Zip(FBookRecord);
    end;
  finally
    Screen.Cursor := SavedCursor;
    EnableButtons(True);
    FBusy := False;
  end;
end;

procedure TfrmConvertToFBD.EnableButtons(State: boolean);
begin
  btnPrevious.Enabled := State;
  btnNext.Enabled     := State;
  btnSave.Enabled     := State;
end;

//
// Обробка книги, що зараз завантажена у форму.
//
function TfrmConvertToFBD.ConvertCurrentBook: TAutoModeResult;
begin
  //
  // Книга вже має опис - у пакетному режимі її не чіпаємо: перезапис
  // існуючого FBD не додає нічого, зате це зайва операція над файлом.
  //
  if FEditorMode then
    Exit(amrSkipped);

  FLastSaveLocked := False;
  if SaveFBD then
    Result := amrConverted
  else if FLastSaveLocked then
    Result := amrLocked
  else
    Result := amrFailed;
end;

//
// Пакетний режим.
//
// Проходимо дерево книг тією ж навігацією, що і кнопки "вперед/назад", доки не
// повернемось до книги, з якої почали. Кожна книга обробляється незалежно:
// зайняті та проблемні пропускаються, а не зупиняють весь прохід.
//
procedure TfrmConvertToFBD.AutoMode;
var
  FirstBookKey: TBookKey;
  Converted, Skipped, Locked, Failed: Integer;
begin
  Assert(Assigned(FOnGetBook));
  Assert(Assigned(FOnSelectBook));

  FTerminated := False;
  Converted := 0;
  Skipped := 0;
  Locked := 0;
  Failed := 0;

  FBD.ReportErrors := False;
  Show;
  try
    FOnGetBook(FBookRecord);
    FirstBookKey := FBookRecord.BookKey;

    repeat
      //
      // Беремо тільки книги без опису. Усе інше - fb2, архіви, вже готові FBD -
      // перетворення не потребує, а форма таких книг і не вміє показувати.
      //
      if FBookRecord.GetBookFormat = bfRaw then
      begin
        PrepareForm;
        case ConvertCurrentBook of
          amrConverted: Inc(Converted);
          amrSkipped:   Inc(Skipped);
          amrLocked:    Inc(Locked);
          amrFailed:    Inc(Failed);
        end;
      end
      else
        Inc(Skipped);

      //
      // Без прокачки черги повідомлень кнопка "Скасувати" не отримала б кліку
      // і пакетний режим неможливо було б зупинити.
      //
      Application.ProcessMessages;
      if FTerminated then
        Break;

      FOnSelectBook(True);
      FOnGetBook(FBookRecord);
    until FBookRecord.BookKey.IsSameAs(FirstBookKey);
  finally
    FBD.ReportErrors := True;
    Close;
  end;

  MHLShowInfo(Format(rstrAutoFBDReport, [Converted, Skipped, Locked, Failed]));
end;

end.
