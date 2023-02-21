{******************************************************************************}
{                                                                              }
{ MyHomeLib                                                                    }
{                                                                              }
{ Version 0.9                                                                  }
{ 20.08.2008                                                                   }
{ Copyright (c) Oleksiy Penkov  oleksiy.penkov@gmail.com                          }
{                                                                              }
{ @author Nick Rymanov nrymanov@gmail.com                                      }
{                                                                              }
{******************************************************************************}

unit frame_NCWDownload;

interface

uses
  Windows,
  Messages,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  frame_InteriorPageBase,
  StdCtrls,
  ExtCtrls,
  ComCtrls,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdSocks,
  IdSSLOpenSSL, IdCustomTransparentProxy, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL;

type
  TframeNCWDownload = class(TInteriorPageBase)
    HTTP: TIdHTTP;

    lblStatus: TLabel;
    Bar: TProgressBar;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    IdSocksInfo: TIdSocksInfo;

    procedure HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure HTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure HTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);

  private
    FDownloadSize : Int64;
    FStartDate : TDateTime;
    FTerminated: Boolean;

  public
    function Activate(LoadData: Boolean): Boolean; override;
    function Deactivate(CheckData: Boolean): Boolean; override;

    function Download: Boolean;
    procedure Stop;
  end;

var
  frameNCWDownload: TframeNCWDownload;

implementation

uses
  SysUtils,
  DateUtils,
  unit_NCWParams,
  unit_Globals;

resourcestring
  rstrConnecting = 'Подключение ...';
  rstrSpeed = 'Загружено %d из %d кб (%n кб/с)';
  rstrDownloadComplete = 'Загрузка завершена';

{$R *.dfm}

{ TframeNCWDownload }

function TframeNCWDownload.Activate(LoadData: Boolean): Boolean;
begin
  Assert(FPParams^.Operation = otInpxDownload);

  lblStatus.Caption := rstrConnecting;
  Bar.Position := 0;

  Result := True;
end;

function TframeNCWDownload.Deactivate(CheckData: Boolean): Boolean;
begin
  Result := True;
end;

function TframeNCWDownload.Download: Boolean;
var
  Response: TFileStream;
begin
  Result := False;
  FTerminated := False;

  Response := TFileStream.Create(FPParams^.INPXFile, fmCreate);
  try
    SetProxySettingsUpdate(HTTP, IdSocksInfo, IdSSLIOHandlerSocketOpenSSL);
    HTTP.Get(FPParams^.INPXUrl, Response);
    if not FTerminated then
    begin
      FPParams^.Operation := otInpx;
      Result := True;
    end;
  finally
    Response.Free;
  end;
end;

procedure TframeNCWDownload.HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  Bar.Position := 0;
  FDownloadSize := AWorkCountMax;
  FStartDate := Now;
end;

procedure TframeNCWDownload.HTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
var
  ElapsedTime: Cardinal;
  KB : Int64;
begin
  KB := AWorkCount div 1024;

  if FDownloadSize <> 0 then
    Bar.Position := AWorkCount * 100 div FDownloadSize;

  ElapsedTime := SecondsBetween(Now, FStartDate);
  if ElapsedTime > 0 then
  begin
    { TODO -oNickR -cRefactoring : создать и использовать во всех подобных местах FormatSize функцию }
    lblStatus.Caption := Format(
      rstrSpeed,
      [KB, FDownloadSize div 1024, KB / ElapsedTime]
    );
  end;
  Application.ProcessMessages;
end;

procedure TframeNCWDownload.HTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  lblStatus.Caption := rstrDownloadComplete;
  Application.ProcessMessages;
end;

procedure TframeNCWDownload.Stop;
begin
  try
    FTerminated := True;
    HTTP.Disconnect;
  except
    //
  end;
end;

end.
