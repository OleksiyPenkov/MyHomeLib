(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Authors             Oleksiy Penkov   oleksiy.penkov@gmail.com
  *                     Nick Rymanov     nrymanov@gmail.com
  * Created             
  * Description         
  *
  * $Id: frm_DownloadProgressForm.pas 875 2010-10-25 09:10:20Z nrymanov@gmail.com $
  *
  * History
  *
  ****************************************************************************** *)

unit frm_DownloadProgressForm;

interface

uses
  Windows,
  Messages,
  Classes,
  Controls,
  StdCtrls,
  ComCtrls,
  SysUtils,
  Forms,
  Dialogs,
  unit_Globals,
  frm_BaseProgressForm,
  unit_WorkerThread,
  unit_DownloadBooksThread;

type
  TDownloadProgressForm = class(TProgressFormBase)
    lblCurrent: TLabel;
    pbCurrent: TProgressBar;
    pbTotal: TProgressBar;
    lblTotal: TLabel;
    btnCancel: TButton;
    procedure btnCancelClick(Sender: TObject);

  protected
    procedure StartWorker; override;

    procedure OpenProgress; override;
    procedure SetProgressHint(Style: TProgressBarStyle; State: TProgressBarState); override;
    procedure ShowProgress(Percent: Integer); override;
    procedure SetComment(const Comment: string); override;
    procedure ShowTeletype(const Msg: string; Severity: TTeletypeSeverity); override;

    procedure ShowProgress2(Current, Total: Integer);
    procedure SetComment2(const Current, Total: string);
  end;

var
  DownloadProgressForm: TDownloadProgressForm;

implementation


{$R *.dfm}

{ TDownloadProgressForm }

procedure TDownloadProgressForm.btnCancelClick(Sender: TObject);
begin
  CancelWorker;
end;

procedure TDownloadProgressForm.OpenProgress;
begin
  pbCurrent.Position := 0;
  pbTotal.Position := 0;
end;

procedure TDownloadProgressForm.SetProgressHint(Style: TProgressBarStyle; State: TProgressBarState);
begin
  // ничего не делаем
end;

procedure TDownloadProgressForm.SetComment2(const Current, Total: string);
begin
  if Total <> '' then
    lblTotal.Caption := Total;
  if Current <> '' then
    lblCurrent.Caption := Current;
  lblTotal.Refresh;
  lblCurrent.Refresh;
end;

procedure TDownloadProgressForm.ShowProgress(Percent: Integer);
begin
  // ничего не делаем
end;

procedure TDownloadProgressForm.SetComment(const Comment: string);
begin
  // ничего не делаем
end;

procedure TDownloadProgressForm.ShowTeletype(const Msg: string; Severity: TTeletypeSeverity);
begin
  // ничего не делаем
end;

procedure TDownloadProgressForm.ShowProgress2(Current, Total: Integer);
begin
  if Current > 0 then
    pbCurrent.Position := Current;
  if Total > 0 then
    pbTotal.Position := Total;
end;

procedure TDownloadProgressForm.StartWorker;
var
  Worker: TDownloadBooksThread;
begin
  Assert(Assigned(WorkerThread));

  if not Assigned(WorkerThread) then
    Exit;

  if (WorkerThread is TDownloadBooksThread) then
  begin
    Worker := WorkerThread as TDownloadBooksThread;
    Worker.OnProgress2 := ShowProgress2;
    Worker.OnSetComment2 := SetComment2;
  end;

  inherited StartWorker;
end;

end.
