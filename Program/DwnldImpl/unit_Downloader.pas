(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Authors             Oleksiy Penkov   oleksiy.penkov@gmail.com
  *                     Nick Rymanov     nrymanov@gmail.com
  *                     Eugene Sadovoi   evgeni@eniks.com
  * Created
  * Description
  *
  * $Id: unit_Downloader.pas 1158 2014-04-17 01:26:26Z koreec $
  *
  * History
  * 2014-03-23 - Added support for generic online libraries
  *
  ****************************************************************************** *)

unit unit_Downloader;

interface

uses
  Windows,
  Classes,
  SysUtils,
  Dialogs,
  IdHTTP,
  IdSocks,
  IdSSLOpenSSL,
  IdURI,
  IdComponent,
  IdStack,
  IdStackConsts,
  IdWinsock2,
  IdMultipartFormData,
  unit_Globals,
  unit_Interfaces;

type
  TQueryKind = (qkGet, qkPost);

  EInvalidLogin = class(Exception);

  TCommand = record
    Code: Integer;
    Params: array of string;
  end;

  TScenarioCommands = array of TCommand;

  TSetCommentEvent = procedure(const Current, Total: string) of object;
  TProgressEvent = procedure(Current, Total: Integer) of object;

  TDownloader = class
  private
    URL: string;
    FidHTTP: TidHttp;
    FidSocksInfo: TIdSocksInfo;
    FidSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;

    FParams: TIdMultiPartFormDataStream;
    FResponse: TMemoryStream;

    FOnSetProgress: TProgressEvent;
    FOnSetComment: TSetCommentEvent;

    FNewURL: string;
    FNoProgress: boolean;
    Canceled: boolean;
    FDownloadSize: Integer;

    FStartDate: TDateTime;
    FIgnoreErrors: boolean;

    FFile: string;

    function AddParam(const Name: string; const Value: string): boolean;
    function Query(Kind: TQueryKind; const Uri: string): boolean;
    function CheckRedirect(): boolean;
    function CheckResponce(): boolean;
    function Pause(Time: Integer): boolean;

    function DoDownload(const Collection: IBookCollection; const BookRecord: TBookRecord): boolean;

    procedure HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure HTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure HTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure HTTPRedirect(Sender: TObject; var dest: string; var NumRedirect: Integer; var Handled: boolean; var VMethod: string);

    procedure ProcessError(const LongMsg, ShortMsg, AFileName: string);

    function ParseCommands(const scenario: string; const macros: TStrings) : TScenarioCommands;

  public
    constructor Create;
    destructor Destroy; override;

    function Download(const ASystemDB: ISystemData; const BookKey: TBookKey): boolean;
    procedure Stop;

    property IgnoreErrors: boolean read FIgnoreErrors write FIgnoreErrors;

    property OnProgress: TProgressEvent read FOnSetProgress write FOnSetProgress;
    property OnSetComment: TSetCommentEvent read FOnSetComment write FOnSetComment;
  end;

implementation

uses
  Forms,
  RTTI,
  HTTPApp,
  StrUtils,
  DateUtils,
  unit_Settings,
  dm_user,
  unit_Consts,
  unit_MHL_strings,
  unit_Messages,
  unit_Helpers,
  unit_ImportInpxThread,
  unit_MHLArchiveHelpers;

resourcestring
  rstrWrongCredentials = 'Неправильный логин/пароль';
  rstrDownloadBlockedByServer = 'Загрузка файла заблокирована сервером!' + CRLF
    + ' Ответ сервера можно посмотреть в файле "server_error.html"';
  rstrBlockedByServer = 'Заблокировано сервером';
  rstrSpeed = 'Загрузка: %s Kb/s';
  rstrDownloadError = 'Ошибка закачки';
  rstrServerNotFound = 'Закачка не удалась! Сервер не найден.';
  rstrError = 'Ошибка ';
  rstrTimeout = 'Закачка не удалась! Превышено время ожидания.';
  rstrConnectionError = 'Закачка не удалась! Ошибка подключения.';
  rstrServerError =
    'Закачка не удалась! Сервер сообщает об ошибке "%s".' + CRLF;
  rstrErrorCode = 'Код Ошибки ';

