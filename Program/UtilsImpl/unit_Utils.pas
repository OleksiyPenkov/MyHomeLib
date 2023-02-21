(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov (nrymanov@gmail.com)
  * Created             20.08.2008
  * Description
  *
  * $Id: unit_Utils.pas 1167 2014-06-16 02:07:14Z koreec $
  *
  * History
  *
  ****************************************************************************** *)

unit unit_Utils;

interface

uses
  Windows,
  Dialogs,
  unit_UserData;

procedure SyncOnLineFiles(const CollectionID: Integer);

procedure SyncFolders(const CollectionID: Integer);

function LibrusecUpdate(const LogFileName: string): Boolean;

procedure ShowPopup(const Msg: string);
procedure HidePopup;

procedure LocateBook;

implementation

uses
  Forms,
  unit_SyncOnLineThread,
  frm_SyncOnLineProgressForm,
  unit_SyncFoldersThread,
  frm_ImportProgressFormEx,
  unit_libupdateThread,
  frm_info_popup,
  frm_search,
  frm_main,
  unit_Interfaces,
  unit_Settings;

resourcestring
  rstrUpdateCollections = 'Обновление коллекций';

procedure SyncOnLineFiles(const CollectionID: Integer);
var
  worker: TSyncOnLineThread;
  frmProgress: TSyncOnLineProgressForm;
begin
  worker := TSyncOnLineThread.Create(CollectionID);
  try
    frmProgress := TSyncOnLineProgressForm.Create(Application);
    try
      frmProgress.WorkerThread := worker;
      frmProgress.ShowModal;
    finally
      frmProgress.Free;
    end;
  finally
    worker.Free;
  end;
end;

procedure SyncFolders(const CollectionID: Integer);
var
  worker: TSyncFoldersThread;
  frmProgress: TSyncOnLineProgressForm;
begin
  worker := TSyncFoldersThread.Create(CollectionID);
  try
    frmProgress := TSyncOnLineProgressForm.Create(Application);
    try
      frmProgress.WorkerThread := worker;
      frmProgress.ShowModal;
    finally
      frmProgress.Free;
    end;
  finally
    worker.Free;
  end;
end;

function LibrusecUpdate(const LogFileName: string): Boolean;
var
  worker : TLibUpdateThread;
  ProgressForm : TImportProgressFormEx;
begin
  worker := TLibUpdateThread.Create;
  try
    ProgressForm := TImportProgressFormEx.Create(Application);
    ProgressForm.Caption := rstrUpdateCollections;
    ProgressForm.CloseOnTimer := True;
    try
      ProgressForm.WorkerThread := worker;
      ProgressForm.ShowModal;
      ProgressForm.SaveErrorLog(LogFileName);
      Result := worker.Updated;
    finally
      ProgressForm.Free;
    end;
  finally
    worker.Free;
  end;
end;

procedure LocateBook;
var
  SearchForm: TfrmBookSearch;
begin
  SearchForm := TfrmBookSearch.Create(Application);
  SearchForm.OnLocateBook := frmMain.LocateBook;
  try
    SearchForm.ShowModal;
  finally
    SearchForm.Free;
  end;
end;

procedure ShowPopup(const Msg: string);
begin
  frmInfoPopup := TfrmInfoPopup.Create(nil);
  frmInfoPopup.lblText.Caption := Msg;
  frmInfoPopup.Refresh;
  frmInfoPopup.Show;
end;

procedure HidePopup;
begin
  if Assigned(frmInfoPopup) then
  begin
    frmInfoPopup.Hide;
    frmInfoPopup.Free;
  end;
end;

end.
