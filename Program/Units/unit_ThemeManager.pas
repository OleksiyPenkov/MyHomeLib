unit unit_ThemeManager;

interface

uses
  Vcl.Themes, Vcl.Styles;

type
  TMHLThemeMode = (tmSystem, tmLight, tmDark);

  TMHLThemeManager = class
  private
    class var FThemeMode: TMHLThemeMode;
  public
    class function DetectSystemDarkMode: Boolean; static;
    class procedure ApplyTheme(AMode: TMHLThemeMode); static;
    class property ThemeMode: TMHLThemeMode read FThemeMode write FThemeMode;
  end;

implementation

uses
  Winapi.Windows, System.SysUtils, Registry;

const
  CStyleLight = 'Windows10';
  CStyleDark  = 'Windows10Dark';

class function TMHLThemeManager.DetectSystemDarkMode: Boolean;
var
  Reg: TRegistry;
begin
  Result := False;
  Reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize') then
    begin
      if Reg.ValueExists('AppsUseLightTheme') then
        Result := Reg.ReadInteger('AppsUseLightTheme') = 0;
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

class procedure TMHLThemeManager.ApplyTheme(AMode: TMHLThemeMode);
var
  UseDark: Boolean;
  StyleName: string;
begin
  FThemeMode := AMode;
  case AMode of
    tmSystem: UseDark := DetectSystemDarkMode;
    tmDark:   UseDark := True;
    tmLight:  UseDark := False;
  else
    UseDark := False;
  end;

  if UseDark then
    StyleName := CStyleDark
  else
    StyleName := CStyleLight;

  TStyleManager.TrySetStyle(StyleName, False);
end;

end.
