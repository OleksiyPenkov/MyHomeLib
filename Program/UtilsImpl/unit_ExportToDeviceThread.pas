(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov (aka Koreec)
  *
  * Authors Oleksiy Penkov   oleksiy.penkov@gmail.com
  *         Nick Rymanov     nrymanov@gmail.com
  *         Matvienko Sergei matv84@mail.ru
  *
  ****************************************************************************** *)

unit unit_ExportToDeviceThread;

interface

uses
  Classes,
  ShlObj,
  ActiveX,
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
      TargetFolder: string; // relative folder (from folder template) under DeviceDir
      TempFile: string;
      FileName: string;
      Stream: TStream;
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
    FUseMTP: Boolean;
    FMarshalStream: IStream;
    FDeviceShellItem: IShellItem;
    FLastError: string;
    FConverterExitCode: Cardinal;

    FMaxTempPathLength: Integer;

    function fb2Lrf(const InpFile: string; const OutFile: string): Boolean;
    function fb2EPUB(const InpFile: string; const OutFile: string): Boolean;
    function fb2PDF(const InpFile: string; const OutFile: string): Boolean;
    function fb2Mobi(const InpFile, OutFile: string): Boolean;
    procedure ExportToZip;
    procedure SetDeviceDir(const Value: string);
    function CallExternalConverter: boolean;
    function ProcessFileFromStream: boolean;
    function ExportToFB2: boolean;

  strict private
    function PrepareFile(const BookKey: TBookKey): Boolean;
    function SendFileToDevice: Boolean;
    procedure RemoveEmptyTargetFolders;

  protected
    procedure Initialize; override;
    procedure Uninitialize; override;
    procedure WorkFunction; override;

  public
    constructor Create;

    property BookIdList: TBookIdList read FBookIdList write FBookIdList;
    property DeviceDir: string read FDeviceDir write SetDeviceDir;
    property UseMTP: Boolean read FUseMTP write FUseMTP;
    property MarshalStream: IStream write FMarshalStream;
    property ProcessedFiles: string read FProcessedFiles;
    property ExportMode: TExportMode read FExportMode write FExportMode;
    property ExtractOnly: boolean write FExtractOnly;
  end;

//
// Повний шлях до зовнішнього конвертера, потрібного для режиму Mode.
// Повертає '', якщо режим обробляється власними засобами (fb2/fb2.zip/txt).
//
function GetConverterPath(const AppPath: string; Mode: TExportMode): string;

implementation

uses
  Windows,
  SysUtils,
  IOUtils,
  unit_Consts,
  unit_Settings,
  unit_Helpers,
  dm_user,
  unit_MHLHelpers,
  unit_MHLArchiveHelpers,
  unit_WriteFb2Info;

resourcestring
  rstrCheckTemplateValidity = 'Перевірте правильність шаблону';
  rstrArchiveNotFound = 'Архів' + CR + 'не знайдено!';
  rstrFileNotFound = 'File "%s" not found';
  rstrExportFileFailed = 'Не вдалось експортувати файл "%s".' + CR + CR + 'Обробляти файли, що залишилися?';
  rstrFilesProcessed = 'Записано файли: %u з %u';
  rstrCompleted = 'Завершення операції...';
  rstrRememberChoise = 'Запам''ятати вибір?';
  rstrExportErrors = 'Під час експорту виникли помилки: %d з %d файлів не вдалось експортувати.' + CR + 'Деталі у файлі: %s';

const
  MaxPathLength = 240;

function GetConverterPath(const AppPath: string; Mode: TExportMode): string;
begin
  case Mode of
    emLrf:  Result := AppPath + 'converters\fb2lrf\fb2lrf_c.exe';
    emEpub: Result := AppPath + 'converters\fb2epub\fb2epub.exe';
    emPDF:  Result := AppPath + 'converters\fb2pdf\fb2pdf.cmd';
    emMobi: Result := AppPath + 'converters\fb2mobi\fb2mobi.exe';
  else
    Result := '';
  end;
end;

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

  FMaxTempPathLength := MaxPathLength - Length(FTempPath);
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
  FTargetFullFilePath: string;
  FTempFileName: string;
  Stream: TStream;
