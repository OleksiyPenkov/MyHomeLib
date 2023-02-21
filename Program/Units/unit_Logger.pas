(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov (nrymanov@gmail.com)
  * Created             31.08.2010
  * Description         Базовая поддержка записи сообщений в лог-файл
  *
  * $Id: unit_Logger.pas 1064 2011-09-02 11:33:04Z eg_ $
  *
  * History
  *
  ****************************************************************************** *)

unit unit_Logger;

interface

{$IFDEF USELOGGER}

uses
  unit_Interfaces;

function GetLogger: ILogger;
function GetIntervalLogger(const intervalName: string; const extraInfo: string): IIntervalLogger;
function GetScopeLogger(const scopeName: string; const extraInfo: string = ''): IScopeLogger;

{$ENDIF}

implementation

{$IFDEF USELOGGER}

uses
  Windows,
  SysUtils,
  IOUtils,
  TimeSpan,
  Diagnostics,
  Forms,
  unit_Consts;

type
  TGlobalLogger = class
  private
    class constructor Create;
    class destructor Destroy;

    class procedure Log(const logMessage: string; const extraInfo: string = ''); overload;
    class procedure Log(const logMessage: string; const extraInfo: string; Elapsed: TTimeSpan); overload;

  private
    class var
      FLogFileName: string;
      FLogFile: THandle;
  end;

  TLoggerImpl = class(TInterfacedObject, ILogger)
  protected
    //
    // ILogger
    //
    procedure Log(const logMessage: string; const extraInfo: string);
  end;

  TIntervalLoggerImpl = class(TLoggerImpl, IIntervalLogger)
  private
    constructor Create(const intervalName: string; const extraInfo: string);
    destructor Destroy; override;

  protected
    //
    // IIntervalLogger
    //
    procedure Restart(const extraInfo: string);

  private
    FIntervalName: string;
    FExtraInfo: string;
    FStopwatch: TStopwatch;
  end;

  TScopeLoggerImpl = class(TIntervalLoggerImpl, IScopeLogger)
  private
    constructor Create(const scopeName: string; const extraInfo: string);
    destructor Destroy; override;

  protected
    //
    // IScopeLogger
    //

  private
    FScopeName: string;
  end;

{ TGlobalLogger }

class constructor TGlobalLogger.Create;
begin
{$IFOPT D+}
  FLogFileName := TPath.ChangeExtension(Application.ExeName, 'log');
{$ELSE}
  FLogFileName := TPath.Combine(TPath.GetTempPath, TPath.GetFileName(TPath.ChangeExtension(Application.ExeName, 'log')));
{$ENDIF}

  FLogFile := Integer(CreateFile(
    PChar(FLogFileName),
    GENERIC_WRITE,
    FILE_SHARE_READ,
    nil,
    CREATE_ALWAYS,
    FILE_ATTRIBUTE_NORMAL,
    FILE_FLAG_WRITE_THROUGH
  ));
end;

class destructor TGlobalLogger.Destroy;
begin
  CloseHandle(FLogFile);
end;

class procedure TGlobalLogger.Log(const logMessage, extraInfo: string);
begin
  Log(logMessage, extraInfo, TTimeSpan.Zero);
end;

class procedure TGlobalLogger.Log(const logMessage, extraInfo: string; Elapsed: TTimeSpan);
var
  logString: AnsiString;
  bytesWritten: Longword;
begin
  logString := AnsiString(Format('%s; %s; %s; %s' + CRLF,
    [
      FormatDateTime('c', Now),
      Format('%.2d:%.2d:%.2d.%.3d', [Elapsed.Hours, Elapsed.Minutes, Elapsed.Seconds, Elapsed.Milliseconds]),
      Trim(logMessage),
      Trim(extraInfo)
    ]));

  WriteFile(FLogFile, PAnsiChar(logString)^, Length(logString), bytesWritten, nil);
end;

{ TLoggerImpl }

procedure TLoggerImpl.Log(const logMessage, extraInfo: string);
begin
  TGlobalLogger.Log(logMessage, extraInfo);
end;

{ TIntervalLoggerImpl }

constructor TIntervalLoggerImpl.Create(const intervalName: string; const extraInfo: string);
begin
  inherited Create;
  FIntervalName := intervalName;
  FExtraInfo := extraInfo;
  FStopwatch := TStopwatch.StartNew;
end;

destructor TIntervalLoggerImpl.Destroy;
begin
  FStopwatch.Stop;
  TGlobalLogger.Log(FIntervalName, FExtraInfo, FStopwatch.Elapsed);
  inherited;
end;

procedure TIntervalLoggerImpl.Restart(const extraInfo: string);
begin
  FStopwatch.Stop;
  TGlobalLogger.Log(FIntervalName, FExtraInfo, FStopwatch.Elapsed);
  FExtraInfo := extraInfo;
  FStopwatch := TStopwatch.StartNew;
end;

{ TScopeLoggerImpl }

constructor TScopeLoggerImpl.Create(const scopeName: string; const extraInfo: string);
begin
  inherited Create(scopeName, extraInfo);
  FScopeName := scopeName;
  TGlobalLogger.Log(FScopeName, '>>>>>>>>>>>>>> - enter');
end;

destructor TScopeLoggerImpl.Destroy;
begin
  TGlobalLogger.Log(FScopeName, '<<<<<<<<<<<<<< - exit');
  inherited;
end;

function GetLogger: ILogger;
begin
  Result := TLoggerImpl.Create;
end;

function GetIntervalLogger(const intervalName: string; const extraInfo: string): IIntervalLogger;
begin
  Result := TIntervalLoggerImpl.Create(intervalName, extraInfo);
end;

function GetScopeLogger(const scopeName: string; const extraInfo: string): IScopeLogger;
begin
  Result := TScopeLoggerImpl.Create(scopeName, extraInfo);
end;

{$ENDIF}

end.
