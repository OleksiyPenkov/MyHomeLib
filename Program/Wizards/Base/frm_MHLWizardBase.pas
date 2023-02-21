(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov (nrymanov@gmail.com)
  *                     Oleksiy Penkov oleksiy.penkov@gmail.com
  * Created             20.08.2008
  * Description
  *
  * $Id: frm_MHLWizardBase.pas 1064 2011-09-02 11:33:04Z eg_ $
  *
  * History
  * NickR 03.09.2010    Импорт из XML больше не поддерживается. Удалил соответствующую страницу визарда.
  *
  ****************************************************************************** *)

unit frm_MHLWizardBase;

interface

uses
  Windows,
  Classes,
  SysUtils,
  Controls,
  Forms,
  StdCtrls,
  ExtCtrls,
  Dialogs,
  frame_WizardPageBase;

type
  TMHLWizardBase = class(TForm)
    pnButtons: TPanel;
    btnForward: TButton;
    btnBackward: TButton;
    btnCancel: TButton;

    procedure FormCreate(Sender: TObject);
    procedure DoChangePage(Sender: TObject);
    procedure OnCancel(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

  protected const
    NO_ACTIVE_PAGE = -1;

  strict protected
    FPages: array of TWizardPageBase;
    FCurrentPage: Integer;

    FModalResult: TModalResult;

    function IsPageVisible(PageIndex: Integer): Boolean; virtual; abstract;
    procedure InitWizard; virtual; abstract;
    procedure AfterShowPage; virtual;
    function CanCloseWizard: Boolean; virtual;
    procedure CancelWizard; virtual;

  protected
    procedure AdjustButtons(VisibleButtons: TWizardButtons; EnabledButtons: TWizardButtons);
    function AddPage(pageClass: TWizardPageClass): TWizardPageBase;
    procedure ShowPage(PageIndex: Integer);
    function GetPageIndex(goNext: Boolean): Integer;
    function IsValidPageIndex(PageIndex: Integer): Boolean; inline;

    function ActivePage: TWizardPageBase;
  end;

var
  MHLWizardBase: TMHLWizardBase;

implementation

resourcestring
  rstrCaptionCancel = 'Отмена';
  rstrCaptionClose = 'Закрыть';

{$R *.dfm}

function TMHLWizardBase.AddPage(pageClass: TWizardPageClass): TWizardPageBase;
var
  n: Integer;
begin
  Result := pageClass.Create(Self);
  Result.Parent := Self;

  n := Length(FPages);
  SetLength(FPages, n + 1);
  FPages[n] := Result;
end;

function TMHLWizardBase.GetPageIndex(goNext: Boolean): Integer;
begin
  Result := FCurrentPage;
  while IsValidPageIndex(Result) do
  begin
    if goNext then
      Inc(Result)
    else
      Dec(Result);

    if IsPageVisible(Result) then
      Break;
  end;
end;

function TMHLWizardBase.IsValidPageIndex(PageIndex: Integer): Boolean;
begin
  Result := (Low(FPages) <= PageIndex) and (PageIndex <= High(FPages));
end;

procedure TMHLWizardBase.AdjustButtons(VisibleButtons: TWizardButtons; EnabledButtons: TWizardButtons);
begin
  btnBackward.Enabled := wbGoPrev in EnabledButtons;
  btnForward.Enabled := wbGoNext in EnabledButtons;
  btnCancel.Enabled := (wbCancel in EnabledButtons) or (wbFinish in EnabledButtons);

  if wbCancel in EnabledButtons then
  begin
    btnCancel.Caption := rstrCaptionCancel;
    FModalResult := mrCancel;
  end
  else
  begin
    btnCancel.Caption := rstrCaptionClose;
    FModalResult := mrOk;
  end;
end;

procedure TMHLWizardBase.ShowPage(PageIndex: Integer);
var
  Buttons: TWizardButtons;
begin
  Assert(IsValidPageIndex(PageIndex));

  FPages[PageIndex].Enabled := True;
  FPages[PageIndex].Visible := True;
  FPages[PageIndex].BringToFront;

  if IsValidPageIndex(FCurrentPage) then
  begin
    FPages[FCurrentPage].Enabled := False;
    FPages[FCurrentPage].Visible := False;
  end;

  FCurrentPage := PageIndex;

  Assert(nil <> ActivePage);
  AfterShowPage;

  Buttons := ActivePage.PageButtons;
  AdjustButtons(Buttons, Buttons);
end;

function TMHLWizardBase.ActivePage: TWizardPageBase;
begin
  Assert(IsValidPageIndex(FCurrentPage));

  if IsValidPageIndex(FCurrentPage) then
    Result := FPages[FCurrentPage]
  else
    Result := nil;
end;

procedure TMHLWizardBase.DoChangePage(Sender: TObject);
var
  goForward: Boolean;
  pageIndex: Integer;
begin
  goForward := (Sender = btnForward);

  if IsValidPageIndex(FCurrentPage) and ActivePage.Deactivate(goForward) then
  begin
    pageIndex := GetPageIndex(goForward);

    if not FPages[pageIndex].Activate(goForward) then
      Exit;

    ShowPage(pageIndex);
  end;
end;

procedure TMHLWizardBase.CancelWizard;
begin
  ModalResult := FModalResult;
end;

procedure TMHLWizardBase.OnCancel(Sender: TObject);
begin
  CancelWizard;
end;

function TMHLWizardBase.CanCloseWizard: Boolean;
begin
  Result := True;
end;

procedure TMHLWizardBase.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := CanCloseWizard;
end;

procedure TMHLWizardBase.FormCreate(Sender: TObject);
var
  frame: TWizardPageBase;
begin
  FModalResult := mrCancel;

  InitWizard;

  for frame in FPages do
  begin
    frame.Align := alClient;
    //
    // Constraints необходимо проверять _ДО_ скрытия страницы
    //
    if Constraints.MinHeight < frame.Constraints.MinHeight then
      Constraints.MinHeight := frame.Constraints.MinHeight;
    if Constraints.MinWidth < frame.Constraints.MinWidth then
      Constraints.MinWidth := frame.Constraints.MinWidth;

    frame.Enabled := False;
    frame.Visible := False;
  end;

  FCurrentPage := NO_ACTIVE_PAGE;
  ShowPage(0);
end;

procedure TMHLWizardBase.AfterShowPage;
begin
  Assert(IsValidPageIndex(FCurrentPage));
end;

end.

