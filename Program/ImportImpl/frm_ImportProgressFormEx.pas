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
  * $Id: frm_ImportProgressFormEx.pas 1167 2014-06-16 02:07:14Z koreec $
  *
  * History
  *
  ****************************************************************************** *)

unit frm_ImportProgressFormEx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unit_WorkerThread, frm_ImportProgressForm, StdCtrls, ComCtrls, unit_Globals,
  ExtCtrls;

type
  TImportProgressFormEx = class(TImportProgressForm)
    errorLog: TListView;
    btnSaveLog: TButton;
    Timer: TTimer;

    procedure FormCreate(Sender: TObject);
    procedure btnSaveLogClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    FCloseOnTimer: boolean;
    FErrors: TStringList;
    procedure DoCloseForm(Sender: TObject);

  protected
    procedure ShowTeletype(const Msg: string; Severity: TTeletypeSeverity); override;
    procedure CloseProgress; override;

  public
    property CloseOnTimer: Boolean read FCloseOnTimer write FCloseOnTimer;
    procedure SaveErrorLog(AFileName: string);
  end;

var
  ImportProgressFormEx: TImportProgressFormEx;

implementation

uses 
  unit_Helpers;

resourcestring
  rstrClose = 'Закрыть';

{$R *.dfm}

{ TImportProgressForm1 }

procedure TImportProgressFormEx.btnSaveLogClick(Sender: TObject);
var
  FileName: string;
begin
  if GetFileName(fnSaveLog, FileName) then SaveErrorLog(FileName);
end;

procedure TImportProgressFormEx.DoCloseForm(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TImportProgressFormEx.CloseProgress;
begin
  if FErrors.Count <> 0 then
    btnSaveLog.Visible := True;
  btnCancel.OnClick := DoCloseForm;
  btnCancel.Caption := rstrClose;
  Timer.Enabled := FCloseOnTimer;
end;

procedure TImportProgressFormEx.FormCreate(Sender: TObject);
begin
  inherited;
  FErrors := TStringList.Create;
  errorLog.ShowColumnHeaders := False;
  errorLog.Clear;
  FCloseOnTimer := False;
end;

procedure TImportProgressFormEx.FormDestroy(Sender: TObject);
begin
  FErrors.Free;
  inherited;
end;

procedure TImportProgressFormEx.SaveErrorLog;
begin
  try
    FErrors.SaveToFile(AFileName, TEncoding.Unicode);
  except
    on e: EFileStreamError do
    begin
      Application.MessageBox(
        PChar(e.Message),
        PChar(Application.Title),
        MB_OK or MB_ICONERROR
        );
    end;
  end;
end;

procedure TImportProgressFormEx.ShowTeletype(const Msg: string; Severity: TTeletypeSeverity);
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

//  if Severity = tsError then
  FErrors.Add(Msg);
  errorLog.Perform(WM_KEYDOWN, VK_DOWN, 0);
end;

procedure TImportProgressFormEx.TimerTimer(Sender: TObject);
begin
  Close;
end;

end.

