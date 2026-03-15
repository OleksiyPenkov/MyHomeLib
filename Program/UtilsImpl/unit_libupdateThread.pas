(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Authors Oleksiy Penkov   oleksiy.penkov@gmail.com
  *         Nick Rymanov     nrymanov@gmail.com
  * Created                  20.08.2008
  * Description
  *
  * $Id: unit_libupdateThread.pas 1169 2014-06-17 07:31:08Z koreec $
  *
  * History
  *
  ****************************************************************************** *)

unit unit_libupdateThread;

interface

uses
  Windows,
  Classes,
  SysUtils,
  unit_ImportInpxThread,
  System.Net.HttpClient,
  unit_UserData;

type
  TDownloadProgressEvent = procedure (Current, Total: Integer) of object;
  TDownloadSetCommentEvent = procedure (const Current, Total: string) of object;

  TLibUpdateThread = class(TImportInpxThreadBase)
  private
    FHTTPClient: THTTPClient;
    FStartDate: TDateTime;
    FUpdated: Boolean;

  protected
    procedure Initialize; override;
    procedure Uninitialize; override;
    procedure WorkFunction; override;
    procedure HTTPReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var AAbort: Boolean);

  public
    constructor Create;
    property Updated: Boolean read FUpdated;
  end;

implementation

uses
  IOUtils,
  DateUtils,
  unit_Globals,
  unit_Consts,
  unit_Settings,
  dm_user,
  unit_WorkerThread,
  unit_Lib_Updates,
  unit_Interfaces,
  unit_Logger,
  unit_MHLHttpClient;

resourcestring
rstrDownloadProgress = 'Завантажено: %u%% із %u байт';
   rstrCheckingUpdate = 'Перевіряємо наявність оновлень основної бази...';
   rstrCheckingExtraUpdate = 'Перевіряємо наявність оновлень для on-line...';
   rstrErrorCheckingUpdate = 'ПОМИЛКА. Не вдалося перевірити оновлення.';
   rstrErrorDownloadUpdate = 'ПОМИЛКА. Не вдалося завантажити оновлення.';
   rstrReady = 'Готово';
   rstrDownloadingUpdates = 'Завантаження оновлень...';
   rstrYouHaveLatestListsVersion = 'У вас найсвіжіша версія списків.';
   rstrUpdatingFromLocalArchive = 'Оновлення з локального архіву';
   rstrListsUpdateIsAvailable = 'Доступно оновлення списків до версії %d';
   rstrListsExtraUpdateIsAvailable = 'Доступне оновлення списків on-line до версії %d';
   rstrNothingToUpdate = 'Нема чого оновлювати!';
   rstrUpdateComplete = 'Оновлення завершено.';
   rstrUpdateFailed = 'Оновлення не вдалося.';
   rstrBackupUserData = 'Збереження резервної копії даних користувача';
   rstrRestoreUserData = 'Відновлення даних користувача';
   rstrRemovingOldCollection = 'Видалення всіх записів старої колекції "%s" ...';
   rstrCreatingCollection = 'Створення нової колекції %s...';
   rstrSpeed = 'Завантаження: %s Kb/s';
   rstrConnectingToServer = 'Підключення до сервера...';
   rstrOnlineCollectionUpdate = 'Оновлення колекції %s до версії %d:';
   rstrLocalCollectionUpdate = 'Оновлення колекції %s:';
   rstrUpdateFailedDownload = 'Завантаження оновлень не вдалося.';
   rstrCancelledByUser = 'Операцію скасовано користувачем.';
   rstrImportIntoCollection = 'Імпорт даних до колекції:';

{ TLibUpdateThread }

constructor TLibUpdateThread.Create;
begin
  inherited Create(MHL_INVALID_ID);
  //
  // Сейчас считается, что обновления могут быть только для коллекций, содержащих fb2 жанры
  //
  FGenresType := gtFb2;
end;

procedure TLibUpdateThread.HTTPReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var AAbort: Boolean);
var
  ElapsedTime: Cardinal;
  Speed: string;
begin
  if Canceled then
  begin
    AAbort := True;
    Exit;
  end;

  if AContentLength > 0 then
    SetProgress(AReadCount * 100 div AContentLength);

  ElapsedTime := SecondsBetween(Now, FStartDate);
  if ElapsedTime > 0 then
  begin
    Speed := FormatFloat('0.00', AReadCount / 1024 / ElapsedTime);
    SetComment(Format(rstrSpeed, [Speed]));
  end;
