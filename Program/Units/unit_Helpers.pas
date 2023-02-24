(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov (nrymanov@gmail.com)
  * Created             12.02.2010
  * Description
  *
  * $Id: unit_Helpers.pas 1136 2014-02-22 05:34:11Z koreec $
  *
  * History
  * NickR 15.02.2010    Код переформатирован
  *
  ****************************************************************************** *)

unit unit_Helpers;

interface

uses
  Windows,
  Classes,
  StdCtrls,
  Dialogs,
  ComCtrls,
  Graphics,
  Generics.Collections,
  unit_Consts,
  IdHTTP,
  IdSocks,
  IdSSLOpenSSL;

type
  TIniStringList = class(TStringList)
  public
    constructor Create; overload;
  end;

procedure SetTextNoChange(editControl: TCustomEdit; const newText: string);

function GetFileSize(const FileName: string): Integer;

function ExpandFileNameEx(const basePath: string; const path: string): string;


type
  TMHLFileName = (
    fnGenreList,
    fnOpenCollection,
    fnSelectReader,
    fnSelectScript,
    fnOpenImportFile,
    fnSaveCollection,
    fnSaveLog,
    fnSaveImportFile,
    fnOpenINPX,
    fnSaveINPX,
    fnOpenUserData,
    fnSaveUserData,
    fnOpenCoverImage
  );

  TListViewHelper = class helper for TListView
    procedure AutosizeColumn(nColumn: Integer);
  end;

function GetFileName(key: TMHLFileName; out FileName: string): Boolean;

function GetFolderName(Handle: Integer; const Caption: string; var strFolder: string): Boolean;

function CreateImageFromResource(GraphicClass: TGraphicClass; const ResName: string; ResType: PChar = RT_RCDATA): TGraphic;

function MoveToRecycle(sFileName: string): Boolean;

function SimpleShellExecute(
  hWnd: HWND;
  const FileName: string;
  const Parameters: string = '';
  const Operation: string = 'open';
  ShowCmd: Integer = SW_SHOWNORMAL;
  const Directory: string = ''
  ): Cardinal;

implementation

uses
  SysUtils,
  StrUtils,
  IOUtils,
  Forms,
  dm_user,
  CommCtrl,
  ShlObj,
  ShellAPI,
  ShLwApi,
  ActiveX;

// ============================================================================
// TIniStringList
// ============================================================================
constructor TIniStringList.Create;
begin
  inherited Create;

  QuoteChar := '"';
  Delimiter := ';';
  StrictDelimiter := True;
end;

// ============================================================================
type
  THackEdit = class(TCustomEdit);

procedure SetTextNoChange(editControl: TCustomEdit; const newText: string);
var
  FOnChange: TNotifyEvent;
begin
  Assert(Assigned(editControl));

  FOnChange := THackEdit(editControl).OnChange;
  THackEdit(editControl).OnChange := nil;
  try
    editControl.Text := newText;
  finally
    THackEdit(editControl).OnChange := FOnChange;
  end;
end;

// ============================================================================
function GetFileSize(const FileName: string): Integer;
var
  hFile: Integer;
begin
  hFile := SysUtils.FileOpen(FileName, fmOpenRead or fmShareDenyWrite);
  if hFile = -1 then
    RaiseLastOSError;

  Result := Windows.GetFileSize(hFile, nil);
  SysUtils.FileClose(hFile);
end;

function ExpandFileNameEx(const basePath: string; const path: string): string;
var
  pathBuf: array[0..MAX_PATH] of WideChar;
begin
  Result := TPath.Combine(basePath, path);
  if PathCanonicalizeW(pathBuf, PWideChar(Result)) then
    Result := pathBuf;
end;

// ============================================================================
type
  TStdDialogClass = class of TOpenDialog;

function InternalGetFileName(
  DialogClass: TStdDialogClass;
  const Title: string;
  const DefaultExt: string;
  const Filter: string;
  out strFileName: string;
  ExtraOptions: TOpenOptions;
  const dialogKey: string = ''
  ): Boolean;
var
  dlg: TOpenDialog;
begin
  dlg := DialogClass.Create(nil);
  try
    if Title <> '' then
      dlg.Title := Title;
    dlg.DefaultExt := DefaultExt;
    dlg.Filter := Filter;
    dlg.Options := dlg.Options + ExtraOptions;
    dlg.InitialDir := Settings.InitialDir[dialogKey];

    Result := dlg.Execute;
    if Result then
    begin
      strFileName := dlg.FileName;

      Settings.InitialDir[dialogKey] := ExtractFilePath(strFileName);
    end;
  finally
    dlg.Free;
  end;
