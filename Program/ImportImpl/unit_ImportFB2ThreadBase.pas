(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov    nrymanov@gmail.com
  *                     Oleksiy Penkov  oleksiy.penkov@gmail.com
  * Created             22.02.2010
  * Description
  *
  * $Id: unit_ImportFB2ThreadBase.pas 1144 2014-03-26 05:22:37Z ENikS $
  *
  * History
  * NickR 02.03.2010    Код переформатирован
  *
  ****************************************************************************** *)

unit unit_ImportFB2ThreadBase;

interface

uses
  Windows,
  Classes,
  SysUtils,
  fictionbook_21,
  files_list,
  unit_Globals,
  unit_WorkerThread,
  unit_CollectionWorkerThread,
  unit_MHLArchiveHelpers,
  unit_Templater,
  unit_Interfaces,
  unit_Consts;

type
  TImportFB2ThreadBase = class(TCollectionWorker)
  protected
    FTemplater: TTemplater;
    FFiles: TStringList;
    FFilesList: TFilesList;

    //
    // Эти поля должны быть установлены конструктором производного класса
    //
    FTargetExt: string;
    FZipFolder: Boolean;
    FFullNameSearch: Boolean;

    procedure ScanFolder;

    procedure ShowCurrentDir(Sender: TObject; const Dir: string);
    procedure AddFile2List(Sender: TObject; const F: TSearchRec);

    function GetNewFolder(Folder: string; R: TBookRecord): string;
    function GetNewFileName(FileName: string; R: TBookRecord): string;
  public
    constructor Create(CollectionID: integer);
    destructor Destroy;
  protected
    procedure ProcessFileList; virtual; abstract;
    procedure ProcessFileListArchive; virtual; abstract;
    procedure GetBookInfo(book: IXMLFictionBook; var R: TBookRecord);
    procedure SortFiles(var R: TBookRecord); virtual;

  protected
    FFb2ArchiveExt: string;
    FArchiveFormat : TArchiveFormat;
  end;

implementation

{
Settings.CheckExistsFiles
Settings.EnableSort
Settings.FB2FolderTemplate
Settings.FB2FileTemplate
Settings.FBDFolderTemplate
Settings.FBDFileTemplate
Settings.ImportPath
}

uses
  Dialogs,
  dm_user;

resourcestring
  rstrCheckTemplateValidity = 'Проверьте правильность шаблона';
  rstrScanningOne = 'Сканируем %s';
  rstrScanningAll = 'Сканируем...';
  rstrFoundFiles = 'Обнаружено файлов: %u';
  rstrScanningFolders = 'Сканирование папок...';

{ TImportFB2Thread }

constructor TImportFB2ThreadBase.Create;
begin
  inherited Create(CollectionID);
  FTemplater := TTemplater.Create;
end;

destructor TImportFB2ThreadBase.Destroy;
begin
  FreeAndNil(FTemplater);
  inherited Destroy;
end;

procedure TImportFB2ThreadBase.GetBookInfo(book: IXMLFictionBook; var R: TBookRecord);
var
  i: Integer;
