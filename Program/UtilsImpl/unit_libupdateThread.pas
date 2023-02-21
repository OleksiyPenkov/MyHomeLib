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
  IdHTTP,
  IdSocks,
  IdSSLOpenSSL,
  IdComponent,
  unit_UserData;

type
  TDownloadProgressEvent = procedure (Current, Total: Integer) of object;
  TDownloadSetCommentEvent = procedure (const Current, Total: string) of object;

  TLibUpdateThread = class(TImportInpxThreadBase)
  private
    FidHTTP: TidHTTP;
    FidSocksInfo: TIdSocksInfo;
    FidSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    FDownloadSize: Integer;
    FStartDate : TDateTime;
    FUpdated: Boolean;

  protected
    procedure Initialize; override;
    procedure Uninitialize; override;
    procedure WorkFunction; override;
    procedure HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: int64);
    procedure HTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure HTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: int64);

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
  unit_Logger;

resourcestring
  rstrDownloadProgress = 'Загружено: %u%% из %u байт';
  rstrCheckingUpdate = 'Проверяем наличие обновлений основной базы ...';
  rstrCheckingExtraUpdate = 'Проверяем наличие обновлений для on-line ...';
  rstrErrorCheckingUpdate = 'ОШИБКА. Не удалось проверить обновление.';
  rstrErrorDownloadUpdate = 'ОШИБКА. Не удалось скачать обновление.';
  rstrReady = 'Готово';
  rstrDownloadingUpdates = 'Загрузка обновлений ...';
  rstrYouHaveLatestListsVersion = 'У вас самая свежая версия списков.';
  rstrUpdatingFromLocalArchive = 'Обновление из локального архива';
  rstrListsUpdateIsAvailable = 'Доступно обновление списков до версии %d';
  rstrListsExtraUpdateIsAvailable = 'Доступно обновление on-line списков до версии %d';
  rstrNothingToUpdate = 'Нечего обновлять!';
  rstrUpdateComplete = 'Обновление завершено.';
  rstrUpdateFailed = 'Обновление не удалось.';
  rstrBackupUserData = 'Сохранение резервной копии пользовательских данных ...';
  rstrRestoreUserData = 'Восстановление пользовательских данных ...';
  rstrRemovingOldCollection = 'Удаление всех записей старой коллекции "%s" ...';
  rstrCreatingCollection = 'Создание новой коллекции  "%s"...';
  rstrSpeed = 'Загрузка: %s Kb/s';
  rstrConnectingToServer = 'Подключение к серверу ...';
  rstrOnlineCollectionUpdate = 'Обновление коллекции "%s" до версии %d:';
  rstrLocalCollectionUpdate = 'Обновление коллекции "%s":';
  rstrUpdateFailedDownload = 'Загрузка обновлений не удалась.';
  rstrCancelledByUser = 'Операция отменена пользователем.';
  rstrImportIntoCollection = 'Импорт данных в коллекцию:';

{ TLibUpdateThread }

constructor TLibUpdateThread.Create;
begin
  inherited Create(MHL_INVALID_ID);
  //
  // Сейчас считается, что обновления могут быть только для коллекций, содержащих fb2 жанры
  //
  FGenresType := gtFb2;
end;

procedure TLibUpdateThread.HTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
var
  ElapsedTime : Cardinal;
  Speed: string;
begin

  if Canceled then
  begin
    FidHTTP.Disconnect;
    Exit;
  end;

  if FDownloadSize <> 0 then
    SetProgress(AWorkCount * 100 div FDownloadSize);

  ElapsedTime := SecondsBetween(Now,FStartDate);
  if ElapsedTime>0 then
  begin
    Speed := FormatFloat('0.00',AWorkCount/1024/ElapsedTime);
    SetComment(Format(rstrSpeed,[Speed]));
  end;
end;

procedure TLibUpdateThread.HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  SetComment(rstrConnectingToServer);
  FDownloadSize := AWorkCountMax;
  FStartDate := Now;
  SetProgress(0);
end;

procedure TLibUpdateThread.HTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  SetProgress(100);
  SetComment(rstrReady);
end;

procedure TLibUpdateThread.Initialize;
begin
  inherited Initialize;

  FidHTTP := TidHTTP.Create(nil);
  FidSocksInfo := TIdSocksInfo.Create;
  FidSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;

  FidHTTP.OnWork := HTTPWork;
  FidHTTP.OnWorkBegin := HTTPWorkBegin;
  FidHTTP.OnWorkEnd := HTTPWorkEnd;
  FidHTTP.HandleRedirects := True;
  SetProxySettingsUpdate(FidHTTP, FidSocksInfo, FidSSLIOHandlerSocketOpenSSL);
end;

procedure TLibUpdateThread.Uninitialize;
begin
  FreeAndNil(FidSSLIOHandlerSocketOpenSSL);
  FreeAndNil(FidSocksInfo);
  FreeAndNil(FidHTTP);

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
        if not Settings.Updates.DownloadUpdate(i, FidHTTP) then
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