end;

function GetOpenFileName(
  const Title: string;
  const DefaultExt: string;
  const Filter: string;
  out strFileName: string;
  const dialogKey: string = '';
  ExtraOptions: TOpenOptions = []
  ): Boolean;
begin
  //
  // TODO -oNickR -cUsability : использовать TFileOpenDialog под Vista-ой
  //
  Include(ExtraOptions, ofFileMustExist);
  Include(ExtraOptions, ofNoChangeDir);
  Result := InternalGetFileName(TOpenDialog, Title, DefaultExt, Filter, strFileName, ExtraOptions, dialogKey);
end;

function GetSaveFileName(
  const Title: string;
  const DefaultExt: string;
  const Filter: string;
  out strFileName: string;
  const dialogKey: string = '';
  ExtraOptions: TOpenOptions = []
  ): Boolean;
begin
  //
  // TODO -oNickR -cUsability : использовать TFileSaveDialog под Vista-ой
  //
  Include(ExtraOptions, ofOverwritePrompt);
  Include(ExtraOptions, ofNoChangeDir);
  Result := InternalGetFileName(TSaveDialog, Title, DefaultExt, Filter, strFileName, ExtraOptions, dialogKey);
end;

type
  TDialogParams = record
    Title: string;
    Filter: string;
    DefaultExt: string;
    DialogKey: string;
    OpenFile: Boolean;
  end;

resourcestring
  //fnGenreList
  rstrGenreListDlgTitle = 'Выбор списка жанров';
  rstrGenreListDlgFilter = 'Список жанров MyHomeLib (*.glst)|*.glst|Все типы|*.*';
  rstrGenreListDlgDefaultExt = GENRELIST_EXTENSION_SHORT;

  // fnOpenCollection
  rstrOpenCollectionDlgTitle = 'Открыть файл коллекции';
  // fnSaveCollection
  rstrSaveCollectionDlgTitle = 'Сохранить файл коллекции';
  rstrCollectionDlgFilter = 'Коллекция MyHomeLib (*.hlc2)|*.hlc2|Все типы|*.*';
  rstrCollectionDlgDefaultExt = COLLECTION_EXTENSION_SHORT;

  // fnSelectReader
  rstrSelectReaderDlgTitle = 'Выбор программы для просмотра';
  // fnSelectScript
  rstrSelectScriptDlgTitle = 'Выбор скрипта';
  rstrSelectProgrammDlgFilter = 'Скрипты, программы (*.exe;*.bat;*.cmd;*.vbs;*.js)|*.exe;*.bat;*.cmd;*.vbs;*.js|Все типы|*.*';
  rstrSelectProgrammDlgDefaultExt = 'exe';

  // fnOpenImportFile
  rstrOpenImportFileDlgTitle = 'Открыть xml';
  // fnSaveImportFile
  rstrSaveImportFileDlgTitle = 'Сохранить xml';
  rstrImportFileDlgFilter = 'xml (*.xml)|*.xml|Все типы|*.*';
  rstrImportFileDlgDefaultExt = 'xml';

  // fnSaveLog
  rstrSaveLogDlgTitle = 'Сохранить лог работы';
  rstrSaveLogDlgFilter = 'Файл протокола (*.log)|*.log|Все типы|*.*';
  rstrSaveLogDlgDefaultExt = 'log';
  //fnOpenINPX
  rstrOpenINPXDlgTitle = 'Выбор файла списков';
  rstrOpenINPXDlgFilter = 'Список книг MyHomeLib (*.inpx)|*.inpx|Все типы|*.*';
  rstrOpenINPXDlgDefaultExt = 'inpx';

  //fnSaveINPX
  rstrSaveINPXDlgTitle = 'Выбор файла списков';
  rstrSaveINPXDlgFilter = 'Список книг MyHomeLib (*.inpx)|*.inpx|Все типы|*.*';
  rstrSaveINPXDlgDefaultExt = 'inpx';

  //fnOpenUserData
  rstrOpenUDDlgTitle = 'Импорт пользовательских данных';
  rstrOpenUDDlgFilter = 'Пользовательские данные MyHomeLib (mhlud, mhlud2)|*.mhlud2;*.mhlud|Все типы|*.*';
  rstrOpenUDDlgDefaultExt = 'mhlud2';

  //fnSaveUserData
  rstrSaveUDDlgTitle = 'Экспорт пользовательских данных';
  rstrSaveUDDlgFilter = 'Пользовательские данные MyHomeLib (mhlud2)|*.mhlud2|Все типы|*.*';
  rstrSaveUDDlgDefaultExt = 'mhlud2';

  //fnOpenCoverImage
  rstrOpenCIDlgTitle = 'Загрузка файла обложки';
  rstrOpenCIDlgFilter = 'Изображения (*.png;*.jpg;*.jpeg)|*.jpeg;*.jpg;*.png';
  rstrOpenCIDlgDefaultExt = 'jpeg';