const
  CommandList: array [0 .. 5] of string = ('CHECK', 'REDIR', 'PAUSE', 'GET', 'POST', 'ADD');

  { TDownloader }

constructor TDownloader.Create;
begin
  inherited Create;

  FidHTTP := TidHttp.Create;
  FidSocksInfo := TIdSocksInfo.Create;
  FidSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;
  FidHTTP.OnWork := HTTPWork;
  FidHTTP.OnWorkBegin := HTTPWorkBegin;
  FidHTTP.OnWorkEnd := HTTPWorkEnd;
  FidHTTP.OnRedirect := HTTPRedirect;
  FidHTTP.HandleRedirects := True;

  SetProxySettingsGlobal(FidHTTP, FidSocksInfo, FidSSLIOHandlerSocketOpenSSL);

  FIgnoreErrors := False;
end;

destructor TDownloader.Destroy;
begin
  FreeAndNil(FidSSLIOHandlerSocketOpenSSL);
  FreeAndNil(FidSocksInfo);
  FreeAndNil(FidHTTP);

  inherited Destroy;
end;

function TDownloader.AddParam(const Name: string; const Value: string): boolean;
begin
  FParams.AddFormField(Name, Value);
  Result := True;
end;

function TDownloader.CheckRedirect(): boolean;
begin
  Result := (FNewURL <> '');
  if not Result then
    raise EInvalidLogin.Create(rstrWrongCredentials);
end;

function TDownloader.CheckResponce(): boolean;
var
  Path: string;
  Str: TStringList;
  archiver: TMHLZip;
begin
  Path := ExtractFileDir(FFile);
  CreateFolders('', Path);
  FResponse.Position := 0;

  Str := TStringList.Create;
  try
    Str.LoadFromStream(FResponse);
    if Str.Count > 0 then
    begin
      if (Pos('<!DOCTYPE', Str[0]) <> 0) or (Pos('overload', Str[0]) <> 0) or
        (Pos('not found', Str[0]) <> 0) then
      begin
        ProcessError(rstrDownloadBlockedByServer, rstrBlockedByServer, FFile);
        Str.SaveToFile(Settings.SystemFileName[sfServerErrorLog]);
      end
      else
      begin
        FResponse.SaveToFile(FFile);
        if IsArchiveExt(FFile) then
        begin
          // Test archive integrity only if it's an archive
          archiver := TMHLZip.Create(FFile, True);
          Result := archiver.Test(FFile);
          if not Result then
            DeleteFile(PChar(FFile));
        end;
      end;
    end;
  finally
    Str.Free;
    FreeAndNil(archiver);
  end;
end;

function TDownloader.Download(const ASystemDB: ISystemData; const BookKey: TBookKey): boolean;
var
  Collection: IBookCollection;
  BookRecord: TBookRecord;
begin
  Result := False;

  Collection := ASystemDB.GetCollection(BookKey.DatabaseID);
  Collection.GetBookRecord(BookKey, BookRecord, False);

  FFile := BookRecord.GetBookFileName;
  if FileExists(FFile) or DoDownload(Collection, BookRecord) then
  begin
    Collection.SetLocal(BookKey, True);
    unit_Messages.BookLocalStatusChanged(BookKey, True);
    Result := True;
  end;
end;

procedure TDownloader.HTTPRedirect(Sender: TObject; var dest: string; var NumRedirect: Integer; var Handled: boolean; var VMethod: string);
begin
  if EndsText(FB2ZIP_EXTENSION, dest) then
    FNewURL := dest
  else
    FNewURL := '';
end;

procedure TDownloader.HTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
var
  ElapsedTime: Cardinal;
  Speed: string;
