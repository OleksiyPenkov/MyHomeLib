(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Oleksiy Penkov  oleksiy.penkov@gmail.com
  * Created             12.02.2010
  * Description
  *
  * $Id: unit_Lib_Updates.pas 1181 2015-04-01 02:06:36Z koreec $
  *
  * History
  * NickR 15.02.2010    Код переформатирован
  *
  ****************************************************************************** *)

unit unit_Lib_Updates;

interface

uses
  Windows,
  Classes,
  SysUtils,
  IdHTTP,
  IdSocks,
  IdSSLOpenSSL;

type
  TUpdateInfo = class(TCollectionItem)
  private
    FName: string;
    FURL: string;
    FVersionFile: string;
    FUpdateFile: string;
    FFull: Boolean;
    FCode: Integer;

    //
    // Временные поля
    //
    FExternalVersion: Integer;
    FCollectionID: Integer;
    FAvailable: Boolean;
    FLocal: Boolean;

    function GetURL: string;

  public
    function CheckCodes(const Name: string; t, id: Integer): Boolean;
    function CheckVersion(const Path: string; CurrentVersion: Integer): Boolean;

    property Name: string read FName;
    property URL: string read GetURL;
    property UpdateFile: string read FUpdateFile;
    property Full: Boolean read FFull write FFull;
    property Code: Integer read FCode write FCode;

    property CollectionID: Integer read FCollectionID;
    property ExternalVersion: Integer read FExternalVersion;
    property Available: Boolean read FAvailable;
    property Local: Boolean read FLocal;
  end;

  TUpdateInfoList = class(TCollection)
  private
    FURL: string;
    FPath: string;

    function GetUpdate(Index: Integer): TUpdateInfo;
    procedure SetUpdate(Index: Integer; const Value: TUpdateInfo);

    procedure SetURL(const Value: string);

    function AddUpdate: TUpdateInfo;

  public
    constructor Create;

    procedure Add(
      const Name: string;
      const URL: string;
      const VerFile: string;
      const UpdateFile: string;
      const Full: Boolean;
      const Code: Integer
    );

    procedure UpdateExternalVersions;

    function DownloadUpdate(Index: Integer; HTTP: TidHTTP): Boolean;

    property Items[Index: Integer]: TUpdateInfo read GetUpdate write SetUpdate; default;
    property URL: string read FURL write SetURL;
    property Path: string read FPath write FPath;
  end;

implementation

uses
  unit_Globals;

{ TUpdateInfoList }

procedure TUpdateInfoList.Add(
  const Name: string;
  const URL: string;
  const VerFile: string;
  const UpdateFile: string;
  const Full: Boolean;
  const Code: Integer
);
var
  Update: TUpdateInfo;
begin
  BeginUpdate;
  try
    Update := AddUpdate;
    try
      Update.FName := Name;
      Update.FURL := FURL;
      Update.FVersionFile := VerFile;
      Update.FUpdateFile := UpdateFile;
      Update.FCode := Code;
      Update.FFull := Full;
    except
      Update.Free;
      raise ;
    end;
  finally
    EndUpdate;
  end;
end;

function TUpdateInfoList.AddUpdate: TUpdateInfo;
begin
  Result := TUpdateInfo(inherited Add);
end;

procedure TUpdateInfoList.UpdateExternalVersions;
var
  HTTP: TidHTTP;
  IdSocksInfo: TIdSocksInfo;
  IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
  LF: TMemoryStream;
  SL: TStringList;
  i: Integer;
  URL: string;
begin
  LF := TMemoryStream.Create;
  try
    HTTP := TidHTTP.Create(nil);
    IdSocksInfo := TIdSocksInfo.Create(nil);
    IdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    try
      SetProxySettingsUpdate(HTTP, IdSocksInfo, IdSSLIOHandlerSocketOpenSSL);

      for i := 0 to Count - 1 do
      begin
        if Items[i].FVersionFile = '' then
          Continue;

        URL := Items[i].URL + Items[i].FVersionFile;

        try
          LF.Clear;
          HTTP.Get(URL, LF);
          SL := TStringList.Create;
          try
            LF.Seek(0, soFromBeginning);
            SL.LoadFromStream(LF);
            if SL.Count > 0 then
              Items[i].FExternalVersion := StrToInt(SL[0]);

            //SL.SaveToFile('E:\Temp\out.txt');
          finally
            SL.Free;
          end;
        except
        end;
      end; // for
    finally
      IdSSLIOHandlerSocketOpenSSL.Free;
      IdSocksInfo.Free;
      HTTP.Free;
    end;
  finally
    LF.Free;
  end;
end;

constructor TUpdateInfoList.Create;
begin
  inherited Create(TUpdateInfo);
end;

function TUpdateInfoList.DownloadUpdate(Index: Integer; HTTP: TidHTTP): Boolean;
var
  MS: TMemoryStream;
  URL: string;
  FileName: string;
begin
  Result := False;

  if Items[Index].URL = '' then
    URL := FURL + Items[Index].FUpdateFile
  else
    URL := Items[Index].URL + Items[Index].FUpdateFile;
  FileName := FPath + Items[Index].FUpdateFile;

  MS := TMemoryStream.Create;
  try
    try
      HTTP.Get(URL, MS);
      MS.SaveToFile(FileName);
      Result := True;
    except
    end;
  finally
    MS.Free;
  end;
end;

function TUpdateInfoList.GetUpdate(Index: Integer): TUpdateInfo;
begin
  Result := TUpdateInfo( inherited Items[Index]);
end;

procedure TUpdateInfoList.SetUpdate(Index: Integer; const Value: TUpdateInfo);
begin
  inherited Items[Index] := Value;
end;

procedure TUpdateInfoList.SetURL(const Value: string);
begin
  FURL := IncludeUrlSlash(Value);
end;

{ TUpdateInfo }

function TUpdateInfo.CheckCodes(const Name: string; t, id: Integer): Boolean;
begin
  Result := (t = FCode) and (Name = FName);
  if Result then
    FCollectionID := id;
end;

function TUpdateInfo.CheckVersion(const Path: string; CurrentVersion: Integer): Boolean;
begin
  FLocal := FileExists(Path + UpdateFile);
  if FLocal then
    Result := True
  else
    Result := (FExternalVersion > CurrentVersion);
  FAvailable := Result;
end;

function TUpdateInfo.GetURL: string;
begin
  if FURL = '' then
    Result := (Collection as TUpdateInfoList).FURL
  else
    Result := FURL;
end;

end.