end;

procedure TLibUpdateThread.Initialize;
begin
  inherited Initialize;
  FHTTPClient := CreateHTTPClientUpdate;
  FHTTPClient.OnReceiveData := HTTPReceiveData;
end;

procedure TLibUpdateThread.Uninitialize;
begin
  FreeAndNil(FHTTPClient);
  inherited Uninitialize;
end;

procedure TLibUpdateThread.WorkFunction;
var
  i: integer;
  InpxFileName: string;
  updateInfo: TUpdateInfo;
  Collection: IBookCollection;
  UserDataBackup: TUserData;
  S: string;
begin
  SetComment(rstrCheckingUpdate);

  try
    for i := 0 to Settings.Updates.Count - 1 do
    begin
      updateInfo := Settings.Updates[i];

      if not updateInfo.Available then
        Continue;

      if updateInfo.ExternalVersion > 0 then
         Teletype(Format(rstrOnlineCollectionUpdate, [updateInfo.Name, updateInfo.ExternalVersion]), tsInfo)
      else
         Teletype(Format(rstrLocalCollectionUpdate, [updateInfo.Name]), tsInfo);


      if updateInfo.Local then
        Teletype(rstrUpdatingFromLocalArchive, tsInfo)
      else
      begin
        Teletype(rstrDownloadingUpdates, tsInfo);
        SetComment(rstrConnectingToServer);
        FStartDate := Now;
        SetProgress(0);
        if not Settings.Updates.DownloadUpdate(i, FHTTPClient) then
        begin
          Teletype(rstrUpdateFailedDownload, tsInfo);
          Continue;
        end;
      end;

      if Canceled then
      begin
        DeleteFile(TPath.Combine(Settings.WorkPath, Settings.Updates.Items[i].UpdateFile));
        Teletype(rstrCancelledByUser, tsInfo);
        Exit;
      end;

      InpxFileName := TPath.Combine(Settings.UpdatePath, updateInfo.UpdateFile);

      //Truncate won't work with TBookCollection.Create(DBFileName, False)
      Collection := FSystemData.GetCollection(updateInfo.CollectionID);
      Collection.BeginBulkOperation;
      try
        UserDataBackup := TUserData.Create;
        try
          if updateInfo.Full then
          begin
            // Backup user data:
            Teletype(Format(rstrBackupUserData, [updateInfo.Name]), tsInfo);
            Collection.ExportUserData(UserDataBackup);

            // clear most tables in a collection
            Teletype(Format(rstrRemovingOldCollection, [updateInfo.Name]), tsInfo);
            Collection.TruncateTablesBeforeImport;

            // Remove stale favorites entries for this collection from the system DB
            // (old BookIDs won't match after re-import)
            FSystemData.CleanCollectionBooks(updateInfo.CollectionID);
          end; //if FULL

          //  импортирум данные
          Teletype(rstrImportIntoCollection, tsInfo);
          Import(InpxFileName, not updateInfo.Full, Collection);

          if updateInfo.Full then // a full import mode, had a backup before the process
          begin
            Assert(Assigned(UserDataBackup));
            // Restore user data:
            Teletype(Format(rstrRestoreUserData, [updateInfo.Name]),tsInfo);
            Collection.ImportUserData(UserDataBackup, nil);
          end;
        finally
          FreeAndNil(UserDataBackup);
        end;

        Collection.EndBulkOperation(True);
      except
        Collection.EndBulkOperation(False);
        raise;
      end;

      Teletype(rstrReady, tsInfo);
    end; //for .. with

    Teletype(rstrUpdateComplete, tsInfo);
    for i := 0 to Settings.Updates.Count - 1 do
    begin
      updateInfo := Settings.Updates[i];
      if FileExists(Settings.UpdatePath + updateInfo.UpdateFile) then
         DeleteFile(Settings.UpdatePath + updateInfo.UpdateFile);
    end;

    SetComment(rstrReady);
  except
    on E: Exception do
    begin
      Teletype(rstrUpdateFailed, tsError);
{$IFDEF USELOGGER}
      GetLogger.Log('TLibUpdateThread.WorkFunction ERROR', E.Message);
{$ENDIF}
      //
      // TODO -cBug: вообще говоря, значение i здесь неопределено
      //
      DeleteFile(Settings.WorkPath + Settings.Updates.Items[i].UpdateFile);
    end;
  end;
end;

end.
