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
  System.Net.HttpClient;

type
  TframeNCWDownload = class(TInteriorPageBase)
    lblStatus: TLabel;
    Bar: TProgressBar;

  private
    FHTTPClient: THTTPClient;
    FStartDate: TDateTime;
    FTerminated: Boolean;
    procedure HTTPReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var AAbort: Boolean);

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
  unit_MHLHttpClient;

resourcestring
  rstrConnecting = 'Підключення...';
  rstrSpeed = 'Завантажено %d із %d кб (%n кб/с)';
  rstrDownloadComplete = 'Завантаження завершено';

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

  FHTTPClient := CreateHTTPClientUpdate;
  try
    FHTTPClient.OnReceiveData := HTTPReceiveData;
    FStartDate := Now;

    Response := TFileStream.Create(FPParams^.INPXFile, fmCreate);
    try
      FHTTPClient.Get(FPParams^.INPXUrl, Response);
      if not FTerminated then
      begin
        FPParams^.Operation := otInpx;
        Result := True;
      end;
    finally
      Response.Free;
    end;
  finally
    FreeAndNil(FHTTPClient);
  end;
end;

procedure TframeNCWDownload.HTTPReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var AAbort: Boolean);
var
  ElapsedTime: Cardinal;
  KB: Int64;
begin
  if FTerminated then
  begin
    AAbort := True;
    Exit;
  end;

  KB := AReadCount div 1024;

  if AContentLength > 0 then
    Bar.Position := AReadCount * 100 div AContentLength;

  ElapsedTime := SecondsBetween(Now, FStartDate);
  if ElapsedTime > 0 then
    lblStatus.Caption := Format(rstrSpeed, [KB, AContentLength div 1024, KB / ElapsedTime]);

  Application.ProcessMessages;
end;

procedure TframeNCWDownload.Stop;
begin
  FTerminated := True;
end;

end.
