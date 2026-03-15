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
