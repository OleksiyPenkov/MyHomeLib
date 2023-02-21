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

unit frame_DecorativePageBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, frame_WizardPageBase;

type
  TDecorativePageBase = class(TWizardPageBase)
    Panel8: TPanel;
    Panel9: TPanel;
    lblTitle: TLabel;
    lblSubTitle: TLabel;
    lblPageHint: TLabel;
  private
  public
  end;

implementation

{$R *.dfm}

{ TDecorativePageBase }

end.

