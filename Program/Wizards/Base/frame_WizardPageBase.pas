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

unit frame_WizardPageBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, unit_NCWParams;

type
  TWizardButton = (wbGoPrev, wbGoNext, wbCancel, wbFinish);
  TWizardButtons = set of TWizardButton;

  TWizardPageBase = class(TFrame)
  protected
    FPParams: PNCWParams;

  public
    procedure Initialize(PParams: PNCWParams); virtual;
    function Activate(LoadData: Boolean): Boolean; virtual;
    function Deactivate(CheckData: Boolean): Boolean; virtual;

    function PageButtons: TWizardButtons; virtual;
  end;

  TWizardPageClass = class of TWizardPageBase;

implementation

{$R *.dfm}

procedure TWizardPageBase.Initialize(PParams: PNCWParams);
begin
  Assert(Assigned(PParams));
  FPParams := PParams;
end;

function TWizardPageBase.PageButtons: TWizardButtons;
begin
  Result := [wbGoPrev, wbGoNext, wbCancel];
end;

function TWizardPageBase.Activate(LoadData: Boolean): Boolean;
begin
  Result := True;
end;

function TWizardPageBase.Deactivate(CheckData: Boolean): Boolean;
begin
  Result := True;
end;

end.

