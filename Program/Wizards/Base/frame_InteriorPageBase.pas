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

unit frame_InteriorPageBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, frame_WizardPageBase;

type
  TInteriorPageBase = class(TWizardPageBase)
    pnTitle: TPanel;
    lblTitle: TLabel;
    lblSubTitle: TLabel;
  private
    function GetSubTitle: string;
    function GetTitle: string;
    procedure SetSubTitle(const Value: string);
    procedure SetTitle(const Value: string);

  public

    property Title: string read GetTitle write SetTitle;
    property SubTitle: string read GetSubTitle write SetSubTitle;
  end;

implementation

{$R *.dfm}

{ TframeInteriorPageBase }

function TInteriorPageBase.GetTitle: string;
begin
  Result := lblTitle.Caption;
end;

procedure TInteriorPageBase.SetTitle(const Value: string);
begin
  lblTitle.Caption := Value;
end;

function TInteriorPageBase.GetSubTitle: string;
begin
  Result := lblSubTitle.Caption;
end;

procedure TInteriorPageBase.SetSubTitle(const Value: string);
begin
  lblSubTitle.Caption := Value;
end;

end.

