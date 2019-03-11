(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2010 Aleksey Penkov
  *
  * Authors Aleksey Penkov   alex.penkov@gmail.com
  *         Nick Rymanov     nrymanov@gmail.com
  *         Matvienko Sergei matv84@mail.ru
  *
  ****************************************************************************** *)

unit unit_ExportToDeviceThread;

interface

uses
  Classes,
  unit_WorkerThread,
  unit_globals,
  Dialogs,
  unit_Templater,
  unit_Interfaces;

type
  TExportToDeviceThread = class(TWorker)
  private type
    TFileOprecord = record
      SourceFile: string;
      TargetFile: string;
    end;

  protected
    //
    // эти поля будут инициализированы только в рабочем потоке
    //
    FSystemData: ISystemData;

  private
    FAppPath: string;
    FTempPath: string;
    FFolderTemplate: string;
    FFileNameTemplate: string;
    FOverwriteFB2Info: Boolean;
    FTXTEncoding: TTXTEncoding;

    FFileOprecord: TFileOprecord;

    FBookFormat: TBookFormat;
    FBookIdList: TBookIdList;
    FTemplater: TTemplater;
    FExportMode: TExportMode;
    FExtractOnly: boolean;
    FProcessedFiles: string;
    FDeviceDir: string;

    function fb2Lrf(const InpFile: string; const OutFile: string): Boolean;
    function fb2EPUB(const InpFile: string; const OutFile: string): Boolean;
    function fb2PDF(const InpFile: string; const OutFile: string): Boolean;
    function fb2Mobi(const InpFile, OutFile: string): Boolean;

  strict private
    function PrepareFile(const BookKey: TBookKey): Boolean;
    function SendFileToDevice: Boolean;

  protected
    procedure Initialize; override;
    procedure Uninitialize; override;
    procedure WorkFunction; override;

  public
    constructor Create;

    property BookIdList: TBookIdList read FBookIdList write FBookIdList;
    property DeviceDir: string read FDeviceDir write FDeviceDir;
    property ProcessedFiles: string read FProcessedFiles;
    property ExportMode: TExportMode read FExportMode write FExportMode;
    property ExtractOnly: boolean write FExtractOnly;
  end;

implementation

uses
  Windows,
  SysUtils,
  IOUtils,
  unit_Consts,
  unit_Settings,
  dm_user,
  unit_MHLHelpers,
  unit_MHLArchiveHelpers,
  unit_WriteFb2Info;

resourcestring
  rstrCheckTemplateValidity = 'Проверьте правильность шаблона';
  rstrArchiveNotFound = 'Архив ' + CR + ' не найден!';
  rstrFileNotFound = 'File "%s" not found';
  rstrProcessRemainingFiles = 'Обрабатывать оставшиеся файлы ?';
  rstrFilesProcessed = 'Записано файлов: %u из %u';
  rstrCompleted = 'Завершение операции ...';

{ TExportToDeviceThread }

constructor TExportToDeviceThread.Create;
var
  FSettings: TMHLSettings;
begin
  inherited Create;
  FSettings := Settings;
  FAppPath := FSettings.AppPath;
  FTempPath := FSettings.TempPath;
  FFolderTemplate := FSettings.FolderTemplate;
  FFileNameTemplate := FSettings.FileNameTemplate;
  FOverwriteFB2Info := FSettings.OverwriteFB2Info;
  FTXTEncoding := FSettings.TXTEncoding;
end;

//
// Определяем имя файла, если нужно - предварительно распаковываем
// формируем названия папок и файла
//
function TExportToDeviceThread.PrepareFile(const BookKey: TBookKey): Boolean;
var
  Collection: IBookCollection;
  R: TBookRecord;
  FTargetFolder: string;
  FTargetFileName: string;
begin
  Result := False;
  try


    Collection := FSystemData.GetCollection(BookKey.DatabaseID);
    Collection.GetBookRecord(BookKey, R, False);

    // если не задействован скрипт, создаем папки
    // если будет вызываться скрипт, то папки не нужны, все равно они не обрабатываются
    // промежуточный файл остается во временной папке
    if not FExtractOnly Then
    begin

      //
      // Сформируем имя каталога в соответствии с заданным темплейтом
      //
      if FTemplater.SetTemplate(FFolderTemplate, TpPath) = ErFine then
        FTargetFolder := FTemplater.ParseString(R, TpPath)
      else
      begin
        Dialogs.ShowMessage(rstrCheckTemplateValidity);
        Exit;
      end;

      if FTargetFolder <> '' then
        FTargetFolder := IncludeTrailingPathDelimiter(Trim(FTargetFolder));

      CreateFolders(DeviceDir, FTargetFolder);
    end;

    //
    // Сформируем имя файла в соответствии с заданным темплейтом
    //
    if FTemplater.SetTemplate(FFileNameTemplate, TpFile) = ErFine then
      FTargetFileName := FTemplater.ParseString(R, TpFile)
    else
    begin
      Dialogs.ShowMessage(rstrCheckTemplateValidity);
      Exit;
    end;
    FTargetFileName := Trim(FTargetFileName) + R.FileExt;

    FFileOprecord.TargetFile := TPath.Combine(FTargetFolder, FTargetFileName);
    FFileOprecord.SourceFile := R.GetBookFileName;

    //
    // Если файл в архиве - распаковываем в $tmp
    //
    FBookFormat := R.GetBookFormat;
    if FBookFormat in [bfFb2, bfFb2Archive, bfRawArchive, bfFbd] then
    begin
      if not FileExists(FFileOprecord.SourceFile) then
      begin
        ShowMessage(rstrArchiveNotFound, MB_ICONERROR or MB_OK);
        Exit;
      end;

      FFileOprecord.SourceFile := TPath.Combine(FTempPath, FTargetFileName);
      R.SaveBookToFile(FFileOprecord.SourceFile);

      if (FBookFormat in [bfFb2, bfFb2Archive]) and FOverwriteFB2Info then
        WriteFb2InfoToFile(R, FFileOprecord.SourceFile);
    end;

    Result := True;
  except
    // подавляем исключения дабы не прерывать процесс
  end;