begin
  Result := False;
  try


    Collection := FSystemData.GetCollection(BookKey.DatabaseID);
    Collection.GetBookRecord(BookKey, R, False);

    // если не задействован скрипт, создаем папки
    // если будет вызываться скрипт, то папки не нужны, все равно они не обрабатываются
    // промежуточный файл остается во временной папке
    FTargetFolder := '';
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

      if not FUseMTP then
        CreateFolders(DeviceDir, FTargetFolder);
    end;

    FFileOprecord.TargetFolder := FTargetFolder;

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

    FTargetFullFilePath := Trim(TPath.Combine(FTargetFolder, FTargetFileName));
    FTargetFullFilePath := TPath.Combine(FDeviceDir, FTargetFullFilePath);

    if Length(FTargetFullFilePath) < MaxPathLength then
      FTargetFullFilePath := FTargetFullFilePath + R.FileExt
    else
      FTargetFullFilePath  := Format('%s.%d%s',[copy(FTargetFullFilePath, 1, MaxPathLength), R.BookKey.BookID, R.FileExt]);

    // Ensure unique filename to avoid overwriting books with identical names (#63)
    // FileExists does not work for MTP shell paths; IFileOperation handles conflicts
    if not FUseMTP then
    begin
      // Compute actual output path based on export mode
      var ActualOutputPath: string;
      case FExportMode of
        emFB2Zip: ActualOutputPath := FTargetFullFilePath + ZIP_EXTENSION;
        emLrf:    ActualOutputPath := ChangeFileExt(FTargetFullFilePath, '.lrf');
        emEpub:   ActualOutputPath := ChangeFileExt(FTargetFullFilePath, '.epub');
        emPDF:    ActualOutputPath := ChangeFileExt(FTargetFullFilePath, '.pdf');
        emMobi:   ActualOutputPath := ChangeFileExt(FTargetFullFilePath, '.mobi');
        emTxt:    ActualOutputPath := ChangeFileExt(FTargetFullFilePath, '.txt');
      else
        ActualOutputPath := FTargetFullFilePath;
      end;

      if FileExists(ActualOutputPath) then
      begin
        var BaseName := ChangeFileExt(FTargetFullFilePath, '');
        var Ext := ExtractFileExt(FTargetFullFilePath);
        var Counter := 1;
        repeat
          FTargetFullFilePath := Format('%s (%d)%s', [BaseName, Counter, Ext]);
          case FExportMode of
            emFB2Zip: ActualOutputPath := FTargetFullFilePath + ZIP_EXTENSION;
            emLrf:    ActualOutputPath := ChangeFileExt(FTargetFullFilePath, '.lrf');
            emEpub:   ActualOutputPath := ChangeFileExt(FTargetFullFilePath, '.epub');
            emPDF:    ActualOutputPath := ChangeFileExt(FTargetFullFilePath, '.pdf');
            emMobi:   ActualOutputPath := ChangeFileExt(FTargetFullFilePath, '.mobi');
            emTxt:    ActualOutputPath := ChangeFileExt(FTargetFullFilePath, '.txt');
          else
            ActualOutputPath := FTargetFullFilePath;
          end;
          Inc(Counter);
        until not FileExists(ActualOutputPath);
      end;
    end;

    FFileOprecord.SourceFile := R.GetBookFileName;
    FFileOprecord.FileName := FTargetFileName + R.FileExt;

    // For MTP: write to temp, then shell-copy to device
    if FUseMTP then
      FFileOprecord.TargetFile := TPath.Combine(FTempPath, FFileOprecord.FileName)
    else
      FFileOprecord.TargetFile := FTargetFullFilePath;

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

      if Length(FTargetFileName) < FMaxTempPathLength then
        FTempFileName := Format('%s%s', [FTargetFileName, R.FileExt])
      else
        FTempFileName := Format('%s%s',[Copy(FTargetFileName, 1, FMaxTempPathLength), R.FileExt]);

      FFileOprecord.TempFile := TPath.Combine(FTempPath, FTempFileName);

      FFileOprecord.Stream := R.GetBookStream;

      if (FBookFormat in [bfFb2, bfFb2Archive]) and FOverwriteFB2Info then
        WriteFb2InfoToStream(R, FFileOprecord.Stream);

    end;

    Result := True;
  except
    on E: Exception do
      FLastError := Format('PrepareFile exception: %s', [E.Message]);
  end;
end;

procedure TExportToDeviceThread.ExportToZip;
var
  archiver: TMHLZip;
  ZipFile: string;
begin
  try
    ZipFile := FFileOprecord.TargetFile + ZIP_EXTENSION;
    if FileExists(ZipFile) then
    begin
      var BaseName := ChangeFileExt(FFileOprecord.TargetFile, '');
      var Ext := ExtractFileExt(FFileOprecord.TargetFile);
      var Counter := 1;
      repeat
        ZipFile := Format('%s (%d)%s', [BaseName, Counter, Ext]) + ZIP_EXTENSION;
        Inc(Counter);
      until not FileExists(ZipFile);
    end;
    archiver := TMHLZip.Create(ZipFile, False);
    FFileOprecord.Stream.Seek(0, soFromBeginning);
    archiver.AddFromStream(FFileOprecord.FileName, FFileOprecord.Stream);
  finally
    FreeAndNil(archiver);
  end;