begin
  if FNoProgress then
    Exit;

  if Canceled then
  begin
    FidHTTP.Disconnect;
    Exit;
  end;

  if FDownloadSize <> 0 then
    FOnSetProgress(AWorkCount * 100 div FDownloadSize, -1);

  ElapsedTime := SecondsBetween(Now, FStartDate);
  if ElapsedTime > 0 then
  begin
    Speed := FormatFloat('0.00', AWorkCount / 1024 / ElapsedTime);
    FOnSetComment(Format(rstrSpeed, [Speed]), '');
  end;
end;

procedure TDownloader.HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  if FNoProgress then
    Exit;
  FDownloadSize := AWorkCountMax;
  FStartDate := Now;
  FOnSetProgress(1, -1);
end;

procedure TDownloader.HTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  if FNoProgress then
    Exit;
  FOnSetProgress(100, -1);
  FOnSetComment(rstrReadyMessage, '');
end;

function TDownloader.DoDownload(const Collection: IBookCollection; const BookRecord: TBookRecord): boolean;
var
  ctx: TRttiContext;
  ConstParams: TStringList;
  Commands: TScenarioCommands;
  field: TRttiField;
  data, name: string;
  i: Integer;

begin
  Result := True;

  try
    ctx := TRttiContext.Create;
    ConstParams := TStringList.Create;
    FParams := TIdMultiPartFormDataStream.Create;

    // Add macro from collection info
    ConstParams.Values['%USER%'] := Collection.GetProperty(PROP_LIBUSER);
    ConstParams.Values['%PASS%'] := Collection.GetProperty(PROP_LIBPASSWORD);
    ConstParams.Values['%URL%'] := Collection.GetProperty(PROP_URL);

    // Build macro dictionary from book info
    for field in ctx.GetType(TypeInfo(TBookRecord)).GetFields do
    begin
      if (nil <> field) and (nil <> field.FieldType) and
        (('string' = field.FieldType.Name) or ('Integer' = field.FieldType.Name))
      then
      begin
        name := '%' + UpperCase(field.Name) + '%';
        if ('%FOLDER%' = name) or ('%COLLECTIONROOT%' = name) then
          begin
            data := DosPathToUnixPath(field.GetValue(Addr(BookRecord)).ToString());
          end
        else
          data := field.GetValue(Addr(BookRecord)).ToString();

        ConstParams.Values[name] := data;
      end;
    end;

    // Execute scenario
    Commands := ParseCommands(Collection.GetProperty(PROP_CONNECTIONSCRIPT), ConstParams);
    try
      FResponse := TMemoryStream.Create;
      try
        for i := 0 to Length(Commands) - 1 do
        begin
          if Canceled then
            Break;

          case Commands[i].Code of
            0: Result := CheckResponce;
            1: Result := CheckRedirect;
            2: Result := Pause(StrToInt(Commands[i].Params[0]));
            3: Result := Query(qkGet, Commands[i].Params[0]);
            4: Result := Query(qkPost, Commands[i].Params[0]);
            5: Result := AddParam(Commands[i].Params[0], Commands[i].Params[1]);
          end;

          if not Result then
            Break;
        end;
      finally
        FResponse.Free;
      end;
    finally
      FParams.Free;
    end;

  finally
    ctx.Free;
    ConstParams.Free;
  end;
end;

function TDownloader.ParseCommands(const scenario: string; const macros: TStrings): TScenarioCommands;
var
  parameters: TStringList;
  commandStr: TStringList;
  data, command: string;
  commnadIndx: Integer;
  commnadType: Integer;
  index, param: Integer;
  Commands: TScenarioCommands;

