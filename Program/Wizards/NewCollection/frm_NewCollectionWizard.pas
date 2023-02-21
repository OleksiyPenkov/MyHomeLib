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
  * $Id: frm_NewCollectionWizard.pas 1104 2012-01-27 04:43:24Z koreec $
  *
  * History
  * NickR 03.09.2010    Импорт из XML больше не поддерживается. Удалил соответствующую страницу визарда.
  *
  ****************************************************************************** *)

unit frm_NewCollectionWizard;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  unit_WorkerThread,
  unit_NCWParams,
  frame_WizardPageBase,
  frame_NCWWelcom,
  frame_NCWOperation,
  frame_NCWInpxSource,
  frame_NCWDownload,
  frame_NCWCollectionNameAndLocation,
  frame_NCWCollectionFileTypes,
  frame_NCWSelectGenreFile,
  frame_NCWProgress,
  frame_NCWFinish,
  frm_MHLWizardBase;

type
  TNewCollectionWizard = class(TMHLWizardBase)
  private const
    WELCOM_PAGE_ID = 0;
    OPERATION_PAGE_ID = 1;
    INPXSOURCE_PAGE_ID = 2;
    DOWNLOAD_PAGE_ID = 3;
    NAMEANDLOCATION_PAGE_ID = 4;
    FILETYPES_PAGE_ID = 5;
    GENREFILE_PAGE_ID = 6;
    PROGRESS_PAGE_ID = 7;
    FINISH_PAGE_ID = 8;

  private
    FWelcomPage: TframeNCWWelcom;
    FCollectionTypePage: TframeNCWOperation;
    FInpxSourcePage: TframeNCWInpxSource;
    FDownloadPage: TframeNCWDownload;
    FNameAndLocationPage: TframeNCWNameAndLocation;
    FFileTypesPage: TframeNCWCollectionFileTypes;
    FSelectGenreFilePage: TframeNCWSelectGenreFile;
    FProgressPage: TframeNCWProgress;
    FFinishPage: TframeNCWFinish;

    FParams: TNCWParams;
    FWorker: TWorker;

    FAutoImport: boolean;

    procedure CorrectParams;
    function CreateCollection: Boolean;
    function StartImportData: Boolean;

    procedure CloseWorker;
    procedure CancelWorker;

    function ShowMessage(const Text: string; Flags: Longint = MB_OK): Integer;

  protected
    procedure PMWorkerDone(var Message: TMessage); message PM_WORKERDONE;

    procedure InitWizard; override;
    function IsPageVisible(PageIndex: Integer): Boolean; override;
    procedure AfterShowPage; override;
    function CanCloseWizard: Boolean; override;
    procedure CancelWizard; override;

  public
    destructor Destroy; override;

    function NewCollectionID: Integer; inline;
    property AutoImport:boolean  read FAutoImport;
  end;

var
  NewCollectionWizard: TNewCollectionWizard;

implementation

uses
  Math,
  unit_MHL_strings,
  unit_Consts,
  unit_Globals,
  unit_Settings,
  dm_user,
  unit_Interfaces,
  unit_ImportInpxThread;

{$R *.dfm}

resourcestring
  rstrCreationCollection = 'Создание коллекции';
  rstrDataImport = 'Импорт данныx';
  rstrDataImporting = 'Импортируем данные';
  rstrRegistration = 'Регистрируем коллекцию';
  rstrDownloadFailed = 'Закачка не удалась. Сервер сообщает об ошибке.';
  rstrImportDoneWithErrors = 'Импорт закончен с ошибками. Продолжить регистрацию коллекции ?';

destructor TNewCollectionWizard.Destroy;
begin
  CloseWorker;
  inherited;
end;

function TNewCollectionWizard.NewCollectionID: Integer;
begin
  Result := FParams.CollectionID;
end;

procedure TNewCollectionWizard.InitWizard;
var
  frame: TWizardPageBase;
