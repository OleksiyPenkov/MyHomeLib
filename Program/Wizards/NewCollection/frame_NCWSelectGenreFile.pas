{******************************************************************************}
{                                                                              }
{ MyHomeLib                                                                    }
{                                                                              }
{ Version 0.9                                                                  }
{ 20.08.2008                                                                   }
{ Copyright (c) Oleksiy Penkov  oleksiy.penkov@gmail.com                          }
{                                                                              }
{ @author Nick Rymanov nrymanov@gmail.com                                      }
{                                                                              }
{******************************************************************************}

unit frame_NCWSelectGenreFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frame_InteriorPageBase, StdCtrls, ExtCtrls, unit_StaticTip, unit_NCWParams, unit_AutoCompleteEdit;

type
  TframeNCWSelectGenreFile = class(TInteriorPageBase)
    Panel3: TPanel;
    rbSpecialGenreFile: TRadioButton;
    rbDefaultGenreFile: TRadioButton;
    Label10: TLabel;
    edGenreList: TMHLAutoCompleteEdit;
    btnGenreList: TButton;
    pageHint: TMHLStaticTip;
    cbAutoImport: TCheckBox;
    procedure OnSetFileType(Sender: TObject);
    procedure btnGenreListClick(Sender: TObject);

  private
    function IsDataValid: Boolean;

  public
    function Activate(LoadData: Boolean): Boolean; override;
    function Deactivate(CheckData: Boolean): Boolean; override;
  end;

var
  frameNCWSelectGenreFile: TframeNCWSelectGenreFile;


implementation

uses unit_Helpers;

resourcestring
  rstrStandartGenres = 'Использовать файл описания жанров, поставляемый с программой.';
  rstrUserGenres = 'Использовать собственный файл описания жанров.';


{$R *.dfm}

{
TODO -oNickR -cRelease2.0: в файле импорта необходимо сохранять тип хранящихся файлов и список использованных жанров.
Вообще говоря, здесь скрыта идеологическая ошибка.
Проблема в том, что мы даем пользователю указать тип файлов (fb/non-fb) для существующей коллекции.
}

function TframeNCWSelectGenreFile.IsDataValid: Boolean;
var
  strValue: string;
begin
  Result := False;

  if rbSpecialGenreFile.Checked then
  begin
    strValue := Trim(edGenreList.Text);
    if not FileExists(strValue) then
      Exit;
  end;

  Result := True;
end;

function TframeNCWSelectGenreFile.Activate(LoadData: Boolean): Boolean;
var
  rb: TRadioButton;
begin
  if LoadData then
  begin
    if FPParams^.DefaultGenres then
      rb := rbDefaultGenreFile
    else
      rb := rbSpecialGenreFile;

    rb.Checked := True;
    OnSetFileType(rb);

    edGenreList.Text := FPParams^.GenreFile;
  end;

  Result := True;
end;

function TframeNCWSelectGenreFile.Deactivate(CheckData: Boolean): Boolean;
begin
  FPParams^.DefaultGenres := rbDefaultGenreFile.Checked;
  FPParams^.GenreFile := edGenreList.Text;


  if CheckData then
  begin
    Result := IsDataValid;
    if not Result then
      Exit;
  end;

  Result := True;
end;

procedure TframeNCWSelectGenreFile.OnSetFileType(Sender: TObject);
begin
  if Sender = rbDefaultGenreFile then
    pageHint.Caption := rstrStandartGenres
  else if Sender = rbSpecialGenreFile  then
    pageHint.Caption := rstrUserGenres;

  edGenreList.Enabled := (Sender = rbSpecialGenreFile);
  btnGenreList.Enabled := edGenreList.Enabled;
end;

procedure TframeNCWSelectGenreFile.btnGenreListClick(Sender: TObject);
var
  AFileName: string;
begin
  if GetFileName(fnGenreList, AFileName) then
    edGenreList.Text := AFileName;
end;

end.