begin

  try
    parameters := TStringList.Create;
    commandStr := TStringList.Create;

    // Parse each command in scenario
    commandStr.Text := scenario;
    SetLength(Commands, commandStr.Count);
    for commnadIndx := 0 to (commandStr.Count - 1) do
    begin
      Commands[commnadIndx].Code := -1;

      // Get command
      data := commandStr[commnadIndx];
      index := Pos(' ', data);
      if index <> 0 then
      begin
        command := Copy(data, 1, index - 1);
        Delete(data, 1, index);
      end
      else
        command := data;

      // Identify and process command
      for commnadType := 0 to (Length(CommandList) - 1) do
      begin
        if CommandList[commnadType] = command then
        begin
          Commands[commnadIndx].Code := commnadType;

          case commnadType of
            0 .. 1: // 'CHECK', 'REDIR'  - no parameters
              SetLength(Commands[commnadIndx].Params, 0);

            2: // 'PAUSE' - just one parameter
              begin
                SetLength(Commands[commnadIndx].Params, 1);
                Commands[commnadIndx].Params[0] := data;
              end;

            3 .. 4: // 'GET', 'POST' - just one parameter
              begin
                // Replace all macros
                for index := 0 to macros.Count - 1 do
                  StrReplace(macros.Names[index],
                    macros.ValueFromIndex[index], data);
                // Save parameter
                SetLength(Commands[commnadIndx].Params, 1);
                Commands[commnadIndx].Params[0] := data;
              end;

          else // ADD and etc. - space delimited parameters
            begin
              parameters.Clear();
              ExtractStrings([' '], [], PWideChar(data), parameters);
              SetLength(Commands[commnadIndx].Params, parameters.Count);
              for param := 0 to parameters.Count - 1 do
              begin
                data := parameters[param];
                // Replace all macros
                for index := 0 to macros.Count - 1 do
                  StrReplace(macros.Names[index],
                    macros.ValueFromIndex[index], data);
                // Save parameter
                Commands[commnadIndx].Params[param] := data;
              end;
            end;
          end;

          Break;
        end;
      end;
    end;

  Result := Commands;

  finally
    parameters.Free;
    commandStr.Free;
  end;
end;

function TDownloader.Pause(Time: Integer): boolean;
begin
  Sleep(Time);
  Result := True;
end;

procedure TDownloader.ProcessError(const LongMsg, ShortMsg, AFileName: string);
var
  F: Text;
  FileName: string;
begin
  if Settings.ErrorLog then
  begin
    FileName := Settings.SystemFileName[sfDownloadErrorLog];
    AssignFile(F, FileName);
    if FileExists(FileName) then
      Append(F)
    else
      Rewrite(F);
    Writeln(F, Format('%s %s >> %s', [DateTimeToStr(Now), ShortMsg,
      AFileName]));
    CloseFile(F);
  end;
  if not FIgnoreErrors then
    Application.MessageBox(PChar(LongMsg + {$IFDEF LINUX} AnsiChar(#10) {$ENDIF}
    {$IFDEF MSWINDOWS} AnsiString(CRLF) {$ENDIF} + URL), PChar(rstrDownloadError));
end;

function TDownloader.Query(Kind: TQueryKind; const Uri: string): boolean;
begin
  Result := False;

  URL := Uri;
  // Add result of last operation
  StrReplace('%RESURL%', FNewURL, URL);

  try
    case Kind of
      qkGet:
        begin
          FNoProgress := False;
          FidHTTP.Get(TIdURI.URLEncode(URL), FResponse);
        end;

      qkPost:
        begin
          FNoProgress := True;
          FidHTTP.Post(TIdURI.URLEncode(URL), FParams, FResponse);
        end;
    end;
    Result := True;
  except
    on E: EIdSocketError do
      if not FIgnoreErrors then
      begin
        case E.LastError of
          WSAHOST_NOT_FOUND:
            ProcessError(rstrServerNotFound,
              rstrError + IntToStr(E.LastError), FFile);

          Id_WSAETIMEDOUT:
            ProcessError(rstrTimeout, rstrError + IntToStr(E.LastError), FFile);
        else
          ProcessError(rstrConnectionError,
            rstrError + IntToStr(E.LastError), FFile);
        end; // case
      end;

    on E: Exception do
      if (FidHTTP.ResponseCode <> 405) and
        not((FidHTTP.ResponseCode = 404) and (FNewURL <> '')) then
        ProcessError(Format(rstrServerError, [E.Message]),
          rstrErrorCode + IntToStr(FidHTTP.ResponseCode), FFile)
      else
        Result := True;
  end; // try ... except
end;

procedure TDownloader.Stop;
begin
  try
    FidHTTP.Disconnect;
  except
    //
  end;
end;

end.