end;

procedure TExportToDeviceThread.SetDeviceDir(const Value: string);
begin
  FDeviceDir := Value;
end;

function StreamToFile(const AFileName: string; AStream: TStream): boolean;
var
  FileStream: TFileStream;
begin
  Result := False;
  FileStream := TFileStream.Create(AFileName, fmCreate);
  try
    AStream.Seek(0, soFromBeginning);
    FileStream.CopyFrom(AStream, AStream.Size);
    Result := True;
  finally
    FileStream.Free;
  end;
end;

function TExportToDeviceThread.CallExternalConverter: boolean;
var
  OutputPath: string;
  ConverterExe: string;
  TempFileCreated: Boolean;
begin
  Result := False;
  TempFileCreated := False;
  FConverterExitCode := 0;
  try
    if FFileOprecord.Stream <> nil then
    begin
      StreamToFile(FFileOprecord.TempFile, FFileOprecord.Stream);
      FFileOprecord.SourceFile := FFileOprecord.TempFile;
      TempFileCreated := True;
    end;

    // Compute the path the converter will actually produce.
    case FExportMode of
      emLrf:  OutputPath := ChangeFileExt(FFileOprecord.TargetFile, '.lrf');
      emEpub: OutputPath := ChangeFileExt(FFileOprecord.TargetFile, '.epub');
      emPDF:  OutputPath := ChangeFileExt(FFileOprecord.TargetFile, '.pdf');
      emMobi: OutputPath := ChangeFileExt(FFileOprecord.TargetFile, '.mobi');
    else
      OutputPath := FFileOprecord.TargetFile;
    end;

    // Remove any stale output from a previous run so we don't mistake it for
    // fresh converter output if the exe silently fails (#65).
    if FileExists(OutputPath) then
      DeleteFile(OutputPath);

    case FExportMode of
      emLrf:
        Result := fb2Lrf(FFileOprecord.SourceFile, FFileOprecord.TargetFile);

      emEpub:
        Result := fb2EPUB(FFileOprecord.SourceFile, FFileOprecord.TargetFile);

      emPDF:
        Result := fb2PDF(FFileOprecord.SourceFile, FFileOprecord.TargetFile);

      emMobi:
        Result := fb2Mobi(FFileOprecord.SourceFile, FFileOprecord.TargetFile);
    end;

    // Converter process may exit 0 without producing output (e.g. locked target,
    // CLI args mismatch, path encoding). Verify the file really was created.
    if Result and not FileExists(OutputPath) then
    begin
      Result := False;
      // Називаємо конвертер явно - інакше з повідомлення не зрозуміло, який саме
      // з чотирьох зовнішніх конвертерів впав (#59)
      ConverterExe := GetConverterPath(FAppPath, FExportMode);
      if FConverterExitCode <> 0 then
        FLastError := Format('Converter "%s" failed with exit code %d and produced no output: %s',
          [ConverterExe, FConverterExitCode, OutputPath])
      else
        FLastError := Format('Converter "%s" exited OK but produced no output: %s',
          [ConverterExe, OutputPath]);

      // fb2pdf.cmd - обгортка над Java; без встановленої JRE вона одразу виходить з кодом 1
      if FExportMode = emPDF then
        FLastError := FLastError + ' (fb2pdf requires an installed Java runtime)';
    end;
  except
    on E: Exception do
      FLastError := Format('CallExternalConverter exception: %s', [E.Message]);
  end;

  // Проміжний файл потрібен лише конвертеру - не залишаємо його у $tmp (#59)
  if TempFileCreated and FileExists(FFileOprecord.TempFile) then
    DeleteFile(FFileOprecord.TempFile);
end;

function TExportToDeviceThread.ExportToFB2: boolean;
begin
  if FFileOprecord.Stream <> nil then
    Result := StreamToFile(FFileOprecord.TargetFile, FFileOprecord.Stream)
  else
   Result := unit_globals.CopyFile(FFileOprecord.SourceFile, FFileOprecord.TargetFile);
end;