begin
  //
  // Проинициализируем параметры по умолчанию
  //
  FParams.Operation := otNew;
  FParams.CollectionType := ltUser;
  FParams.FileTypes := ftFB2;
  FParams.DefaultGenres := True;

  FWelcomPage := AddPage(TframeNCWWelcom) as TframeNCWWelcom;
  FCollectionTypePage := AddPage(TframeNCWOperation) as TframeNCWOperation;
  FInpxSourcePage := AddPage(TframeNCWInpxSource) as TframeNCWInpxSource;
  FDownloadPage := AddPage(TframeNCWDownload) as TframeNCWDownload;
  FNameAndLocationPage := AddPage(TframeNCWNameAndLocation) as TframeNCWNameAndLocation;
  FFileTypesPage := AddPage(TframeNCWCollectionFileTypes) as TframeNCWCollectionFileTypes;
  FSelectGenreFilePage := AddPage(TframeNCWSelectGenreFile) as TframeNCWSelectGenreFile;
  FProgressPage := AddPage(TframeNCWProgress) as TframeNCWProgress;
  FFinishPage := AddPage(TframeNCWFinish) as TframeNCWFinish;

  for frame in FPages do
    frame.Initialize(@FParams);

  { TODO -oAlex -cRefactoring : Костыль! может быть его пристроить в другое место? }
  FFinishPage.lblPageHint.Caption := '';
end;

function TNewCollectionWizard.IsPageVisible(PageIndex: Integer): Boolean;
begin
  case PageIndex of
    WELCOM_PAGE_ID:
      Result := True;

    OPERATION_PAGE_ID:
      Result := True;

    INPXSOURCE_PAGE_ID:
      Result := (FParams.Operation = otInpx);

    DOWNLOAD_PAGE_ID:
      Result := (FParams.Operation = otInpxDownload);

    NAMEANDLOCATION_PAGE_ID:
      Result := True;

    FILETYPES_PAGE_ID:
      Result := (FParams.Operation = otNew);

    GENREFILE_PAGE_ID:
      Result := (FParams.Operation = otNew) and (FParams.FileTypes = ftAny);

    PROGRESS_PAGE_ID:
      Result := True;

    FINISH_PAGE_ID:
      Result := True;
  else
    Assert(False);
    Result := True;
  end;
end;

procedure TNewCollectionWizard.AfterShowPage;
begin
  Assert(IsValidPageIndex(FCurrentPage));

  if DOWNLOAD_PAGE_ID = FCurrentPage then
  begin
    AdjustButtons([wbCancel], [wbCancel]);
    try
      if FDownloadPage.Download then
        DoChangePage(btnForward);
    except
      on E: Exception do
      begin
        MessageDlg(rstrDownloadFailed, mtError, [mbOK], 0);
        DoChangePage(btnBackward);
      end;
    end;
  end
  else if PROGRESS_PAGE_ID = FCurrentPage then
  begin
    CorrectParams;

    if not CreateCollection then
    begin
      //
      // мы не смогли создать/зарегистрировать коллекцию,
      // CancelToClose и никакого продолжения
      //
      FProgressPage.ShowSaveLogPanel(True);
      AdjustButtons([wbFinish], [wbFinish]);
      Exit;
    end;

    FModalResult := mrOk;

    if not StartImportData then
    begin
      //
      // ничего ждать не нужно, нечего импортировать
      // можно переходить на следующую страницу
      //
      DoChangePage(btnForward);
    end;
  end;
end;

function TNewCollectionWizard.CanCloseWizard: Boolean;
begin
  //
  // необходимо останавливать закачку INPX если она активна
  //
  if Assigned(FWorker) and not FWorker.Finished then
  begin
    //
    // Запущен рабочий поток -> остановим его.
    //
    CancelWorker;
    Result := False;
    Exit;
  end;

  Result := inherited CanCloseWizard;
end;

