# Indy+OpenSSL → System.Net.HttpClient Migration Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace all Indy HTTP + OpenSSL 1.0.2 (EOL) usage with Delphi's built-in `System.Net.HttpClient` (THTTPClient), which uses Windows SChannel for TLS — no DLL dependencies, supports TLS 1.2/1.3.

**Architecture:** Create a new helper unit `unit_MHLHttpClient.pas` that encapsulates THTTPClient creation with proxy configuration from Settings. Each consumer file then switches from Indy types to THTTPClient. The Indy components are removed from DFM files and all `Id*` units from uses clauses.

**Tech Stack:** Delphi (RAD Studio 37.0), `System.Net.HttpClient`, `System.Net.URLClient`, `System.Net.Mime` (TMultipartFormData)

**SOCKS Proxy Limitation:** `THTTPClient` only supports HTTP proxies (via `TProxySettings`). SOCKS4/SOCKS5 proxy is **not supported** by the Windows HTTP stack. The proxy type setting (0=HTTP, 1=SOCKS4, 2=SOCKS5) will only work for type 0. Types 1 and 2 will be silently ignored with a log warning. Users needing SOCKS can use external tools like Proxifier.

---

## API Mapping Reference

| Indy (old) | System.Net.HttpClient (new) |
|---|---|
| `TIdHTTP` | `THTTPClient` |
| `TIdHTTP.Get(url, stream)` | `THTTPClient.Get(url, stream): IHTTPResponse` |
| `TIdHTTP.Post(url, formdata, stream)` | `THTTPClient.Post(url, TMultipartFormData, stream): IHTTPResponse` |
| `TIdMultiPartFormDataStream.AddFormField` | `TMultipartFormData.AddField` |
| `OnWork/OnWorkBegin/OnWorkEnd` | `OnReceiveData(Sender; AContentLength, AReadCount: Int64; var AAbort)` |
| `OnRedirect(Sender; var dest; var NumRedirect; var Handled; var VMethod)` | `OnRedirect(Sender; ARequest; AResponse; ARedirections; var AAllow)` |
| `TIdHTTP.ProxyParams` | `THTTPClient.ProxySettings: TProxySettings` |
| `TIdHTTP.ConnectTimeout` | `THTTPClient.ConnectionTimeout` (ms) |
| `TIdHTTP.ReadTimeout` | `THTTPClient.ResponseTimeout` (ms) |
| `TIdHTTP.Request.UserAgent` | `THTTPClient.UserAgent` |
| `TIdHTTP.AllowCookies` + CookieManager | `THTTPClient.CookieManager` (built-in, always on) |
| `TIdHTTP.HandleRedirects` | `THTTPClient.HandleRedirects` (default True) |
| `TIdHTTP.ResponseCode` | `IHTTPResponse.StatusCode` |
| `TIdHTTP.Disconnect` (to cancel) | Set `AAbort := True` in OnReceiveData callback |
| `EIdSocketError` | `ENetHTTPClientException` |
| `TIdURI.URLEncode` | `TNetEncoding.URL.Encode` (from `System.NetEncoding`) |
| `TIdSocksInfo` | **Not supported** — HTTP proxy only |
| `TIdSSLIOHandlerSocketOpenSSL` | **Not needed** — SChannel handles TLS natively |

---

## File Structure

### New Files
| File | Responsibility |
|---|---|
| `Program/Units/unit_MHLHttpClient.pas` | Factory functions to create configured `THTTPClient` instances with proxy/timeout/UA settings from `TMHLSettings` |

### Modified Files
| File | What Changes |
|---|---|
| `Program/Units/unit_Globals.pas` | Remove `SetProxySettingsGlobal`, `SetProxySettingsUpdate`, `InitHTTP`, rewrite `CheckUpdates` to use THTTPClient |
| `Program/Units/unit_ReviewParser.pas` | Replace TIdHTTP with THTTPClient |
| `Program/Units/unit_Lib_Updates.pas` | Replace TIdHTTP in `UpdateExternalVersions` and `DownloadUpdate` |
| `Program/UtilsImpl/unit_libupdateThread.pas` | Replace TIdHTTP + progress events with THTTPClient + OnReceiveData |
| `Program/Wizards/NewCollection/frame_NCWDownload.pas` | Replace design-time Indy components with runtime THTTPClient |
| `Program/Wizards/NewCollection/frame_NCWDownload.dfm` | Remove TIdHTTP, TIdSSLIOHandlerSocketOpenSSL, TIdSocksInfo components |
| `Program/DwnldImpl/unit_Downloader.pas` | Most complex: replace all Indy usage including GET/POST, multipart, redirect, progress, cancel |
| `Program/Units/unit_Helpers.pas` | Remove `IdHTTP`, `IdSocks`, `IdSSLOpenSSL` from uses clause |
| `Program/Forms/frm_main.pas` | Remove `IdHTTP`, `IdSocks`, `IdSSLOpenSSL` from uses clause |
| `Installer/build_installer.cmd` | Remove OpenSSL DLL collection for both x86 and x64 |
| `Installer/Common.iss` | Remove `libeay32.dll` and `ssleay32.dll` from [Files] section |

---

