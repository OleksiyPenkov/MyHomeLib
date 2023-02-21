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

unit frame_NCWCollectionFileTypes;

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
  frame_InteriorPageBase,
  StdCtrls,
  ExtCtrls,
  unit_StaticTip;

type
  TframeNCWCollectionFileTypes = class(TInteriorPageBase)
    Panel3: TPanel;
    rbSoreAnyFiles: TRadioButton;
    rbSoreFB2Files: TRadioButton;
    pageHint: TMHLStaticTip;
    cbAutoImport: TCheckBox;
    procedure OnSetFileType(Sender: TObject);

  private

  public
    function Activate(LoadData: Boolean): Boolean; override;
    function Deactivate(CheckData: Boolean): Boolean; override;
  end;

var
  frameNCWCollectionFileTypes: TframeNCWCollectionFileTypes;

implementation

uses
  unit_NCWParams;

resourcestring
  rstrCollectionTypeFB2 = 'Книги в формате fb2 (обычно художественная литература). Книги могут быть упакованы в архив по несколько штук (zip) или по одиночке (fb2.zip). ';
  rstrCollectionTypeAny = 'Книги в любом формате. Вы будете сами заполнять информацию о книге при добавлении ее в коллекцию. Вы также можете указать файл с описанием жанров на следующей странице.';

{$R *.dfm}

{
TODO -oNickR -cRelease2.0: в файле импорта необходимо сохранять тип хранящихся файлов и список использованных жанров.
Вообще говоря, здесь скрыта идеологическая ошибка.
Проблема в том, что мы даем пользователю указать тип файлов (fb/non-fb) для существующей коллекции.
}

function TframeNCWCollectionFileTypes.Activate(LoadData: Boolean): Boolean;
var
  rb: TRadioButton;
begin
  Assert(FPParams^.Operation = otNew);

  if LoadData then
  begin
    if ftFB2 = FPParams^.FileTypes then
      rb := rbSoreFB2Files
    else {if ftAny = FPParams^.FileTypes then}
      rb := rbSoreAnyFiles;

    rb.Checked := True;
    OnSetFileType(rb);
  end;

  cbAutoImport.Enabled := rbSoreFB2Files.Checked;

  Result := True;
end;

function TframeNCWCollectionFileTypes.Deactivate(CheckData: Boolean): Boolean;
begin
  if rbSoreFB2Files.Checked then
    FPParams^.FileTypes := ftFB2
  else {if rbSoreAnyFiles.Checked then}
    FPParams^.FileTypes := ftAny;

  FPParams^.AutoImport := cbAutoImport.Checked;
  Result := True;
end;

procedure TframeNCWCollectionFileTypes.OnSetFileType(Sender: TObject);
begin
  if Sender = rbSoreFB2Files then
    pageHint.Caption := rstrCollectionTypeFB2
  else if Sender = rbSoreAnyFiles  then
    pageHint.Caption := rstrCollectionTypeAny;

  cbAutoImport.Enabled := rbSoreFB2Files.Checked;
end;

end.

