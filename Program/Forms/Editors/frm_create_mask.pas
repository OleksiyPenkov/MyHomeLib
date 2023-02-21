(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Authors Oleksiy Penkov   oleksiy.penkov@gmail.com
  *         Nick Rymanov     nrymanov@gmail.com
  *         Matvienko Sergei matv84@mail.ru
  * Created                  
  * Description              
  *
  * $Id: frm_create_mask.pas 789 2010-09-17 15:49:55Z eg_ $
  *
  * History
  *
  ****************************************************************************** *)

unit frm_create_mask;

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
  Buttons,
  StdCtrls,
  ExtCtrls,
  unit_StaticTip,
  unit_Templater,
  ComCtrls,
  unit_Globals;

type
  TfrmCreateMask = class(TForm)
    edTemplate: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    pnButtons: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label3: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    stDescription: TMHLStaticTip;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit5: TEdit;
    Edit4: TEdit;
    Edit6: TEdit;
    Label9: TLabel;
    CheckBox2: TCheckBox;
    Edit7: TEdit;
    CheckBox3: TCheckBox;
    Edit8: TEdit;
    CheckBox4: TCheckBox;
    Edit9: TEdit;
    CheckBox5: TCheckBox;
    Edit10: TEdit;
    CheckBox6: TCheckBox;
    Label4: TLabel;
    Edit11: TEdit;
    Edit12: TEdit;
    Label10: TLabel;
    CheckBox7: TCheckBox;
    Edit13: TEdit;
    procedure SaveMask(Sender: TObject);
    procedure ParseTestTemplate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure edTemplateChange(Sender: TObject);

  private
    FTemplater: TTemplater;

    FTemplateType: TTemplateType;
    procedure SetTemplateType(const Value: TTemplateType);

    function GetTemplate: string;
    procedure SetTemplate(const Value: string);

    function GetTestData: TBookRecord;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property TemplateType: TTemplateType read FTemplateType write SetTemplateType;
    property Template: string read GetTemplate write SetTemplate;
  end;

function EditTemplate(ATemplateType: TTemplateType; var ATemplate: string): Boolean;

var
  frmCreateMask: TfrmCreateMask;
  Templater: TTemplater;

implementation

uses
  unit_Errors;

{$R *.dfm}

resourcestring
  rstrFileTemplateCaption = 'Редактирование шаблона: Имя файла';
  rstrPathTemplateCaption = 'Редактирование шаблона: Путь к файлу';
  rstrTextTemplateCaption = 'Редактирование шаблона: Текст';
  rstrSampleTemplate = '[%s [(%n) ]- ]%t';
  rstrWrongTemplate = 'Шаблон неверен';
  rstrCheckTemplateValidity = 'Проверьте правильность шаблона';
  rstrCheckBrackets = 'Проверьте соответствие открывающих и закрывающих скобок блоков элемнтов';
  rstrWrongTemplateElements = 'Неверные элементы шаблона';

const
  DlgCaptions: array [TTemplateType] of string = (rstrFileTemplateCaption, rstrPathTemplateCaption, rstrTextTemplateCaption);

function TfrmCreateMask.GetTestData: TBookRecord;
var
  R: TBookRecord;
  code: Integer;
begin
  CurrentSelectedAuthor := '';
  if CheckBox2.Checked then
    R.Title := Edit7.Text;
  if CheckBox3.Checked then
    R.Series := Edit8.Text;
//  if CheckBox5.Checked then
//  begin
//    code := StrToInt(Edit10.Text);
//    if code = 1 then
//      Include(R.BookProps, bpHasReview)
//    else
//      Exclude(R.BookProps, bpHasReview);
//  end;
  if CheckBox5.Checked then
    R.LibID := Edit10.Text;

  if CheckBox4.Checked then
    R.SeqNumber := StrToInt(Edit9.Text);
  if CheckBox1.Checked then
  begin
    TAuthorsHelper.Add(R.Authors, Edit1.Text, Edit2.Text, Edit3.Text);
    TAuthorsHelper.Add(R.Authors, Edit6.Text, Edit4.Text, Edit5.Text);
  end;
  if CheckBox6.Checked then
  begin
    TGenresHelper.Add(R.Genres, '', Edit11.Text, '');
    TGenresHelper.Add(R.Genres, '', Edit12.Text, '');
  end;
  if CheckBox7.Checked then
    R.RootGenre.GenreAlias := Edit13.Text;

  Result := R;
end;

function EditTemplate(ATemplateType: TTemplateType; var ATemplate: string): Boolean;
var
  frmCreateMask: TfrmCreateMask;
begin
  frmCreateMask := TfrmCreateMask.Create(Application);
  try
    frmCreateMask.TemplateType := ATemplateType;
    frmCreateMask.Template := ATemplate;
    Result := (mrOk = frmCreateMask.ShowModal);

    if Result then
      ATemplate := frmCreateMask.Template;
  finally
    frmCreateMask.Free;
  end;
end;

constructor TfrmCreateMask.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTemplater := TTemplater.Create;
  Templater := TTemplater.Create;
end;

destructor TfrmCreateMask.Destroy;
begin
  FTemplater.Free;
  Templater.Free;
  inherited Destroy;
end;

procedure TfrmCreateMask.edTemplateChange(Sender: TObject);
begin
  if PageControl1.ActivePageIndex = 1 then
    ParseTestTemplate(Sender);
end;

procedure TfrmCreateMask.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePageIndex = 0 then
  begin
    Label2.Font.Color := clWindowText;
    Label2.Caption := rstrSampleTemplate;
  end;

  if PageControl1.ActivePageIndex = 1 then
    ParseTestTemplate(Sender);
end;

procedure TfrmCreateMask.ParseTestTemplate(Sender: TObject);
var
  R: TBookRecord;
  Valid: TErrorType;
begin
  Valid := Templater.SetTemplate(edTemplate.Text, FTemplateType);
  if Valid <> ErFine then
  begin
    Label2.Font.Color := clRed;
    Label2.Caption := rstrWrongTemplate;
    exit;
  end;
  R := GetTestData;
  Label2.Font.Color := clWindowText;
  Label2.Caption := Templater.ParseString(R, FTemplateType);
end;

procedure TfrmCreateMask.FormShow(Sender: TObject);
begin
  PageControl1.TabIndex := 0;
  Label2.Caption := rstrSampleTemplate;
end;

function TfrmCreateMask.GetTemplate: string;
begin
  Result := edTemplate.Text;
end;

procedure TfrmCreateMask.SetTemplate(const Value: string);
begin
  edTemplate.Text := Value;
end;

procedure TfrmCreateMask.SetTemplateType(const Value: TTemplateType);
begin
  FTemplateType := Value;
  Caption := DlgCaptions[FTemplateType];
end;

procedure TfrmCreateMask.SaveMask(Sender: TObject);
var
  Valid: TErrorType;
begin
  Valid := FTemplater.ValidateTemplate(Template, TemplateType);

  case Valid of
    ErFine:
      ModalResult := mrOk;
    ErTemplate:
      MHLShowError(rstrCheckTemplateValidity);
    ErBlocks:
      MHLShowError(rstrCheckBrackets);
    ErElements:
      MHLShowError(rstrWrongTemplateElements);
  end;
end;

end.