function GetFileName(key: TMHLFileName; out FileName: string): Boolean;
const
  DlgParams: array[TMHLFileName] of TDialogParams = (
    ( // fnGenreList
      Title:      rstrGenreListDlgTitle;
      Filter:     rstrGenreListDlgFilter;      DefaultExt: rstrGenreListDlgDefaultExt;
      DialogKey:  'SelectGenreList';           OpenFile:   True
    ),
    ( // fnOpenCollection
      Title:      rstrOpenCollectionDlgTitle;
      Filter:     rstrCollectionDlgFilter;     DefaultExt: rstrCollectionDlgDefaultExt;
      DialogKey:  'OpenCollection';            OpenFile:   True
    ),
    ( // fnSelectReader
      Title:      rstrSelectReaderDlgTitle;
      Filter:     rstrSelectProgrammDlgFilter; DefaultExt: rstrSelectProgrammDlgDefaultExt;
      DialogKey:  'SelectReader';              OpenFile:   True
    ),
    ( // fnSelectScript
      Title:      rstrSelectScriptDlgTitle;
      Filter:     rstrSelectProgrammDlgFilter; DefaultExt: rstrSelectProgrammDlgDefaultExt;
      DialogKey:  'SelectScript';              OpenFile:   True
    ),
    ( // fnOpenImportFile
      Title:      rstrOpenImportFileDlgTitle;
      Filter:     rstrImportFileDlgFilter;     DefaultExt: rstrImportFileDlgDefaultExt;
      DialogKey:  'OpenImportFile';            OpenFile:   True
    ),
    ( // fnSaveCollection
      Title:      rstrSaveCollectionDlgTitle;
      Filter:     rstrCollectionDlgFilter;     DefaultExt: rstrCollectionDlgDefaultExt;
      DialogKey:  'SaveCollection';            OpenFile:   False
    ),
    ( // fnSaveLog
      Title:      rstrSaveLogDlgTitle;
      Filter:     rstrSaveLogDlgFilter;        DefaultExt: rstrSaveLogDlgDefaultExt;
      DialogKey:  'SaveLog';                   OpenFile:   False
    ),
    ( // fnSaveImportFile
      Title:      rstrSaveImportFileDlgTitle;
      Filter:     rstrImportFileDlgFilter;     DefaultExt: rstrImportFileDlgDefaultExt;
      DialogKey:  'SaveImportFile';            OpenFile:   False
    ),
    ( // fnLoadINPX
      Title:      rstrOpenINPXDlgTitle;
      Filter:     rstrOpenINPXDlgFilter;     DefaultExt: rstrOpenINPXDlgDefaultExt;
      DialogKey:  'OpenINPXFile';            OpenFile:   True
    ),
    ( // fnSaveINPX
      Title:      rstrSaveINPXDlgTitle;
      Filter:     rstrSaveINPXDlgFilter;     DefaultExt: rstrSaveINPXDlgDefaultExt;
      DialogKey:  'SaveINPXFile';            OpenFile:   False
    ),
    ( // fnOpenUserData
      Title:      rstrOpenUDDlgTitle;
      Filter:     rstrOpenUDDlgFilter;     DefaultExt: rstrOpenUDDlgDefaultExt;
      DialogKey:  'OpenUserData';            OpenFile: True
    ),
    ( // fnSaveUserData
      Title:      rstrSaveUDDlgTitle;
      Filter:     rstrSaveUDDlgFilter;     DefaultExt: rstrSaveUDDlgDefaultExt;
      DialogKey:  'SaveUserData';            OpenFile: False
    ),
    ( // fnOpenCoverImage
      Title:      rstrOpenCIDlgTitle;
      Filter:     rstrOpenCIDlgFilter;     DefaultExt: rstrOpenCIDlgDefaultExt;
      DialogKey:  'OpenCoverImage';        OpenFile: True
    )



    //(Title: ''; Filter: ''; DefaultExt: ''; ExtraOptions: ; DialogKey: ''; GetFileNameFunction:)
  );