procedure TNewCollectionWizard.CancelWizard;
begin
  if DOWNLOAD_PAGE_ID = FCurrentPage then
  begin
    FDownloadPage.Stop;
  end;

  if Assigned(FWorker) then
  begin
    //
    // Запущен рабочий поток -> остановим его.
    //
    CancelWorker;
    Exit;
  end;

  inherited CancelWizard;
end;

procedure TNewCollectionWizard.CorrectParams;
begin
  //
  // определим реальный код коллекции
  //
  if FParams.CollectionCode = 0 then
  begin
    case FParams.CollectionType of
      ltUser:              FParams.CollectionCode := IfThen(FParams.FileTypes = ftFB2, CT_PRIVATE_FB, CT_PRIVATE_NONFB);
      ltUserFB:            FParams.CollectionCode := CT_PRIVATE_FB;
      ltUserAny:           FParams.CollectionCode := CT_PRIVATE_NONFB;
      ltExternalLocalFB:   FParams.CollectionCode := CT_EXTERNAL_LOCAL_FB;
      ltExternalOnlineFB:  FParams.CollectionCode := CT_EXTERNAL_ONLINE_FB;
      ltExternalLocalAny:  FParams.CollectionCode := CT_EXTERNAL_LOCAL_NONFB;
      ltExternalOnlineAny: FParams.CollectionCode := CT_EXTERNAL_ONLINE_NONFB;
    end;
  end;

  //
  // для специальных коллекций установим некоторые параметры по умолчанию
  //
  case FParams.CollectionType of
    ltUser: ; // ничего не трогаем, все должен задать пользователь

    ltUserFB, ltExternalLocalFB, ltExternalOnlineFB:
    begin
      FParams.DefaultGenres := True;
      FParams.FileTypes := ftFB2;
      FParams.GenreFile := Settings.SystemFileName[sfGenresFB2]
    end;

    ltUserAny, ltExternalOnlineAny:
    begin
      FParams.FileTypes := ftAny;
      FParams.GenreFile := Settings.SystemFileName[sfGenresNonFB2];
    end;

    ltExternalLocalAny:
    begin
      FParams.GenreFile := Settings.SystemFileName[sfGenresFB2];
      FParams.FileTypes := ftAny;
    end;
  end;

  //
  // заполним файл жанров
  //
  if not FParams.DefaultGenres then
    //
    // относительно текущего каталога
    //
    FParams.GenreFile := ExpandFileName(FParams.GenreFile)
  else if FParams.GenreFile = '' then
  begin
    if FParams.FileTypes = ftFB2 then
      FParams.GenreFile := Settings.SystemFileName[sfGenresFB2]
    else
      FParams.GenreFile := Settings.SystemFileName[sfGenresNonFB2];
  end;

  Assert(FileExists(FParams.GenreFile));
end;

function TNewCollectionWizard.CreateCollection: Boolean;
begin
  Assert(Assigned(FProgressPage));

  Result := False;

  FProgressPage.OpenProgress;
  FProgressPage.SetComment(rstrCreationCollection);

  try
    if FParams.Operation = otExisting then
    begin
      //
      // Подключаем коллекцию
      //
      FParams.CollectionID := SystemDB.RegisterCollection(
        FParams.CollectionFile,
        FParams.DisplayName,
        FParams.CollectionRoot
      );
    end
    else // if FParams.Operation <> otExisting then
    begin
      //
      // Создаем коллекцию
      //
      FProgressPage.ShowTeletype(rstrCreationCollection, tsInfo);
      { TODO -oNickR -cUsability : проверять существование на соответствующей странице с выдачей предупреждения }
      //Assert(not FileExists(FParams.CollectionFile));
      Assert(FileExists(FParams.GenreFile));
      FParams.CollectionID := SystemDB.CreateCollection(
        FParams.DisplayName,
        FParams.CollectionRoot,
        FParams.CollectionFile,
        FParams.CollectionCode,
        FParams.GenreFile
      );
    end;

    FProgressPage.ShowProgress(100);

    FAutoImport := FParams.AutoImport;

    Result := True;
  except
    on e: Exception do
      FProgressPage.ShowTeletype(e.Message, tsError);
  end;
