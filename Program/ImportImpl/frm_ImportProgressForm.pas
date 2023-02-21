(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)             Nick Rymanov     nrymanov@gmail.com
  * Created               20.08.2008
  * Description         
  *
  * $Id: frm_ImportProgressForm.pas 875 2010-10-25 09:10:20Z nrymanov@gmail.com $
  *
  * History
  *
  ****************************************************************************** *)

unit frm_ImportProgressForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unit_WorkerThread, frm_BaseProgressForm, StdCtrls, ComCtrls, unit_Globals;

type
  TImportProgressForm = class(TProgressFormBase)
    txtComment: TLabel;
    ProgressBar: TProgressBar;
    btnCancel: TButton;
    procedure btnCancelClick(Sender: TObject);
  private
  protected
    procedure OpenProgress; override;
    procedure SetProgressHint(Style: TProgressBarStyle; State: TProgressBarState); override;
    procedure ShowProgress(Percent: Integer); override;
    procedure ShowTeletype(const Msg: string; Severity: TTeletypeSeverity); override;
    procedure SetComment(const Comment: string); override;
  public
  end;

var
  ImportProgressForm: TImportProgressForm;

implementation

{$R *.dfm}

{ TImportProgressForm }

procedure TImportProgressForm.btnCancelClick(Sender: TObject);
begin
  CancelWorker;
end;

procedure TImportProgressForm.OpenProgress;
begin
  ProgressBar.Position := 0;
end;

procedure TImportProgressForm.SetProgressHint(Style: TProgressBarStyle; State: TProgressBarState);
begin
  ProgressBar.Style := Style;
  ProgressBar.State := State;
end;

procedure TImportProgressForm.SetComment(const Comment: string);
begin
  txtComment.Caption := Comment;
end;

procedure TImportProgressForm.ShowProgress(Percent: Integer);
begin
  ProgressBar.Position := Percent;
end;

procedure TImportProgressForm.ShowTeletype(const Msg: string; Severity: TTeletypeSeverity);
begin
  // ничего не делаем
end;

end.

