(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov (aka Koreec)
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
  unit_Globals;

type
  TDownloadProgressEvent = procedure (Current, Total: Integer) of object;
  TDownloadSetCommentEvent = procedure (const Current, Total: string) of object;

  TCollectionUpdateThreadBase = class(TImportInpxThreadBase)
  protected
    //
    // Повертає False, якщо користувач скасував операцію: зміни відкочено,
    // колекція лишилась такою, якою була.
    //
    function UpdateCollection(const AFileName: string; ACollectionID: Integer;
      AFull: Boolean; const ADisplayName: string): Boolean;
  end;

  TLibUpdateThread = class(TCollectionUpdateThreadBase)
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

  TManualUpdateThread = class(TCollectionUpdateThreadBase)
  private
    FFileName: string;
    FFull: Boolean;
    FDisplayName: string;
    function IsValidUpdateArchive: Boolean;

  protected
    procedure WorkFunction; override;

  public
    constructor Create(const ACollectionID: Integer; const AFileName: string;
      AFull: Boolean; AGenresType: TGenresType);
    property DisplayName: string read FDisplayName write FDisplayName;
  end;

implementation

uses
  IOUtils,
  DateUtils,
  unit_Consts,
  unit_Settings,
  dm_user,
  unit_WorkerThread,
  unit_Lib_Updates,
  unit_Interfaces,
  unit_Logger,
  unit_MHLHttpClient,
  unit_MHLArchiveHelpers,
  unit_UserData;

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
   rstrManualCollectionUpdate = 'Оновлення колекції %s з файлу %s:';
   rstrUpdateFileNotFound = 'Файл оновлення не знайдено: %s';
   rstrInvalidUpdateFile = 'Неправильний формат файлу INPX: %s';

{ TCollectionUpdateThreadBase }

//
// Оновлення однієї колекції з одного файлу списків.
// Файл AFileName не видаляється — про нього дбає викликач.
//
function TCollectionUpdateThreadBase.UpdateCollection(const AFileName: string;
  ACollectionID: Integer; AFull: Boolean; const ADisplayName: string): Boolean;
var
  Collection: IBookCollection;
  UserDataBackup: TUserData;
begin
  Result := False;

  //Truncate won't work with TBookCollection.Create(DBFileName, False)
  Collection := FSystemData.GetCollection(ACollectionID);
  Collection.BeginBulkOperation;
  try
    UserDataBackup := TUserData.Create;
    try
      if AFull then
      begin
        // Backup user data:
        Teletype(Format(rstrBackupUserData, [ADisplayName]), tsInfo);
        Collection.ExportUserData(UserDataBackup);

        // clear most tables in a collection
        Teletype(Format(rstrRemovingOldCollection, [ADisplayName]), tsInfo);
        Collection.TruncateTablesBeforeImport;
      end;

      Teletype(rstrImportIntoCollection, tsInfo);
      Import(AFileName, not AFull, Collection);

      //
      // Import лише перериває свої цикли за Canceled і повертає керування
      // штатно. Без цієї перевірки скасований повний переімпорт закомітив би
      // обрізану колекцію, а RemapCollectionBookIDs ще й вичистив би групи.
      //
      if Canceled then
      begin
        Collection.EndBulkOperation(False);
        Teletype(rstrCancelledByUser, tsInfo);
        Exit;
      end;

      if AFull then
      begin
        // Restore user data:
        Teletype(Format(rstrRestoreUserData, [ADisplayName]), tsInfo);
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

  //
  // При полном переимпорте BookID в коллекции переприсваиваются, и сохранённые
  // в группах BookID начинают указывать на чужие книги. Приводим их к новой
  // нумерации по LibID (при полном переимпорте заодно убираем книги, которых
  // в коллекции больше нет).
  // Делается только после коммита коллекции: системная БД - отдельный файл,
  // её изменения не откатятся вместе с импортом.
  //
  FSystemData.RemapCollectionBookIDs(ACollectionID, AFull);
  Result := True;
end;

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

      InpxFileName := TPath.Combine(Settings.UpdatePath, updateInfo.UpdateFile);

      if Canceled then
      begin
        DeleteFile(InpxFileName);
        Teletype(rstrCancelledByUser, tsInfo);
        Exit;
      end;

      //
      // Скасування під час імпорту: зміни вже відкочено, файли оновлень
      // лишаємо на місці, щоб можна було повторити спробу.
      //
      if not UpdateCollection(InpxFileName, updateInfo.CollectionID, updateInfo.Full, updateInfo.Name) then
        Exit;

      Teletype(rstrReady, tsInfo);
    end; //for .. with

    Teletype(rstrUpdateComplete, tsInfo);
    for i := 0 to Settings.Updates.Count - 1 do
    begin
      updateInfo := Settings.Updates[i];
      InpxFileName := TPath.Combine(Settings.UpdatePath, updateInfo.UpdateFile);
      if FileExists(InpxFileName) then
         DeleteFile(InpxFileName);
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
      // InpxFileName - файл, на якому впала обробка; до першої ітерації циклу
      // він порожній. Раніше тут використовувався лічильник i, невизначений
      // за межами циклу, та ще й з іншою текою.
      //
      if (InpxFileName <> '') and FileExists(InpxFileName) then
        DeleteFile(InpxFileName);
    end;
  end;
end;

{ TManualUpdateThread }

constructor TManualUpdateThread.Create(const ACollectionID: Integer;
  const AFileName: string; AFull: Boolean; AGenresType: TGenresType);
begin
  inherited Create(ACollectionID);
  FFileName := AFileName;
  FFull := AFull;
  FGenresType := AGenresType;
  //
  // Файл вибрав користувач, він може бути з будь-якого джерела: не дозволяємо
  // його collection.info перезаписати URL і скрипт підключення колекції.
  //
  FKeepCollectionProps := True;
end;

//
// Import не переживає файл, який не є архівом, або архів без .inp:
// його finally звільняє неініціалізовані вказівники. Перевіряємо заздалегідь.
//
function TManualUpdateThread.IsValidUpdateArchive: Boolean;
var
  Zip: TMHLZip;
begin
  Result := False;
  try
    Zip := TMHLZip.Create(FFileName, True);
    try
      Result := Zip.Find('*.inp');
    finally
      FreeAndNil(Zip);
    end;
  except
    Result := False;
  end;
end;

procedure TManualUpdateThread.WorkFunction;
begin
  if not FileExists(FFileName) then
  begin
    Teletype(Format(rstrUpdateFileNotFound, [FFileName]), tsError);
    Exit;
  end;

  if not IsValidUpdateArchive then
  begin
    Teletype(Format(rstrInvalidUpdateFile, [FFileName]), tsError);
    Exit;
  end;

  try
    Teletype(Format(rstrManualCollectionUpdate, [FDisplayName, FFileName]), tsInfo);
    if UpdateCollection(FFileName, FCollectionID, FFull, FDisplayName) then
      Teletype(rstrUpdateComplete, tsInfo);
    SetComment(rstrReady);
  except
    on E: Exception do
    begin
      Teletype(rstrUpdateFailed, tsError);
      Teletype(E.Message, tsError);
    end;
  end;
end;

end.
