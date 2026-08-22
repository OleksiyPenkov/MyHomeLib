(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov (aka Koreec)
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

function ManualCollectionUpdate(const CollectionID: Integer; const LogFileName: string): Boolean;

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
  unit_MetabibReader,
  frm_info_popup,
  frm_search,
  frm_main,
  frm_UpdateFromFile,
  unit_Globals,
  unit_Interfaces,
  unit_Settings,
  unit_Consts,
  dm_user;

resourcestring
  rstrUpdateCollections = 'Оновлення колекцій';
  rstrUpdateFromFile = 'Оновлення колекції з файлу';

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

function ManualCollectionUpdate(const CollectionID: Integer; const LogFileName: string): Boolean;
var
  FileName: string;
  Full: Boolean;
  GenresType: TGenresType;
  CollectionInfo: TCollectionInfo;
  worker: TManualUpdateThread;
  mbWorker: TMetabibManualUpdateThread;
  ProgressForm: TImportProgressFormEx;
begin
  Result := False;

  if not AskUpdateFile(FileName, Full) then
    Exit;

  CollectionInfo := DMUser.GetSystemDBConnection.GetCollectionInfo(CollectionID);

  //
  // Той самий розподіл, що й у майстрі створення колекції: локальна не-FB2
  // колекція (CT_EXTERNAL_LOCAL_NONFB) все одно користується жанрами fb2.
  //
  case CollectionInfo.CollectionType of
    CT_PRIVATE_NONFB, CT_EXTERNAL_ONLINE_NONFB:
      GenresType := gtAny;
  else
    GenresType := gtFb2;
  end;

  if TMetabibReader.IsDatasetFile(FileName) then
  begin
    // Каталог metabib - завжди повний зріз: прапорець Full не має сенсу
    mbWorker := TMetabibManualUpdateThread.Create(CollectionID, FileName, GenresType);
    try
      mbWorker.DisplayName := CollectionInfo.DisplayName;

      ProgressForm := TImportProgressFormEx.Create(Application);
      ProgressForm.Caption := rstrUpdateFromFile;
      try
        ProgressForm.btnSaveLog.Visible := True;
        ProgressForm.WorkerThread := mbWorker;
        ProgressForm.ShowModal;
        ProgressForm.SaveErrorLog(LogFileName);
      finally
        ProgressForm.Free;
      end;
    finally
      mbWorker.Free;
    end;
    Exit(True);
  end;

  worker := TManualUpdateThread.Create(CollectionID, FileName, Full, GenresType);
  try
    worker.DisplayName := CollectionInfo.DisplayName;

    ProgressForm := TImportProgressFormEx.Create(Application);
    ProgressForm.Caption := rstrUpdateFromFile;
    try
      ProgressForm.btnSaveLog.Visible := True;
      ProgressForm.WorkerThread := worker;
      ProgressForm.ShowModal;
      ProgressForm.SaveErrorLog(LogFileName);
    finally
      ProgressForm.Free;
    end;
  finally
    worker.Free;
  end;

  Result := True;
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
