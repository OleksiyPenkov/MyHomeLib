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

unit frame_NCWFinish;

interface

uses
  Windows,
  Messages,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  frame_WizardPageBase,
  frame_DecorativePageBase,
  StdCtrls, ExtCtrls;

type
  TframeNCWFinish = class(TDecorativePageBase)
  private
    { Private declarations }
  public
    function PageButtons: TWizardButtons; override;
  end;

var
  frameNCWFinish: TframeNCWFinish;

implementation

{$R *.dfm}

{ TframeNCWFinish }

function TframeNCWFinish.PageButtons: TWizardButtons;
begin
  Result := [wbFinish];
end;

end.

