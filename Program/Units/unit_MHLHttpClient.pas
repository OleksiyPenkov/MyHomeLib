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

const
  // WinHTTP scheme prefixes for proxy types
  ProxySchemes: array[0..2] of string = ('', 'socks4', 'socks5');

procedure InitClient(AClient: THTTPClient);
begin
  AClient.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36';
  AClient.ConnectionTimeout := Settings.TimeOut;
  AClient.ResponseTimeout := Settings.ReadTimeOut;
  AClient.HandleRedirects := True;
end;

function CreateHTTPClientGlobal: THTTPClient;
var
  ProxyType: Integer;
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
    ProxyType := Settings.ProxyType;
    if (ProxyType in [0..2]) and (Settings.ProxyServer <> '') then
      Result.ProxySettings := TProxySettings.Create(
        Settings.ProxyServer, Settings.ProxyPort,
        Settings.ProxyUsername, Settings.ProxyPassword,
        ProxySchemes[ProxyType]);
  end;
end;

function CreateHTTPClientUpdate: THTTPClient;
var
  ProxyType: Integer;
begin
  Result := THTTPClient.Create;
  InitClient(Result);

  if Settings.UseProxyForUpdate then
  begin
    ProxyType := Settings.ProxyType;
    if (ProxyType in [0..2]) and (Settings.ProxyServerUpdate <> '') then
      Result.ProxySettings := TProxySettings.Create(
        Settings.ProxyServerUpdate, Settings.ProxyPortUpdate,
        Settings.ProxyUsernameUpdate, Settings.ProxyPasswordUpdate,
        ProxySchemes[ProxyType]);
  end;
end;

end.
