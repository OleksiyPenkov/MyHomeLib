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

unit frame_NCWWelcom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frame_WizardPageBase, frame_DecorativePageBase, StdCtrls, ExtCtrls;

type
  TframeNCWWelcom = class(TDecorativePageBase)
  private
    { Private declarations }
  public
    function PageButtons: TWizardButtons; override;
  end;

var
  frameNCWWelcom: TframeNCWWelcom;

implementation

{$R *.dfm}

{ TframeNCWelcom }

function TframeNCWWelcom.PageButtons: TWizardButtons;
begin
  Result := [wbGoNext, wbCancel];
end;

end.

