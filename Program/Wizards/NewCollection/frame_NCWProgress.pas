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

unit frame_NCWProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frame_WizardPageBase, frame_InteriorPageBase, StdCtrls, ExtCtrls, ComCtrls,
  unit_WorkerThread, unit_NCWParams, unit_Globals;

const
  PM_WORKERDONE = WM_USER + 0;

type
  TframeNCWProgress = class(TInteriorPageBase)
    txtComment: TLabel;
    errorLog: TListView;
    pnButtons: TPanel;
    btnSaveLog: TButton;
    Bar: TProgressBar;
  private
    FErrors: TStringList;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Initialize(PParams: PNCWParams); override;

    procedure OpenProgress;
    procedure ShowProgress(Percent: Integer);
    procedure ShowTeletype(const Msg: string; Severity: TTeletypeSeverity);
    procedure SetComment(const Comment: string);
    procedure CloseProgress;

    procedure ShowSaveLogPanel(AShow: Boolean = True);

    function PageButtons: TWizardButtons; override;
    function HasErrors: Boolean;
  end;

var
  frameNCWProgress: TframeNCWProgress;

implementation

uses
  CommCtrl;

{$R *.dfm}

constructor TframeNCWProgress.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FErrors := TStringList.Create;
end;

destructor TframeNCWProgress.Destroy;
begin
  FErrors.Free;
  inherited Destroy;
end;

procedure TframeNCWProgress.Initialize(PParams: PNCWParams);
begin
  inherited Initialize(PParams);

  errorLog.ShowColumnHeaders := False;
  errorLog.Clear;
end;

function TframeNCWProgress.PageButtons: TWizardButtons;
begin
  Result := [wbCancel];
end;

procedure TframeNCWProgress.OpenProgress;
begin
  Bar.Position := 0;
end;

procedure TframeNCWProgress.SetComment(const Comment: string);
begin
  txtComment.Caption := Comment;
end;

procedure TframeNCWProgress.ShowProgress(Percent: Integer);
begin
  Bar.Position := Percent;
end;

procedure TframeNCWProgress.ShowTeletype(const Msg: string; Severity: TTeletypeSeverity);
var
  item: TListItem;
begin
  item := errorLog.Items.Add;

  case Severity of
    tsInfo: item.ImageIndex := 0;
    tsWarning: item.ImageIndex := 1;
    tsError: item.ImageIndex := 2;
  end;
  item.SubItems.Add(Msg);

  if Severity = tsError then
    FErrors.Add(Msg);

  ListView_EnsureVisible(errorLog.Handle, item.Index, False);
end;

procedure TframeNCWProgress.CloseProgress;
begin
  Assert(Assigned(Parent) and Parent.HandleAllocated);
  PostMessage(Parent.Handle, PM_WORKERDONE, 0, 0);
  ShowProgress(100);
end;

procedure TframeNCWProgress.ShowSaveLogPanel(AShow: Boolean = True);
begin
  pnButtons.Visible := AShow;
end;

function TframeNCWProgress.HasErrors: Boolean;
begin
  Result := (FErrors.Count > 0);
end;

end.