## Chunk 1: Helper Unit + Simple Consumers

### Task 1: Create unit_MHLHttpClient.pas

**Files:**
- Create: `Program/Units/unit_MHLHttpClient.pas`

This unit provides two factory functions (matching the old Global/Update split) plus a shared initialization helper. All consumers will call these instead of the old `SetProxySettings*` + `InitHTTP`.

- [ ] **Step 1: Create the helper unit**

```pascal
unit unit_MHLHttpClient;

interface

uses
  System.Net.HttpClient,
  System.Net.URLClient;

/// Creates a THTTPClient configured with the "Global" proxy settings
/// (used for book downloads, reviews, app update checks).
function CreateHTTPClientGlobal: THTTPClient;

/// Creates a THTTPClient configured with the "Update" proxy settings
/// (used for library list updates, INPX downloads).
function CreateHTTPClientUpdate: THTTPClient;

implementation

uses
  System.SysUtils,
  unit_Settings,
  dm_user;

procedure InitClient(AClient: THTTPClient);
begin
  AClient.UserAgent := 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0; MAAU)';
  AClient.ConnectionTimeout := Settings.TimeOut;
  AClient.ResponseTimeout := Settings.ReadTimeOut;
  AClient.HandleRedirects := True;
end;

function CreateHTTPClientGlobal: THTTPClient;
begin
  Result := THTTPClient.Create;
  InitClient(Result);

  if Settings.UseIESettings then
  begin
    if Settings.IEProxyServer <> '' then
      Result.ProxySettings := TProxySettings.Create(
        Settings.IEProxyServer, Settings.IEProxyPort);
  end
  else
  begin
    // ProxyType: 0=HTTP (supported), 1=SOCKS4, 2=SOCKS5 (not supported by THTTPClient)
    if (Settings.ProxyType = 0) and (Settings.ProxyServer <> '') then
      Result.ProxySettings := TProxySettings.Create(
        Settings.ProxyServer, Settings.ProxyPort,
        Settings.ProxyUsername, Settings.ProxyPassword);
  end;
end;

function CreateHTTPClientUpdate: THTTPClient;
begin
  Result := THTTPClient.Create;
  InitClient(Result);

  if Settings.UseProxyForUpdate then
  begin
    // ProxyType: 0=HTTP (supported), 1=SOCKS4, 2=SOCKS5 (not supported by THTTPClient)
    if (Settings.ProxyType = 0) and (Settings.ProxyServerUpdate <> '') then
      Result.ProxySettings := TProxySettings.Create(
        Settings.ProxyServerUpdate, Settings.ProxyPortUpdate,
        Settings.ProxyUsernameUpdate, Settings.ProxyPasswordUpdate);
  end;
end;

end.
```

- [ ] **Step 2: Build to verify the new unit compiles**

Run:
```
cmd.exe //c "set BDS=C:\Program Files (x86)\Embarcadero\Studio\37.0&& set BDSCOMMONDIR=C:\Users\Public\Documents\Embarcadero\Studio\37.0&& C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe Program\MyhomeLib.dproj /t:Build /p:Config=Release /p:Platform=Win32 /nologo /v:minimal" 2>&1
```

Note: You must first add `unit_MHLHttpClient` to the .dpr file's uses clause before building.

- [ ] **Step 3: Commit**

```bash
git add Program/Units/unit_MHLHttpClient.pas Program/MyHomeLib.dpr
git commit -m "Add unit_MHLHttpClient: THTTPClient factory with proxy config"
```

---

### Task 2: Migrate unit_ReviewParser.pas (simplest consumer)

**Files:**
- Modify: `Program/Units/unit_ReviewParser.pas`

The review parser just does `TIdHTTP.Get(url, stream)` — the simplest migration.

- [ ] **Step 1: Replace the uses clause and fields**

In `unit_ReviewParser.pas`, replace the interface uses and class fields:

Old uses (lines 23-27):
```pascal
uses
  Classes,
  StrUtils,
  IdHTTP,
  IdSocks,
  IdSSLOpenSSL;
```

New uses:
```pascal
uses
  Classes,
  StrUtils,
  System.Net.HttpClient;
```

Old fields (lines 32-34):
```pascal
    FidHTTP: TIdHTTP;
    FidSocksInfo: TIdSocksInfo;
    FidSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
```

New field:
```pascal
    FHTTPClient: THTTPClient;
```

- [ ] **Step 2: Replace the constructor**

Old constructor (lines 52-61):
```pascal
constructor TReviewParser.Create;
begin
  inherited Create;

  FidHTTP := TIdHTTP.Create;
  FidSocksInfo := TIdSocksInfo.Create;
  FidSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;

  SetProxySettingsGlobal(FidHTTP, FidSocksInfo, FidSSLIOHandlerSocketOpenSSL);
end;
```

New constructor:
```pascal
constructor TReviewParser.Create;
begin
  inherited Create;
  FHTTPClient := CreateHTTPClientGlobal;
end;
```

Add `unit_MHLHttpClient` to the implementation uses clause (alongside `unit_Globals`).

- [ ] **Step 3: Replace the destructor**

