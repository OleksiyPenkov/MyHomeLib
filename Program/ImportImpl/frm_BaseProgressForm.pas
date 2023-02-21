(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Oleksiy Penkov   oleksiy.penkov@gmail.com
  *                     Nick Rymanov     nrymanov@gmail.com
  * Created             
  * Description         
  *
  * $Id: frm_BaseProgressForm.pas 875 2010-10-25 09:10:20Z nrymanov@gmail.com $
  *
  * History
  *
  ****************************************************************************** *)

unit frm_BaseProgressForm;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  unit_Globals,
  unit_WorkerThread,
  ComCtrls;

type
  TProgressFormBase = class(TForm)
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

  private
    FWorker: TWorker;

  protected
    procedure StartWorker; virtual;

    procedure OpenProgress; virtual; abstract;
    procedure SetProgressHint(Style: TProgressBarStyle; State: TProgressBarState); virtual; abstract;
    procedure ShowProgress(Percent: Integer); virtual; abstract;
    procedure CloseProgress; virtual;
    procedure ShowTeletype(const Msg: string; Severity: TTeletypeSeverity); virtual; abstract;
    procedure SetComment(const Comment: string); virtual; abstract;
    function ShowMessage(const Text: string; Flags: Longint = MB_OK): Integer; virtual;

  public
    destructor Destroy; override;

    procedure CancelWorker;

  public
    property WorkerThread: TWorker read FWorker write FWorker;
  end;

var
  ProgressFormBase: TProgressFormBase;

implementation

uses
  unit_mhl_strings;

{$R *.dfm}

destructor TProgressFormBase.Destroy;
begin
  if Assigned(FWorker) then
  begin
    Assert(FWorker.Finished);
    FWorker.WaitFor;
  end;

  inherited Destroy;
end;

procedure TProgressFormBase.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not FWorker.Finished then
  begin
    CancelWorker;
    CanClose := False;
  end;
end;

procedure TProgressFormBase.FormShow(Sender: TObject);
begin
  StartWorker;
end;

procedure TProgressFormBase.StartWorker;
begin
  Assert(Assigned(FWorker));

  if not Assigned(FWorker) then
    Exit;

  FWorker.OnOpenProgress := OpenProgress;
  FWorker.OnProgressHint := SetProgressHint;
  FWorker.OnProgress := ShowProgress;
  FWorker.OnCloseProgress := CloseProgress;
  FWorker.OnTeletype := ShowTeletype;
  FWorker.OnSetComment := SetComment;
  FWorker.OnShowMessage := ShowMessage;

  FWorker.Start;
end;

procedure TProgressFormBase.CancelWorker;
begin
  Assert(Assigned(FWorker));

  if FWorker.Finished then
    Exit;

  if ShowMessage(rstrCancelOperationWarningMsg, MB_OKCANCEL or MB_ICONEXCLAMATION) = IDCANCEL then
    Exit;

  FWorker.Cancel;
end;

procedure TProgressFormBase.CloseProgress;
begin
  ModalResult := mrOk;
end;

function TProgressFormBase.ShowMessage(const Text: string; Flags: Longint = MB_OK): Integer;
begin
  Result := Application.MessageBox(PChar(Text), PChar(Application.Title), Flags);
end;

end.

