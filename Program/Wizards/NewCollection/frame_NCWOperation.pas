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

unit frame_NCWOperation;

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
  unit_StaticTip,
  unit_NCWParams;

type
  TframeNCWOperation = class(TInteriorPageBase)
    Panel1: TPanel;
    rbNew: TRadioButton;
    rbExisting: TRadioButton;
    pageHint: TMHLStaticTip;
    rbInpx: TRadioButton;
    rbMetabib: TRadioButton;
    procedure OnSetCollectionType(Sender: TObject);
  private

  public
    function Activate(LoadData: Boolean): Boolean; override;
    function Deactivate(CheckData: Boolean): Boolean; override;
  end;

var
  frameNCWOperation: TframeNCWOperation;

implementation

resourcestring
   rstrCreateNew = 'Виберіть цей пункт для створення порожніх колекцій';
   rstrAddExists = 'Підключити раніше створену колекцію. Потрібен файл колекції *.hlc';
   rstrInpxBased = 'Створити колекцію з наявного файлу inpx (колекції lib.rus.ec, Flibusta, Traum)';
   rstrMetabibBased = 'Створити колекцію з каталогу metabib (*.jsonl, *.jsonl.zst) — новий формат списків Flibusta/Librusec';

{$R *.dfm}

procedure TframeNCWOperation.OnSetCollectionType(Sender: TObject);
begin
  if Sender = rbNew then
    pageHint.Caption := rstrCreateNew
  else if Sender = rbExisting then
    pageHint.Caption := rstrAddExists
  else if Sender = rbInpx then
    pageHint.Caption := rstrInpxBased
  else if Sender = rbMetabib then
    pageHint.Caption := rstrMetabibBased
end;

function TframeNCWOperation.Activate(LoadData: Boolean): Boolean;
var
  rb: TRadioButton;
begin
  if LoadData then
  begin
    case FPParams^.Operation of
      otNew: rb := rbNew;
      otExisting: rb := rbExisting;
      otInpx: rb := rbInpx;
      otMetabib: rb := rbMetabib;
    else
      Assert(False);
      Result := False;
      Exit;
    end;

    Assert(Assigned(rb));

    rb.Checked := True;
    OnSetCollectionType(rb);
  end;

  Result := True;
end;

function TframeNCWOperation.Deactivate(CheckData: Boolean): Boolean;
begin
  if rbNew.Checked then
  begin
    FPParams^.Operation := otNew;
    FPParams^.CollectionType := ltUser;
  end
  else if rbExisting.Checked then
    FPParams^.Operation := otExisting
  else if rbMetabib.Checked then
    FPParams^.Operation := otMetabib
  else
    FPParams^.Operation := otInpx;

  Result := True;
end;

end.