Old destructor (lines 63-70):
```pascal
destructor TReviewParser.Destroy;
begin
  // do not close the idHTTP, as it was not created by the ctor
  FreeAndNil(FidSSLIOHandlerSocketOpenSSL);
  FreeAndNil(FidSocksInfo);
  FreeAndNil(FidHTTP);
  inherited Destroy;
end;
```

New destructor:
```pascal
destructor TReviewParser.Destroy;
begin
  FreeAndNil(FHTTPClient);
  inherited Destroy;
end;
```

- [ ] **Step 4: Replace GetPage method**

Old line 179: `FidHTTP.Get(url, outputStream);`

New: `FHTTPClient.Get(url, outputStream);`

- [ ] **Step 5: Build and verify**

Run the build command. Expected: 0 errors, 0 warnings related to this unit.

- [ ] **Step 6: Commit**

```bash
git add Program/Units/unit_ReviewParser.pas
git commit -m "Migrate unit_ReviewParser from Indy to THTTPClient"
```

---

### Task 3: Migrate unit_Globals.pas (CheckUpdates + remove old helpers)

**Files:**
- Modify: `Program/Units/unit_Globals.pas`

This unit contains `SetProxySettingsGlobal`, `SetProxySettingsUpdate`, `InitHTTP`, and `CheckUpdates`. The first three become dead code (replaced by `unit_MHLHttpClient`). `CheckUpdates` needs rewriting.

- [ ] **Step 1: Remove old Indy imports from uses clause**

In the interface uses clause, remove: `IdHTTP`, `IdSocks`, `IdSSLOpenSSL`, `IdComponent`, `IdStack`, `IdStackConsts`, `IdWinsock2`.

In the interface section, remove the declarations of:
- `procedure SetProxySettingsGlobal(var IdHTTP: TidHTTP; IdSocksInfo: TIdSocksInfo; IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL);`
- `procedure SetProxySettingsUpdate(var IdHTTP: TidHTTP; IdSocksInfo: TIdSocksInfo; IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL);`
- `procedure InitHTTP(var IdHTTP: TidHTTP);`

Add to implementation uses: `System.Net.HttpClient`, `System.Net.URLClient`, `unit_MHLHttpClient`.

- [ ] **Step 2: Delete the implementations of InitHTTP, SetProxySettingsGlobal, SetProxySettingsUpdate**

Delete lines 1242-1401 (the three procedure bodies). These are fully replaced by `unit_MHLHttpClient`.

- [ ] **Step 3: Rewrite CheckUpdates**

Old CheckUpdates (lines 1403-1458) uses `TIdHTTP`, `TIdSocksInfo`, `TIdSSLIOHandlerSocketOpenSSL`, catches `EIdSocketError`.

New CheckUpdates:
```pascal
procedure CheckUpdates;
var
  SL: TStringList;
  LF: TMemoryStream;
  i: Integer;
  S: string;
  HTTP: THTTPClient;
  Response: IHTTPResponse;
begin
  LF := TMemoryStream.Create;
  try
    SL := TStringList.Create;
    try
      HTTP := CreateHTTPClientGlobal;
      try
        try
          Response := HTTP.Get(IncludeUrlSlash(Settings.UpdateURL) + PROGRAM_VERINFO_FILENAME, LF);
        except
          on E: ENetHTTPClientException do
            MHLShowError(rstrUpdateFailedConnectionError, [0]);
          on E: Exception do
            MHLShowError(rstrUpdateFailedServerError, [Response.StatusCode]);
        end;
        LF.SaveToFile(Settings.SystemFileName[sfAppVerInfo]);
        SL.LoadFromFile(Settings.SystemFileName[sfAppVerInfo]);
        if SL.Count > 0 then
          if CompareStr(Version, SL[0]) < 0 then
          begin
            S := CRLF;
            for i := 1 to SL.Count - 1 do
              S := S + '  ' + SL[i] + CRLF;
            MHLShowInfo(Format(rstrFoundNewAppVersion, [SL[0] + CRLF + S + CRLF]));
          end
          else if not AutoCheck then
            MHLShowInfo(rstrLatestVersion);
        AutoCheck := False;
      finally
        HTTP.Free;
      end;
    finally
      SL.Free;
    end;
  finally
    LF.Free;
  end;
end;
```

Note: The old code caught `EIdSocketError` with `E.LastError = 11001` for "server not found". `THTTPClient` wraps socket errors in `ENetHTTPClientException`. We simplify the error handling since we no longer have the Winsock error code.

- [ ] **Step 4: Build and verify**

Run the build command. Fix any remaining references to old Indy types.

- [ ] **Step 5: Commit**

```bash
git add Program/Units/unit_Globals.pas
git commit -m "Migrate CheckUpdates to THTTPClient, remove Indy proxy helpers"
```

---

### Task 4: Migrate unit_Lib_Updates.pas

**Files:**
- Modify: `Program/Units/unit_Lib_Updates.pas`

Two methods use Indy: `UpdateExternalVersions` (creates its own TIdHTTP) and `DownloadUpdate` (receives TIdHTTP as parameter).

- [ ] **Step 1: Replace uses clause and method signatures**