end;

function TExportToDeviceThread.SendFileToDevice: Boolean;
var
  DestFileName: string;
  archiver: TMHLZip;
begin
  if not FileExists(FFileOprecord.SourceFile) then
  begin
    ShowMessage(Format(rstrFileNotFound, [FFileOprecord.SourceFile]), MB_ICONERROR or MB_OK);
    Result := False;
    Exit;
  end;

  DestFileName := TPath.Combine(FDeviceDir, FFileOprecord.TargetFile);

  //
  // TODO -cBug: тут некоторая фигня. Мы вызываем конверторы, даже если исходная книга не FB2. Я помню, что режим для не-FB2 книг выставляется более-менее правильно, но...
  //
  Result := True;
  try
    case FExportMode of
      emFB2:
        unit_globals.CopyFile(FFileOprecord.SourceFile, DestFileName);

      emFB2Zip:
        begin
          try
            archiver := TMHLZip.Create(DestFileName + ZIP_EXTENSION, False);
            archiver.BaseDir := Settings.TempDir;
            archiver.AddFiles(FFileOprecord.SourceFile);
          finally
            FreeAndNil(archiver);
          end;
        end;

      emTxt:
        unit_globals.ConvertToTxt(FFileOprecord.SourceFile, DestFileName, FTXTEncoding);

      emLrf:
        Result := fb2Lrf(FFileOprecord.SourceFile, DestFileName);

      emEpub:
        Result := fb2EPUB(FFileOprecord.SourceFile, DestFileName);

      emPDF:
        Result := fb2PDF(FFileOprecord.SourceFile, DestFileName);

      emMobi:
        Result := fb2Mobi(FFileOprecord.SourceFile, DestFileName);
    end;
  except
    // подавляем исключения дабы не прерывать процесс
  end;
end;

function TExportToDeviceThread.fb2Lrf(const InpFile: string; const OutFile: string): Boolean;
var
  params: string;
begin
  params := Format('-i "%s" -o "%s"', [InpFile, ChangeFileExt(OutFile, '.lrf')]);
  Result := ExecAndWait(FAppPath + 'converters\fb2lrf\fb2lrf_c.exe', params, SW_HIDE);
end;

function TExportToDeviceThread.fb2EPUB(const InpFile: string; const OutFile: string): Boolean;
var
  params: string;
begin
  params := Format('"%s" "%s"', [InpFile, ChangeFileExt(OutFile, '.epub')]);
  Result := ExecAndWait(FAppPath + 'converters\fb2epub\fb2epub.exe', params, SW_HIDE);
end;

function TExportToDeviceThread.fb2PDF(const InpFile: string; const OutFile: string): Boolean;
var
  params: string;
begin
  params := Format('"%s" "%s"', [InpFile, ChangeFileExt(OutFile, '.pdf')]);
  Result := ExecAndWait(FAppPath + 'converters\fb2pdf\fb2pdf.cmd', params, SW_HIDE);
end;

function TExportToDeviceThread.fb2Mobi(const InpFile: string; const OutFile: string): Boolean;
var
  params: string;
begin
  params := Format('"%s" "%s" -nc -cl -us -nt', [InpFile, ChangeFileExt(OutFile, '.mobi')]);
  Result := ExecAndWait(FAppPath + 'converters\fb2mobi\fb2mobi.exe', params, SW_HIDE);
end;

procedure TExportToDeviceThread.Initialize;
begin
  inherited Initialize;
  FSystemData := DMUser.GetSystemDBConnection;
  Assert(Assigned(FSystemData));
  FTemplater := TTemplater.Create;
end;

procedure TExportToDeviceThread.Uninitialize;
begin
  FTemplater.Free;
  FSystemData.ClearCollectionCache;
  inherited Uninitialize;
end;

procedure TExportToDeviceThread.WorkFunction;
var
  i: Integer;
  totalBooks: Integer;
  Res: Boolean;
begin
  FProgressEngine.BeginOperation(Length(FBookIdList), rstrFilesProcessed, rstrFilesProcessed);
  try
    totalBooks := Length(FBookIdList);

    for i := 0 to totalBooks - 1 do
    begin
      if Canceled then
        Break;

      Res := PrepareFile(FBookIdList[i].BookKey);
      if Res then
      begin
        if i = 0 then
          FProcessedFiles := FFileOprecord.SourceFile;

        if not FExtractOnly Then Res := SendFileToDevice;
      end;

      if not Res and (i < totalBooks - 1) then
      begin
        //
        // TODO -oNickR -cUsability : предусмотреть возможность сказать "да для всех"
        //
        Canceled := (ShowMessage(rstrProcessRemainingFiles, MB_ICONQUESTION or MB_YESNO) = IDNO);
      end;

      FProgressEngine.AddProgress;
    end;

  finally
    FProgressEngine.EndOperation;
  end;
end;

end.