function TExportToDeviceThread.ProcessFileFromStream: boolean;
begin
  Result := False;
  try

    case FExportMode of
         emFB2: if not ExportToFB2 then Exit;

      emFB2Zip: ExportToZip;

         emTxt: unit_globals.ConvertToTxt(FFileOprecord.TargetFile, FTXTEncoding, FFileOprecord.Stream);
    end;
    Result := True;
  except
    on E: Exception do
      FLastError := Format('ProcessFileFromStream exception: %s', [E.Message]);
  end;
end;

//
// Папки за шаблоном створюються ще до конвертації, тож після невдалого
// експорту на пристрої залишаються порожні каталоги (#59). Прибираємо їх,
// піднімаючись до DeviceDir; RemoveDir не чіпає непорожні папки, тому
// каталоги з уже записаними книгами вціліють.
//
procedure TExportToDeviceThread.RemoveEmptyTargetFolders;
var
  Root: string;
  Current: string;
begin
  if FUseMTP or FExtractOnly or (FFileOprecord.TargetFolder = '') then
    Exit;

  try
    Root := ExcludeTrailingPathDelimiter(FDeviceDir);
    Current := ExcludeTrailingPathDelimiter(TPath.Combine(FDeviceDir, FFileOprecord.TargetFolder));

    while (Length(Current) > Length(Root)) and
          SameText(Copy(Current, 1, Length(Root)), Root) and
          DirectoryExists(Current) do
    begin
      if not RemoveDir(Current) then
        Break;
      Current := ExcludeTrailingPathDelimiter(ExtractFilePath(Current));
    end;
  except
    // прибирання не має зривати експорт
  end;
end;

function TExportToDeviceThread.SendFileToDevice: Boolean;
var
  TempFile: string;
  MTPTargetFolder: IShellItem;
begin
  Result := False;
  FLastError := '';

  if not FileExists(FFileOprecord.SourceFile) then
  begin
    FLastError := Format('Source not found: %s', [FFileOprecord.SourceFile]);
    ShowMessage(Format(rstrFileNotFound, [FFileOprecord.SourceFile]), MB_ICONERROR or MB_OK);
    Exit;
  end;

  // Resolve (and create) the author/series subfolder on MTP before copying (#65).
  if FUseMTP then
  begin
    if not Assigned(FDeviceShellItem) then
    begin
      FLastError := Format('DeviceShellItem is nil, DeviceDir=%s', [FDeviceDir]);
      Exit;
    end;
    MTPTargetFolder := ResolveOrCreateShellSubfolder(FDeviceShellItem, FFileOprecord.TargetFolder);
    if not Assigned(MTPTargetFolder) then
    begin
      FLastError := Format('Failed to resolve/create MTP subfolder: %s', [FFileOprecord.TargetFolder]);
      Exit;
    end;
  end;

  if FBookFormat in [bfFb2, bfFb2Archive] then
  begin
    case FExportMode of
        emFB2, emFB2Zip, emTxt: Result := ProcessFileFromStream;
    else
      Result := CallExternalConverter;
    end;

    if not Result then
    begin
      if FLastError = '' then
        FLastError := Format('ProcessFile failed, Mode=%d, Target=%s', [Ord(FExportMode), FFileOprecord.TargetFile]);
      Exit;
    end;

    // For MTP: shell-copy the temp output file to the device, then clean up
    if FUseMTP then
    begin
      // Determine the actual output file path
      case FExportMode of
        emFB2Zip: TempFile := FFileOprecord.TargetFile + ZIP_EXTENSION;
        emLrf:    TempFile := ChangeFileExt(FFileOprecord.TargetFile, '.lrf');
        emEpub:   TempFile := ChangeFileExt(FFileOprecord.TargetFile, '.epub');
        emPDF:    TempFile := ChangeFileExt(FFileOprecord.TargetFile, '.pdf');
        emMobi:   TempFile := ChangeFileExt(FFileOprecord.TargetFile, '.mobi');
      else
        TempFile := FFileOprecord.TargetFile;
      end;

      if not FileExists(TempFile) then
      begin
        FLastError := Format('Temp file not found: %s', [TempFile]);
        Result := False;
        Exit;
      end;

      Result := ShellCopyFile(TempFile, MTPTargetFolder, ExtractFileName(TempFile));
      if not Result then
        FLastError := Format('ShellCopyFile failed: %s -> %s\%s',
          [TempFile, FFileOprecord.TargetFolder, ExtractFileName(TempFile)]);
      DeleteFile(TempFile);
    end;
  end
  else
  begin
    if FUseMTP then
    begin
      Result := ShellCopyFile(FFileOprecord.SourceFile, MTPTargetFolder, FFileOprecord.FileName);
      if not Result then
        FLastError := Format('ShellCopyFile failed: %s -> %s\%s',
          [FFileOprecord.SourceFile, FFileOprecord.TargetFolder, FFileOprecord.FileName]);
    end
    else
    begin
      Result := unit_globals.CopyFile(FFileOprecord.SourceFile, FFileOprecord.TargetFile);
      if not Result then
        FLastError := Format('CopyFile failed: %s -> %s', [FFileOprecord.SourceFile, FFileOprecord.TargetFile]);
    end;
  end;