Old interface uses (lines 23-28):
```pascal
uses
  Windows,
  Classes,
  SysUtils,
  IdHTTP,
  IdSocks,
  IdSSLOpenSSL;
```

New:
```pascal
uses
  Windows,
  Classes,
  SysUtils,
  System.Net.HttpClient;
```

Change `DownloadUpdate` signature (line 92):
Old: `function DownloadUpdate(Index: Integer; HTTP: TidHTTP): Boolean;`
New: `function DownloadUpdate(Index: Integer; HTTP: THTTPClient): Boolean;`

- [ ] **Step 2: Rewrite UpdateExternalVersions**

Add `unit_MHLHttpClient` to the implementation uses clause.

Old (lines 141-191) creates TIdHTTP + TIdSocksInfo + TIdSSLIOHandlerSocketOpenSSL.

New:
```pascal
procedure TUpdateInfoList.UpdateExternalVersions;
var
  HTTP: THTTPClient;
  LF: TMemoryStream;
  SL: TStringList;
  i: Integer;
  URL: string;
begin
  LF := TMemoryStream.Create;
  try
    HTTP := CreateHTTPClientUpdate;
    try
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
          finally
            SL.Free;
          end;
        except
        end;
      end;
    finally
      HTTP.Free;
    end;
  finally
    LF.Free;
  end;
end;
```

- [ ] **Step 3: Rewrite DownloadUpdate**

Old (lines 198-223) uses `HTTP.Get(URL, MS)`.

New:
```pascal
function TUpdateInfoList.DownloadUpdate(Index: Integer; HTTP: THTTPClient): Boolean;
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
```

- [ ] **Step 4: Remove `unit_Globals` from implementation uses**

