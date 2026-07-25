(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Oleksiy Penkov  oleksiy.penkov@gmail.com
  * Created             25.07.2026
  * Description         Вибір файлу для ручного оновлення колекції
  *
  ****************************************************************************** *)

unit frm_UpdateFromFile;

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
  StdCtrls;

type
  TdlgUpdateFromFile = class(TForm)
    lblFile: TLabel;
    lblWarning: TLabel;
    edFile: TEdit;
    btnBrowse: TButton;
    cbFull: TCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure edFileChange(Sender: TObject);
  end;

var
  dlgUpdateFromFile: TdlgUpdateFromFile;

function AskUpdateFile(out AFileName: string; out AFull: Boolean): Boolean;

implementation

uses
  unit_Helpers;

{$R *.dfm}

resourcestring
   rstrUpdateFromFileCaption = 'Оновлення колекції з файлу';
   rstrUpdateFileLabel = 'Файл оновлення (*.inpx, *.zip):';
   rstrBrowseCaption = 'Огляд...';
   rstrFullReimportCaption = 'Повний переімпорт (очистити колекцію)';
   rstrFullReimportWarning = 'Колекцію буде очищено й наповнено заново з вибраного ' +
     'файлу. Дані користувача (прочитане, оцінки, групи) буде збережено та ' +
     'відновлено. Без цієї опції записи з файлу лише додаються до колекції.';
   rstrOkCaption = 'OK';
   rstrCancelCaption = 'Скасувати';

procedure TdlgUpdateFromFile.FormCreate(Sender: TObject);
begin
  Caption := rstrUpdateFromFileCaption;
  lblFile.Caption := rstrUpdateFileLabel;
  btnBrowse.Caption := rstrBrowseCaption;
  cbFull.Caption := rstrFullReimportCaption;
  lblWarning.Caption := rstrFullReimportWarning;
  btnOk.Caption := rstrOkCaption;
  btnCancel.Caption := rstrCancelCaption;
end;

procedure TdlgUpdateFromFile.btnBrowseClick(Sender: TObject);
var
  FileName: string;
begin
  if GetFileName(fnOpenUpdate, FileName) then
    edFile.Text := FileName;
end;

procedure TdlgUpdateFromFile.edFileChange(Sender: TObject);
begin
  btnOk.Enabled := (edFile.Text <> '') and FileExists(edFile.Text);
end;

function AskUpdateFile(out AFileName: string; out AFull: Boolean): Boolean;
var
  Dlg: TdlgUpdateFromFile;
begin
  AFileName := '';
  AFull := False;

  Dlg := TdlgUpdateFromFile.Create(Application);
  try
    Result := (mrOk = Dlg.ShowModal);
    if Result then
    begin
      AFileName := Dlg.edFile.Text;
      AFull := Dlg.cbFull.Checked;
    end;
  finally
    Dlg.Free;
  end;
end;

end.