end;

function TExportToDeviceThread.fb2Lrf(const InpFile: string; const OutFile: string): Boolean;
var
  params: string;
begin
  params := Format('-i "%s" -o "%s"', [InpFile, ChangeFileExt(OutFile, '.lrf')]);
  Result := ExecAndWait(GetConverterPath(FAppPath, emLrf), params, SW_HIDE, FConverterExitCode);
end;

function TExportToDeviceThread.fb2EPUB(const InpFile: string; const OutFile: string): Boolean;
var
  params: string;
begin
  params := Format('"%s" "%s"', [InpFile, ChangeFileExt(OutFile, '.epub')]);
  Result := ExecAndWait(GetConverterPath(FAppPath, emEpub), params, SW_HIDE, FConverterExitCode);
end;

function TExportToDeviceThread.fb2PDF(const InpFile: string; const OutFile: string): Boolean;
var
  params: string;
begin
  params := Format('"%s" "%s"', [InpFile, ChangeFileExt(OutFile, '.pdf')]);
  Result := ExecAndWait(GetConverterPath(FAppPath, emPDF), params, SW_HIDE, FConverterExitCode);
end;

function TExportToDeviceThread.fb2Mobi(const InpFile: string; const OutFile: string): Boolean;
var
  params: string;
begin
  params := Format('"%s" "%s" -nc -cl -us -nt', [InpFile, ChangeFileExt(OutFile, '.mobi')]);
  Result := ExecAndWait(GetConverterPath(FAppPath, emMobi), params, SW_HIDE, FConverterExitCode);
end;

procedure TExportToDeviceThread.Initialize;
begin
  inherited Initialize;
  FSystemData := DMUser.GetSystemDBConnection;
  Assert(Assigned(FSystemData));
  FTemplater := TTemplater.Create;

  // Unmarshal IShellItem from the main thread's COM apartment
  if FUseMTP and Assigned(FMarshalStream) then
  begin
    CoGetInterfaceAndReleaseStream(FMarshalStream, IShellItem, FDeviceShellItem);
    FMarshalStream := nil;
  end;
end;

procedure TExportToDeviceThread.Uninitialize;
begin
  FDeviceShellItem := nil;
  FTemplater.Free;
  FSystemData.ClearCollectionCache;
  inherited Uninitialize;
end;

procedure TExportToDeviceThread.WorkFunction;
var
  i: Integer;
  totalBooks: Integer;
  Res: Boolean;
  IsShowDialog: BOOL;
  ErrorLog: TStringList;
  LogFileName: string;
  FailedCount: Integer;
begin
  IsShowDialog := True;
  FailedCount := 0;
  ErrorLog := TStringList.Create;
  try
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

        if FFileOprecord.Stream <> nil then
          FreeAndNil(FFileOprecord.Stream);

        if not Res then
        begin
          Inc(FailedCount);
          ErrorLog.Add(Format('%s  >>  %s  |  %s', [DateTimeToStr(Now), FFileOprecord.FileName, FLastError]));
          RemoveEmptyTargetFolders;

          if i < totalBooks - 1 then
          begin
            if IsShowDialog then
            begin
              Canceled := (ShowMessage(Format(rstrExportFileFailed, [FFileOprecord.FileName]), MB_ICONQUESTION or MB_YESNO) = IDNO);
              if ShowMessage(rstrRememberChoise, MB_ICONQUESTION or MB_YESNO) = IDYES then
                IsShowDialog := False;
            end;
          end;
        end;

        FProgressEngine.AddProgress;
      end;

    finally
      FProgressEngine.EndOperation;
    end;

    if FailedCount > 0 then
    begin
      LogFileName := Settings.SystemFileName[sfExportErrorLog];
      if TFile.Exists(LogFileName) then
        TFile.AppendAllText(LogFileName, ErrorLog.Text, TEncoding.UTF8)
      else
        ErrorLog.SaveToFile(LogFileName, TEncoding.UTF8);
      ShowMessage(Format(rstrExportErrors, [FailedCount, totalBooks, LogFileName]), MB_ICONWARNING or MB_OK);
    end;
  finally
    ErrorLog.Free;
  end;
end;

end.