begin
  //
  // TODO : создать в unit_FB2Utils ф-ию для получения инф-ии о книге из файла и заменить ее этот метод
  //
  with book.Description.Titleinfo do
  begin
    for i := 0 to Author.Count - 1 do
      TAuthorsHelper.Add(R.Authors, Author[i].Lastname.Text, Author[i].Firstname.Text, Author[i].MiddleName.Text);

    if Booktitle.IsTextElement then
    begin
      R.Title := Booktitle.Text;

      if Pos(AnsiString(#10), Booktitle.Text) <> 0 then
        begin
          StrReplace(AnsiString(#13#10), ' ', R.Title);
          StrReplace(AnsiString(#10), ' ', R.Title);
        end;
    end;

    for i := 0 to Genre.Count - 1 do
      TGenresHelper.Add(R.Genres, '', '', Genre[i]);

    R.Lang := Lang;
    R.KeyWords := KeyWords.Text;

    if Sequence.Count > 0 then
    begin
      try
        R.Series := Sequence[0].Name;
        R.SeqNumber := Sequence[0].Number;
      except
      end;
    end;

    for i := 0 to Annotation.P.Count - 1 do
      if Annotation.P.Items[i].IsTextElement then
        R.Annotation := R.Annotation + CRLF + Annotation.P.Items[i].OnlyText;

    if R.GenreCount > 0 then
      R.RootGenre.GenreAlias := Trim(FCollection.GetTopGenreAlias(R.Genres[0].FB2GenreCode));
  end;
end;

procedure TImportFB2ThreadBase.SortFiles(var R: TBookRecord);
var
  NewFilename, NewFolder: string;
begin
  NewFolder := GetNewFolder(Settings.FB2FolderTemplate, R);
  CreateFolders(FCollectionRoot, NewFolder);

  CopyFile(Settings.ImportPath + R.FileName + R.FileExt, FCollectionRoot + NewFolder + R.FileName + R.FileExt);
  R.Folder := NewFolder;

  NewFilename := GetNewFileName(Settings.FB2FileTemplate, R);
  if NewFilename <> '' then
  begin
    RenameFile(FCollectionRoot + NewFolder + R.FileName + R.FileExt, FCollectionRoot + NewFolder + NewFilename + R.FileExt);
    R.FileName := NewFilename;
  end;
end;

function TImportFB2ThreadBase.GetNewFileName(FileName: string; R: TBookRecord): string;
begin
  { DONE -oNickR -cPerformance : необходимо создавать шаблонизатор только один раз при инициализации потока }
  { DONE -oNickR -cBug : нет реакции на невалидный шаблон }
  if FTemplater.SetTemplate(FileName, TpFile) = ErFine then
    FileName := FTemplater.ParseString(R, TpFile)
  else
  begin
    Dialogs.ShowMessage(rstrCheckTemplateValidity);
    Exit;
  end;

  FileName := CheckSymbols(Trim(FileName));
  if FileName <> '' then
    Result := FileName
  else
    Result := '';
end;

function TImportFB2ThreadBase.GetNewFolder(Folder: string; R: TBookRecord): string;
begin
  { DONE -oNickR -cPerformance : необходимо создавать шаблонизатор только один раз при инициализации потока }
  { DONE -oNickR -cBug : нет реакции на невалидный шаблон }
  if FTemplater.SetTemplate(Folder, TpPath) = ErFine then
    Folder := FTemplater.ParseString(R, TpPath)
  else
  begin
    Dialogs.ShowMessage(rstrCheckTemplateValidity);
    Exit;
  end;

  Folder := CheckSymbols(Trim(Folder));
  if Folder <> '' then
    Result := IncludeTrailingPathDelimiter(Folder)
  else
    Result := '';
end;

procedure TImportFB2ThreadBase.ShowCurrentDir(Sender: TObject; const Dir: string);
begin
  SetComment(Format(rstrScanningOne, [Dir]));
end;

procedure TImportFB2ThreadBase.AddFile2List(Sender: TObject; const F: TSearchRec);
var
  FileName: string;
begin
  if LowerCase(ExtractFileExt(F.Name)) = FTargetExt then
  begin
    if Settings.EnableSort then
      FileName := FFilesList.LastDir + F.Name
    else
      FileName := ExtractRelativePath(FCollectionRoot, FFilesList.LastDir) + F.Name;

    if not FCollection.CheckFileInCollection(FileName, FFullNameSearch, FZipFolder) then
      FFiles.Add(FFilesList.LastDir + F.Name);
  end;

  if Canceled then
    Abort;
end;

procedure TImportFB2ThreadBase.ScanFolder;
begin
  FProgressEngine.BeginOperation(-1, rstrScanningAll, rstrScanningAll);
  try
    FFiles.Clear;
    Teletype(rstrScanningFolders);

    FFilesList := TFilesList.Create(nil);
    try
      FFilesList.OnDirectory := ShowCurrentDir;
      FFilesList.OnFile := AddFile2List;

      if Settings.EnableSort then
        FFilesList.TargetPath := Settings.ImportPath
      else
        FFilesList.TargetPath := FCollectionRoot;

      try
        FFilesList.Process;
        Teletype(Format(rstrFoundFiles, [FFiles.Count]));
      except
        on EAbort do
          { ignore} ;
      end;
    finally
      FreeAndNil(FFilesList);
    end;
  finally
    FProgressEngine.EndOperation;
  end;
end;



end.