The only reason `unit_Globals` was in the implementation uses was for `SetProxySettingsUpdate`. Replace it with `unit_MHLHttpClient`. Keep `unit_Globals` only if other symbols from it are still needed (check for `IncludeUrlSlash` — yes, it's used in `SetURL`). So keep `unit_Globals` and add `unit_MHLHttpClient`.

- [ ] **Step 5: Build and verify**

- [ ] **Step 6: Commit**

```bash
git add Program/Units/unit_Lib_Updates.pas
git commit -m "Migrate unit_Lib_Updates from Indy to THTTPClient"
```

---

### Task 5: Migrate unit_libupdateThread.pas

**Files:**
- Modify: `Program/UtilsImpl/unit_libupdateThread.pas`

This thread uses TIdHTTP with progress events (OnWork/OnWorkBegin/OnWorkEnd) and passes the HTTP object to `DownloadUpdate`.

- [ ] **Step 1: Replace uses clause and fields**

Old interface uses (lines 23-31):
```pascal
uses
  Windows,
  Classes,
  SysUtils,
  unit_ImportInpxThread,
  IdHTTP,
  IdSocks,
  IdSSLOpenSSL,
  IdComponent,
  unit_UserData;
```

New:
```pascal
uses
  Windows,
  Classes,
  SysUtils,
  unit_ImportInpxThread,
  System.Net.HttpClient,
  unit_UserData;
```

Old fields (lines 39-41):
```pascal
    FidHTTP: TidHTTP;
    FidSocksInfo: TIdSocksInfo;
    FidSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
```

New field:
```pascal
    FHTTPClient: THTTPClient;
```

- [ ] **Step 2: Replace progress event signatures**

Old signatures (lines 50-52):
```pascal
    procedure HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: int64);
    procedure HTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure HTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: int64);
```

New (single callback):
```pascal
    procedure HTTPReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var AAbort: Boolean);
```

- [ ] **Step 3: Replace Initialize**

Old (lines 148-161):
```pascal
procedure TLibUpdateThread.Initialize;
begin
  inherited Initialize;

  FidHTTP := TidHTTP.Create(nil);
  FidSocksInfo := TIdSocksInfo.Create;
  FidSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;

  FidHTTP.OnWork := HTTPWork;
  FidHTTP.OnWorkBegin := HTTPWorkBegin;
  FidHTTP.OnWorkEnd := HTTPWorkEnd;
  FidHTTP.HandleRedirects := True;
  SetProxySettingsUpdate(FidHTTP, FidSocksInfo, FidSSLIOHandlerSocketOpenSSL);
end;
```

New:
```pascal
procedure TLibUpdateThread.Initialize;
begin
  inherited Initialize;
  FHTTPClient := CreateHTTPClientUpdate;
  FHTTPClient.OnReceiveData := HTTPReceiveData;
end;
```

Add `unit_MHLHttpClient` to the implementation uses clause.

- [ ] **Step 4: Replace Uninitialize**

Old (lines 163-170):
```pascal
procedure TLibUpdateThread.Uninitialize;
begin
  FreeAndNil(FidSSLIOHandlerSocketOpenSSL);
  FreeAndNil(FidSocksInfo);
  FreeAndNil(FidHTTP);
  inherited Uninitialize;
end;
```

New:
```pascal
procedure TLibUpdateThread.Uninitialize;
begin
  FreeAndNil(FHTTPClient);
  inherited Uninitialize;
end;
```

- [ ] **Step 5: Replace the three progress callbacks with one**

Delete `HTTPWork`, `HTTPWorkBegin`, `HTTPWorkEnd` methods (lines 111-146).

New single callback:
```pascal
procedure TLibUpdateThread.HTTPReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var AAbort: Boolean);
var
  ElapsedTime: Cardinal;
  Speed: string;
begin
  if Canceled then
  begin
    AAbort := True;
    Exit;
  end;

  if AContentLength > 0 then
    SetProgress(AReadCount * 100 div AContentLength);

  ElapsedTime := SecondsBetween(Now, FStartDate);
  if ElapsedTime > 0 then
  begin
    Speed := FormatFloat('0.00', AReadCount / 1024 / ElapsedTime);
    SetComment(Format(rstrSpeed, [Speed]));
  end;

  // Initialize tracking on first call
  if AReadCount = 0 then
  begin
    SetComment(rstrConnectingToServer);
    FStartDate := Now;
    SetProgress(0);
  end;
end;
```

Note: THTTPClient's `OnReceiveData` is called repeatedly during download. It replaces all three Indy events. We detect "start" by checking `AReadCount = 0` or use a flag. Actually, `OnReceiveData` is called with increasing `AReadCount`, so we need to initialize `FStartDate` before the HTTP call. Let's simplify: set `FStartDate` and initial comment before each `DownloadUpdate` call in `WorkFunction`.

Revised approach — set `FStartDate` before download:
```pascal
procedure TLibUpdateThread.HTTPReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var AAbort: Boolean);
var
  ElapsedTime: Cardinal;
  Speed: string;
begin
  if Canceled then
  begin
    AAbort := True;
    Exit;
  end;

  if AContentLength > 0 then
    SetProgress(AReadCount * 100 div AContentLength);

  ElapsedTime := SecondsBetween(Now, FStartDate);
  if ElapsedTime > 0 then
  begin
    Speed := FormatFloat('0.00', AReadCount / 1024 / ElapsedTime);
    SetComment(Format(rstrSpeed, [Speed]));
  end;
end;
```

- [ ] **Step 6: Update WorkFunction**

In `WorkFunction` (line 202), change:
Old: `if not Settings.Updates.DownloadUpdate(i, FidHTTP) then`
New:
```pascal
        SetComment(rstrConnectingToServer);
        FStartDate := Now;
        SetProgress(0);
        if not Settings.Updates.DownloadUpdate(i, FHTTPClient) then
```

Also change `FidHTTP.Disconnect` (line 119) — this was in the old HTTPWork cancel handler, now handled by `AAbort := True` in the new callback. Remove the explicit disconnect.

- [ ] **Step 7: Remove `FDownloadSize` field**

The `FDownloadSize` field (line 42) is no longer needed since `AContentLength` is passed directly in the callback. Remove it.

- [ ] **Step 8: Build and verify**

- [ ] **Step 9: Commit**

```bash
git add Program/UtilsImpl/unit_libupdateThread.pas
git commit -m "Migrate unit_libupdateThread from Indy to THTTPClient"
```

---

### Task 6: Migrate frame_NCWDownload.pas + .dfm

**Files:**
- Modify: `Program/Wizards/NewCollection/frame_NCWDownload.pas`
- Modify: `Program/Wizards/NewCollection/frame_NCWDownload.dfm`

This frame has **design-time** Indy components (TIdHTTP, TIdSSLIOHandlerSocketOpenSSL, TIdSocksInfo) placed via the form designer. They must be removed from the DFM and replaced with a runtime-created THTTPClient.

- [ ] **Step 1: Clean the DFM file**

Remove these three component blocks from `frame_NCWDownload.dfm`:

Remove the `object HTTP: TIdHTTP` block (lines 43-62).
Remove the `object IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL` block (lines 63-72).
Remove the `object IdSocksInfo: TIdSocksInfo` block (lines 73-76).

The DFM should only keep `lblStatus`, `Bar`, and `pnTitle`.

- [ ] **Step 2: Replace the interface uses clause**

Old (lines 17-37):
```pascal
uses
  Windows, Messages, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  frame_InteriorPageBase, StdCtrls, ExtCtrls, ComCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  IdSocks, IdSSLOpenSSL, IdCustomTransparentProxy, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL;
```

New:
```pascal
uses
  Windows, Messages, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  frame_InteriorPageBase, StdCtrls, ExtCtrls, ComCtrls,
  System.Net.HttpClient;
```

- [ ] **Step 3: Replace class declaration**

Old fields and event declarations — remove:
```pascal
    HTTP: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    IdSocksInfo: TIdSocksInfo;
    procedure HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure HTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure HTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
```

New fields and methods:
```pascal
  private
    FHTTPClient: THTTPClient;
    FDownloadSize: Int64;
    FStartDate: TDateTime;
    FTerminated: Boolean;
    procedure HTTPReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var AAbort: Boolean);
```

Remove `FDownloadSize`, `FStartDate`, `FTerminated` from the old `private` section (they'll be in the new one).

- [ ] **Step 4: Rewrite implementation**

Add `unit_MHLHttpClient` to implementation uses. Remove `unit_Globals` from implementation uses (only needed for `SetProxySettingsUpdate`; check if anything else uses it — `unit_NCWParams` and `unit_Globals` are in uses; keep `unit_Globals` only if other symbols are needed, otherwise remove).

Replace `Download` method:
```pascal
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
```

Replace progress callback:
```pascal
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
```

Delete old `HTTPWorkBegin`, `HTTPWork`, `HTTPWorkEnd` methods.

Replace `Stop`:
```pascal
procedure TframeNCWDownload.Stop;
begin
  FTerminated := True;
  // Cancellation happens via AAbort in HTTPReceiveData callback
end;
```

- [ ] **Step 5: Build and verify**

- [ ] **Step 6: Commit**

```bash
git add Program/Wizards/NewCollection/frame_NCWDownload.pas Program/Wizards/NewCollection/frame_NCWDownload.dfm
git commit -m "Migrate frame_NCWDownload from Indy to THTTPClient, remove design-time components"
```

---

## Chunk 2: Complex Consumer + Cleanup

### Task 7: Migrate unit_Downloader.pas (most complex)

**Files:**
- Modify: `Program/DwnldImpl/unit_Downloader.pas`

This is the most complex file. It uses TIdHTTP for GET/POST, TIdMultiPartFormDataStream for form data, OnWork* for progress, OnRedirect for redirect capture, and Disconnect for cancellation.

- [ ] **Step 1: Replace interface uses clause**

Old (lines 24-39):
```pascal
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
```

New:
```pascal
uses
  Windows,
  Classes,
  SysUtils,
  Dialogs,
  System.Net.HttpClient,
  System.Net.URLClient,
  System.Net.Mime,
  System.NetEncoding,
  unit_Globals,
  unit_Interfaces;
```

- [ ] **Step 2: Replace class fields**

Old fields (lines 58-63):
```pascal
    FidHTTP: TidHttp;
    FidSocksInfo: TIdSocksInfo;
    FidSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;

    FParams: TIdMultiPartFormDataStream;
    FResponse: TMemoryStream;
```

New:
```pascal
    FHTTPClient: THTTPClient;
    FParams: TMultipartFormData;
    FResponse: TMemoryStream;
```

- [ ] **Step 3: Replace event signatures in the class declaration**

Old (lines 87-90):
```pascal
    procedure HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure HTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure HTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure HTTPRedirect(Sender: TObject; var dest: string; var NumRedirect: Integer; var Handled: boolean; var VMethod: string);
```

New:
```pascal
    procedure HTTPReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var AAbort: Boolean);
    procedure HTTPRedirect(const Sender: TObject; const ARequest: IHTTPRequest; const AResponse: IHTTPResponse; ARedirections: Integer; var AAllow: Boolean);
```

- [ ] **Step 4: Replace constructor and destructor**

Old constructor (lines 146-162):
```pascal
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
```

New:
```pascal
constructor TDownloader.Create;
begin
  inherited Create;

  FHTTPClient := CreateHTTPClientGlobal;
  FHTTPClient.OnReceiveData := HTTPReceiveData;
  FHTTPClient.OnRedirect := HTTPRedirect;

  FIgnoreErrors := False;
end;
```

Add `unit_MHLHttpClient` to the implementation uses clause.

Old destructor (lines 164-171):
```pascal
destructor TDownloader.Destroy;
begin
  FreeAndNil(FidSSLIOHandlerSocketOpenSSL);
  FreeAndNil(FidSocksInfo);
  FreeAndNil(FidHTTP);
  inherited Destroy;
end;
```

New:
```pascal
destructor TDownloader.Destroy;
begin
  FreeAndNil(FHTTPClient);
  inherited Destroy;
end;
```

- [ ] **Step 5: Replace AddParam**

Old (lines 173-177):
```pascal
function TDownloader.AddParam(const Name: string; const Value: string): boolean;
begin
  FParams.AddFormField(Name, Value);
  Result := True;
end;
```

New:
```pascal
function TDownloader.AddParam(const Name: string; const Value: string): boolean;
begin
  FParams.AddField(Name, Value);
  Result := True;
end;
```

- [ ] **Step 6: Replace redirect handler**

Old (lines 248-254):
```pascal
procedure TDownloader.HTTPRedirect(Sender: TObject; var dest: string; var NumRedirect: Integer; var Handled: boolean; var VMethod: string);
begin
  if EndsText(FB2ZIP_EXTENSION, dest) then
    FNewURL := dest
  else
    FNewURL := '';
end;
```

New:
```pascal
procedure TDownloader.HTTPRedirect(const Sender: TObject; const ARequest: IHTTPRequest; const AResponse: IHTTPResponse; ARedirections: Integer; var AAllow: Boolean);
var
  RedirectURL: string;
begin
  RedirectURL := AResponse.Headers['Location'];
  if EndsText(FB2ZIP_EXTENSION, RedirectURL) then
    FNewURL := RedirectURL
  else
    FNewURL := '';
  AAllow := True;
end;
```

Note: We need to get the redirect URL from the response Location header, since the new event signature doesn't directly pass the destination string.

Actually, let me check. THTTPClient's redirect handling: the `ARequest` and `AResponse` contain the redirect info. The redirect URL is in the Location header of the response. Let's verify this approach works — `AResponse.HeaderValue['Location']`.

Actually, looking at the RTL source more carefully, the request object for the redirect should contain the new URL. Let me use a simpler approach:

```pascal
procedure TDownloader.HTTPRedirect(const Sender: TObject; const ARequest: IHTTPRequest; const AResponse: IHTTPResponse; ARedirections: Integer; var AAllow: Boolean);
var
  RedirectURL: string;
begin
  RedirectURL := AResponse.HeaderValue['Location'];
  if EndsText(FB2ZIP_EXTENSION, RedirectURL) then
    FNewURL := RedirectURL
  else
    FNewURL := '';
  AAllow := True;
end;
```

- [ ] **Step 7: Replace progress callbacks**

Delete `HTTPWork`, `HTTPWorkBegin`, `HTTPWorkEnd` (lines 256-296).

New single callback:
```pascal
procedure TDownloader.HTTPReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var AAbort: Boolean);
var
  ElapsedTime: Cardinal;
  Speed: string;
begin
  if FNoProgress then
    Exit;

  if Canceled then
  begin
    AAbort := True;
    Exit;
  end;

  if AContentLength > 0 then
    FOnSetProgress(AReadCount * 100 div AContentLength, -1);

  ElapsedTime := SecondsBetween(Now, FStartDate);
  if ElapsedTime > 0 then
  begin
    Speed := FormatFloat('0.00', AReadCount / 1024 / ElapsedTime);
    FOnSetComment(Format(rstrSpeed, [Speed]), '');
  end;
end;
```

Remove `FDownloadSize` field (line 72) — no longer needed; `AContentLength` is passed in the callback.

- [ ] **Step 8: Replace DoDownload — multipart form data**

In `DoDownload` (line 313), change:
Old: `FParams := TIdMultiPartFormDataStream.Create;`
New: `FParams := TMultipartFormData.Create;`

The rest of DoDownload stays the same — the command dispatch works the same way.

- [ ] **Step 9: Replace Query method**

Old Query (lines 495-543):
```pascal
function TDownloader.Query(Kind: TQueryKind; const Uri: string): boolean;
begin
  Result := False;
  URL := Uri;
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
      ...
    on E: Exception do
      ...
  end;
end;
```

New:
```pascal
function TDownloader.Query(Kind: TQueryKind; const Uri: string): boolean;
var
  Response: IHTTPResponse;
begin
  Result := False;

  URL := Uri;
  StrReplace('%RESURL%', FNewURL, URL);

  try
    FStartDate := Now;
    case Kind of
      qkGet:
        begin
          FNoProgress := False;
          Response := FHTTPClient.Get(TNetEncoding.URL.Encode(URL), FResponse);
        end;

      qkPost:
        begin
          FNoProgress := True;
          Response := FHTTPClient.Post(TNetEncoding.URL.Encode(URL), FParams, FResponse);
        end;
    end;
    Result := True;
  except
    on E: ENetHTTPClientException do
      if not FIgnoreErrors then
        ProcessError(rstrConnectionError, rstrError, FFile);

    on E: Exception do
      if Assigned(Response) and (Response.StatusCode <> 405) and
        not(Assigned(Response) and (Response.StatusCode = 404) and (FNewURL <> '')) then
        ProcessError(Format(rstrServerError, [E.Message]),
          rstrErrorCode + IntToStr(Response.StatusCode), FFile)
      else
        Result := True;
  end;
end;
```

Wait — the old code references `FidHTTP.ResponseCode` in the exception handler. With THTTPClient, if an exception is thrown, we may not have a valid `Response`. Let me handle this more carefully:

```pascal
function TDownloader.Query(Kind: TQueryKind; const Uri: string): boolean;
var
  Response: IHTTPResponse;
begin
  Result := False;
  Response := nil;

  URL := Uri;
  StrReplace('%RESURL%', FNewURL, URL);

  try
    FStartDate := Now;
    case Kind of
      qkGet:
        begin
          FNoProgress := False;
          Response := FHTTPClient.Get(TNetEncoding.URL.Encode(URL), FResponse);
        end;

      qkPost:
        begin
          FNoProgress := True;
          Response := FHTTPClient.Post(TNetEncoding.URL.Encode(URL), FParams, FResponse);
        end;
    end;
    Result := True;
  except
    on E: ENetHTTPClientException do
      if not FIgnoreErrors then
        ProcessError(rstrConnectionError, rstrError, FFile);

    on E: Exception do
    begin
      if Assigned(Response) then
      begin
        if (Response.StatusCode <> 405) and
          not((Response.StatusCode = 404) and (FNewURL <> '')) then
          ProcessError(Format(rstrServerError, [E.Message]),
            rstrErrorCode + IntToStr(Response.StatusCode), FFile)
        else
          Result := True;
      end
      else if not FIgnoreErrors then
        ProcessError(Format(rstrServerError, [E.Message]), rstrError, FFile);
    end;
  end;
end;
```

- [ ] **Step 10: Replace Stop method**

Old (lines 545-552):
```pascal
procedure TDownloader.Stop;
begin
  try
    FidHTTP.Disconnect;
  except
  end;
end;
```

New:
```pascal
procedure TDownloader.Stop;
begin
  Canceled := True;
  // Cancellation happens via AAbort in HTTPReceiveData callback
end;
```

- [ ] **Step 11: Replace CheckResponce — update ResponseCode reference**

In `CheckResponce` (line 186), the method doesn't reference Indy directly — it just works with `FResponse` stream. No changes needed.

- [ ] **Step 12: Remove unused Indy imports from implementation uses**

Old implementation uses (lines 111-124) include `HTTPApp`. Keep it only if used elsewhere. Also remove any remaining Indy references.

- [ ] **Step 13: Build and verify**

Run the build command. This is the most likely task to have compile errors — carefully check all references.

- [ ] **Step 14: Commit**

```bash
git add Program/DwnldImpl/unit_Downloader.pas
git commit -m "Migrate unit_Downloader from Indy to THTTPClient (GET/POST/redirect/progress)"
```

---

### Task 8: Clean up remaining Indy imports

**Files:**
- Modify: `Program/Units/unit_Helpers.pas` (lines 32-34)
- Modify: `Program/Forms/frm_main.pas` (lines 59-61)

- [ ] **Step 1: Remove Indy from unit_Helpers.pas**

Remove from the interface uses clause:
```pascal
  IdHTTP,
  IdSocks,
  IdSSLOpenSSL;
```

These were imported but likely not used by any types/functions in this unit (only imported for type visibility). Verify by building.

- [ ] **Step 2: Remove Indy from frm_main.pas**

Remove from the uses clause (lines 59-61):
```pascal
  IdHTTP,
  IdSocks,
  IdSSLOpenSSL,
```

- [ ] **Step 3: Build the full project group**

Build the complete project group to verify no Indy references remain:

```
cmd.exe //c "set BDS=C:\Program Files (x86)\Embarcadero\Studio\37.0&& set BDSCOMMONDIR=C:\Users\Public\Documents\Embarcadero\Studio\37.0&& C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe Program\MHL.groupproj /t:Build /p:Config=Release /p:Platform=Win32 /nologo /v:minimal" 2>&1
```

Expected: 0 errors.

- [ ] **Step 4: Verify no remaining Indy references in the codebase**

Run:
```bash
grep -rn "IdHTTP\|IdSocks\|IdSSLOpenSSL\|IdComponent\|IdStack\|IdMultipart\|IdURI\|TIdHTTP\|TIdSocks\|TIdSSL" Program/ --include="*.pas" --include="*.dfm"
```

Expected: No matches (excluding .map files and Out/ directory).

- [ ] **Step 5: Commit**

```bash
git add Program/Units/unit_Helpers.pas Program/Forms/frm_main.pas
git commit -m "Remove all remaining Indy imports from unit_Helpers and frm_main"
```

---

### Task 9: Update installer — remove OpenSSL DLLs

**Files:**
- Modify: `Installer/build_installer.cmd`
- Modify: `Installer/Common.iss`

- [ ] **Step 1: Remove OpenSSL from build_installer.cmd**

In `build_installer.cmd`, remove the OpenSSL copy lines from x86 section (lines 112-113):
```batch
copy /y "%BIN_DIR%\libeay32.dll" "%X86_DIR%\" >nul
copy /y "%BIN_DIR%\ssleay32.dll" "%X86_DIR%\" >nul
```

And from x64 section (lines 138-139):
```batch
copy /y "%BIN64_DIR%\libeay32.dll" "%X64_DIR%\" >nul
copy /y "%BIN64_DIR%\ssleay32.dll" "%X64_DIR%\" >nul
```

- [ ] **Step 2: Remove OpenSSL from Common.iss**

In `Common.iss`, remove lines 64-65:
```
Source: {#LibFolder + 'libeay32.dll'}; DestDir: {app}; Flags: replacesameversion
Source: {#LibFolder + 'ssleay32.dll'}; DestDir: {app}; Flags: replacesameversion
```

- [ ] **Step 3: Commit**

```bash
git add Installer/build_installer.cmd Installer/Common.iss
git commit -m "Remove OpenSSL DLLs from installer — no longer needed with SChannel"
```

---

### Task 10: Final verification

- [ ] **Step 1: Clean build**

Do a clean build (rebuild) of the full project group:
```
cmd.exe //c "set BDS=C:\Program Files (x86)\Embarcadero\Studio\37.0&& set BDSCOMMONDIR=C:\Users\Public\Documents\Embarcadero\Studio\37.0&& C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe Program\MHL.groupproj /t:Rebuild /p:Config=Release /p:Platform=Win32 /nologo /v:minimal" 2>&1
```

- [ ] **Step 2: Verify no OpenSSL DLLs in output**

```bash
ls Program/Out/Bin/libeay32.dll Program/Out/Bin/ssleay32.dll 2>/dev/null
```

Expected: Files may still exist from previous builds (they're not auto-deleted), but the app should not require them. The app should start and function without them.

- [ ] **Step 3: Smoke test**

Launch the built app and verify:
1. App starts without "DLL not found" errors
2. Check for updates works (Settings → Check Updates)
3. Book download works (if a configured online collection is available)

- [ ] **Step 4: Final commit with all changes**

If any fixups were needed during verification, commit them.
