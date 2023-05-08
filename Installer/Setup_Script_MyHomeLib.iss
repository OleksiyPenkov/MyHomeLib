[Setup]
AppName=MyHomeLib
PrivilegesRequired=poweruser
DefaultDirName={commonpf}\MyHomeLib\
DefaultGroupName=MyHomeLib
AppID={{B9B6C409-01CB-4AB6-8E4F-403B49A25B56}
OutputDir=.
SourceDir=.
AppVerName=MyHomeLib v.2.3
AppCopyright=© 2023 Oleksiy Penkov
UninstallDisplayIcon={app}\MyHomeLib.exe
WizardImageFile=.\Images\SetupModern20.bmp
WizardSmallImageFile=.\Images\SetupModernSmall20.bmp
SetupIconFile=.\Images\Setup.ico
OutputBaseFilename=Setup_MyHomeLib.2.3
AppPublisherURL=https://github.com/OleksiyPenkov/myhomelib/
AppSupportURL=https://github.com/OleksiyPenkov/myhomelib/
AppUpdatesURL=https://github.com/OleksiyPenkov/myhomelib/
UsePreviousAppDir=yes
AllowNoIcons=yes
Compression=lzma/ultra
SolidCompression=yes
LicenseFile=License.txt
VersionInfoVersion=2.3.5.845

[Dirs]
Name: "{userappdata}\MyHomeLib"; Permissions: everyone-modify
[Files]
Source: .\MyHomeLib_2_3\AlReader\*.*; DestDir: {app}\AlReader
Source: .\MyHomeLib_2_3\AlReader\AlReader2\*.*; DestDir: {app}\AlReader\AlReader2\
Source: .\MyHomeLib_2_3\converters\fb2lrf\*.*; DestDir: {app}\converters\fb2lrf\
Source: .\MyHomeLib_2_3\converters\fb2pdf\*.*; DestDir: {app}\converters\fb2pdf\
Source: .\MyHomeLib_2_3\converters\fb2epub\*.*; DestDir: {app}\converters\fb2epub\
Source: .\MyHomeLib_2_3\converters\fb2mobi\*.*; DestDir: {app}\converters\fb2mobi\
Source: .\MyHomeLib_2_3\genres_nonfb2.glst; DestDir: {app}; Flags: replacesameversion
Source: .\MyHomeLib_2_3\genres_fb2.glst; DestDir: {app}; Flags: replacesameversion
Source: .\MyHomeLib_2_3\sqlite3.dll; DestDir: {app}; Flags: replacesameversion
Source: .\MyHomeLib_2_3\libeay32.dll; DestDir: {app}; Flags: replacesameversion
Source: .\MyHomeLib_2_3\ssleay32.dll; DestDir: {app}; Flags: replacesameversion
Source: .\MyHomeLib_2_3\collections.ini; DestDir: {userappdata}\MyHomeLib
Source: .\MyHomeLib_2_3\MyHomeLib.exe; DestDir: {app}; Flags: replacesameversion
Source: .\MyHomeLib_2_3\MyHomeLib.chm; DestDir: {app}; Flags: replacesameversion
Source: .\MyHomeLib_2_3\MyHomeLib.url; DestDir: {app}; Flags: replacesameversion
Source: .\MyHomeLib_2_3\License.txt; DestDir: {app}; Flags: replacesameversion
[Icons]
Name: {group}\MyHomeLib; Filename: {app}\MyHomeLib.exe; WorkingDir: {app}; IconFilename: {app}\MyHomeLib.exe; IconIndex: 0; Comment: MyHomeLib
Name: {group}\Справка по MyHomeLib; Filename: {app}\MyHomeLib.chm; WorkingDir: {app}; IconFilename: {sys}\ieframe.dll; IconIndex: 36; Comment: MyHomeLib Help
Name: {commondesktop}\MyHomeLib; Filename: {app}\MyHomeLib.exe; WorkingDir: {app}; IconFilename: {app}\MyHomeLib.exe; IconIndex: 0; Comment: MyHomeLib; Tasks: desktopicon
Name: {group}\MyHomeLib website; Filename: {app}\MyHomeLib.url; IconFilename: {sys}\ieframe.dll; IconIndex: 36
Name: {group}\{cm:UninstallProgram, My Home Library}; Filename: {uninstallexe}
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\MyHomeLib"; Filename: "{app}\MyHomeLib.exe"; Tasks: quicklaunchicon
[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}
Name: "quicklaunchicon"; Description: "Create a &Quick Launch icon"; GroupDescription: "Additional icons:"; Flags: unchecked

[Languages]
Name: Russian; MessagesFile: compiler:Languages\Russian.isl
Name: English; MessagesFile: compiler:Default.isl
Name: Ukrainian; MessagesFile: compiler:Languages\Ukrainian.isl
[UninstallDelete]
Name: {userappdata}\MyHomeLib\Data; Type: filesandordirs
Name: {userappdata}\MyHomeLib\Presets; Type: filesandordirs
Name: {userappdata}\MyHomeLib\*.*; Type: files
Name: {userappdata}\MyHomeLib; Type: dirifempty
Name: {app}; Type: files
[Run]
Filename: {app}\MyHomeLib.exe; WorkingDir: {app}; Description: {cm:LaunchProgram,MyHomeLib}; Flags: nowait postinstall skipifsilent; Check: ; Tasks: 