end;

function TNewCollectionWizard.StartImportData: Boolean;
var
  GenresType: TGenresType;
begin
  Assert(Assigned(FProgressPage));

  if FParams.Operation in [otNew, otExisting] then
  begin
    Result := False;
    Exit;
  end;

  Assert(FParams.CollectionType <> ltUser);
  Assert(FParams.INPXFile <> '');

  Assert(not Assigned(FWorker));
  FWorker := nil;

  case FParams.CollectionType of
    ltUserFB, ltExternalLocalFB, ltExternalOnlineFB, ltExternalLocalAny:
      GenresType := gtFb2;

    ltUserAny, ltExternalOnlineAny:
      GenresType := gtAny;

    else
      Assert(False);
  end;
  FWorker := TImportInpxThread.Create(FParams.CollectionID, FParams.INPXFile, GenresType);

  FProgressPage.SetComment(rstrDataImport);
  FProgressPage.ShowTeletype(rstrDataImporting, tsInfo);

  //
  // подключить и запустить импортер
  //
  FWorker.OnOpenProgress := FProgressPage.OpenProgress;
  FWorker.OnProgress := FProgressPage.ShowProgress;
  FWorker.OnCloseProgress := FProgressPage.CloseProgress;
  FWorker.OnTeletype := FProgressPage.ShowTeletype;
  FWorker.OnSetComment := FProgressPage.SetComment;
  FWorker.OnShowMessage := ShowMessage;

  FWorker.Start;

  Result := True;
end;

function TNewCollectionWizard.ShowMessage(const Text: string; Flags: Integer): Integer;
begin
  Result := Application.MessageBox(PChar(Text), PChar(Application.Title), Flags);
end;

procedure TNewCollectionWizard.CancelWorker;
begin
  if Assigned(FWorker) then
  begin
    if FWorker.Finished then
      Exit;

    if not FWorker.Canceled then
      if ShowMessage(rstrCancelOperationWarningMsg, MB_OKCANCEL or MB_ICONEXCLAMATION) = IDCANCEL then
        Exit;

    FWorker.Cancel;
    AdjustButtons([], []);
  end;
end;

procedure TNewCollectionWizard.CloseWorker;
begin
  if Assigned(FWorker) then
  begin
    FWorker.WaitFor;
    FreeAndNil(FWorker);
  end;
end;

//
// Рабочий поток завершил свою работу
//
procedure TNewCollectionWizard.PMWorkerDone(var Message: TMessage);
var
  stayOnCurrentPage: Boolean;
  IgnoreErrors : Boolean;
begin
  //
  // Если во время работы небыло ошибок и поток не был остановлен пользователем
  //
  IgnoreErrors := True;
  if FProgressPage.HasErrors then
    IgnoreErrors := (MessageDlg(rstrImportDoneWithErrors, mtWarning, [mbYes,mbNo], 0) = mrYes);

  stayOnCurrentPage := (not IgnoreErrors) or FWorker.Canceled;

  //
  // Закрыть и уничтожить рабочий поток
  //
  CloseWorker;

  if stayOnCurrentPage then
  begin
    //
    // TODO: пользователь отказался от продолжения, надо уничтожить _созданную_ коллекцию
    //
    SystemDB.DeleteCollection(FParams.CollectionID);

    if FProgressPage.HasErrors then
    begin
      FProgressPage.ShowSaveLogPanel(True);
      AdjustButtons([wbFinish], [wbFinish]);
    end
    else
    begin
      //
      // Рабочий поток был остановлен пользователем, ошибок нет -> закрываем форму
      //
      ModalResult := FModalResult;
    end;
  end
  else
  begin
    //
    // все в порядке -> переходим на следующую страницу
    //
    ///RegisterCollection;
    DoChangePage(btnForward);
  end;
end;

end.