begin
  if DlgParams[key].OpenFile then
    Result := GetOpenFileName(
      DlgParams[key].Title, DlgParams[key].DefaultExt, DlgParams[key].Filter, FileName, DlgParams[key].DialogKey, []
      )
  else
    Result := GetSaveFileName(
      DlgParams[key].Title, DlgParams[key].DefaultExt, DlgParams[key].Filter, FileName, DlgParams[key].DialogKey, []
      );
end;

function BrowseCallbackProc(hwnd: HWND; uMsg: UINT; lParam: LPARAM; lpData: LPARAM): Integer; stdcall;
begin
  if (uMsg = BFFM_INITIALIZED) then
    SendMessage(hwnd, BFFM_SETSELECTION, 1, lpData);
  BrowseCallbackProc := 0;
end;

function GetFolderName(Handle: Integer; const Caption: string; var strFolder: string): Boolean;
var
  BrowseInfo: TBrowseInfo;
  lpItemID: PItemIDList;

  DisplayName: array [0 .. MAX_PATH] of Char;
  TempPath : array[0..MAX_PATH] of Char;
begin
  Result := False;

  FillChar(BrowseInfo, SizeOf(TBrowseInfo), #0);

  if 0 <> Handle then
    BrowseInfo.hwndOwner := Handle
  else
    BrowseInfo.hwndOwner := Application.Handle;

  BrowseInfo.pszDisplayName := @DisplayName;
  BrowseInfo.lpszTitle := PChar(Caption);
  BrowseInfo.ulFlags := BIF_RETURNONLYFSDIRS or BIF_USENEWUI;
  BrowseInfo.lpfn := @BrowseCallbackProc;
  BrowseInfo.lParam := LPARAM(PChar(strFolder));

  lpItemID := SHBrowseForFolder(BrowseInfo);
  if Assigned(lpItemID) then
  begin
    Result := SHGetPathFromIDList(lpItemID, TempPath);
    if Result then strFolder := StrPas(TempPath);
    CoTaskMemFree(lpItemID);
  end;
end;

function CreateImageFromResource(GraphicClass: TGraphicClass; const ResName: string; ResType: PChar): TGraphic;
var
  s: TResourceStream;
begin
  s := TResourceStream.Create(HInstance, ResName, ResType);
  try
    Result := GraphicClass.Create;
    Result.LoadFromStream(s);
  finally
    s.Free;
  end;
end;

function SimpleQuoteString(const Value: string): string;
const
  QUOTECHAR = '"';
begin
  if (Value = '') or (Value[1] = QUOTECHAR) then
    Result := Value
  else
    Result := QUOTECHAR + Value + QUOTECHAR;
end;

function SimpleShellExecute(
  hWnd: HWND;
  const FileName: string;
  const Parameters: string = '';
  const Operation: string = 'open';
  ShowCmd: Integer = SW_SHOWNORMAL;
  const Directory: string = ''
  ): Cardinal;
var
  AFileName: string;
  AParameters: string;
  ADirectory: string;
begin
  AFileName := SimpleQuoteString(FileName);

  if pos('"', Parameters) = 0 then
      AParameters := SimpleQuoteString(Parameters)
    else
      AParameters := Parameters;

    //  AFileName := FileName;
//  AParameters := Parameters;

  ADirectory := Directory;
  if ADirectory = '' then
    ADirectory := TPath.GetDirectoryName(Application.ExeName);

  Result := ShellAPI.ShellExecute(
    hWnd,
    PChar(Operation),
    PChar(AFileName),
    PChar(AParameters),
    PChar(Directory),
    ShowCmd
  );
end;

function MoveToRecycle(sFileName: string): Boolean;
var
  fos: TSHFileOpStruct;
begin
  FillChar(fos, SizeOf(fos), 0);
  with fos do
  begin
    wFunc  := FO_DELETE;
    pFrom  := PChar(sFileName);
    fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION or FOF_SILENT;
  end;
  Result := (0 = ShFileOperation(fos));
end;

{ TListViewHelper }

procedure TListViewHelper.AutosizeColumn(nColumn: Integer);
begin
  ListView_SetColumnWidth(Self.Handle, nColumn, LVSCW_AUTOSIZE);
end;

end.



