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
  * $Id: frm_edit_reader.pas 549 2010-08-13 08:02:58Z eg_ $
  *
  * History
  *
  ****************************************************************************** *)

unit frm_edit_reader;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ExtCtrls, unit_AutoCompleteEdit;

type
  TfrmEditReader = class(TForm)
    edExt: TEdit;
    Label1: TLabel;
    edPath: TMHLAutoCompleteEdit;
    Label2: TLabel;
    pnButtons: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    btnBrowse: TButton;
    procedure edPathButtonClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    function GetExtension: string;
    function GetPath: string;
    procedure SetExtension(const Value: string);
    procedure SetPath(const Value: string);
  public
    property Extension: string read GetExtension write SetExtension;
    property Path: string read GetPath write SetPath;
  end;

var
  frmEditReader: TfrmEditReader;

implementation

uses
  unit_Helpers;

resourcestring
  rstrMissingFileType = '“ип файла не указан!';

{$R *.dfm}

procedure TfrmEditReader.edPathButtonClick(Sender: TObject);
var
  AFileName: string;
begin
  if GetFileName(fnSelectReader, AFileName) then
    edPath.Text := AFileName;
end;

function TfrmEditReader.GetExtension: string;
begin
  Result := AnsiLowerCase(Trim(edExt.Text));
end;

function TfrmEditReader.GetPath: string;
begin
  Result := Trim(edPath.Text);
end;

procedure TfrmEditReader.SetExtension(const Value: string);
begin
  edExt.Text := Value;
end;

procedure TfrmEditReader.SetPath(const Value: string);
begin
  edPath.Text := Value;
end;

procedure TfrmEditReader.btnSaveClick(Sender: TObject);
begin
  if Extension = '' then
    MessageDlg(rstrMissingFileType, mtError, [mbOk], 0)
  else
    ModalResult := mrOk;
end;

end.
