; ****************************************************************************
;
; InnoSetup script for MyHomeLib
;
; Copyright: ©2008-2026 Oleksiy Penkov (aka Koreec)
;
; Author: Oleksiy Penkov   oleksiy.penkov@gmail.com
;
; Created                  22.05.2023
; Description
;
;
;*****************************************************************************

[Setup]
PrivilegesRequired=admin
AppID={{B9B6C409-01CB-4AB6-8E4F-403B49A25B56}
OutputDir=.\Out
SourceDir=.
AppCopyright=© 2008-2026 Oleksiy Penkov
WizardImageFile=.\Images\SetupModern20.bmp
WizardSmallImageFile=.\Images\SetupModernSmall20.bmp
SetupIconFile=.\Images\Setup.ico
UsePreviousAppDir=yes
AllowNoIcons=yes
Compression=lzma/ultra
SolidCompression=yes
LicenseFile=Common\License.txt
VersionInfoVersion = {#AppVersion}
AppName = {#MyAppName}
DefaultDirName = {autopf}\{#MyAppName}\
DefaultGroupName = {#MyAppName}
AppVerName = {#MyAppName + " v. " + ShortVersion}
UninstallDisplayIcon = {app}\{#AppExeName}
AppPublisherURL = {#AppURL}
AppSupportURL = {#AppURL}
AppUpdatesURL = {#AppURL}

[Dirs]
Name: "{userappdata}\{#MyAppName}"; Permissions: everyone-modify

[Icons]
Name: {group}\{#MyAppName}; Filename: {app}\{#AppExeName}; WorkingDir: {app}; IconFilename: {app}\{#AppExeName}; IconIndex: 0; Comment: {#MyAppName}
Name: {group}\Довідка {#MyAppName}; Filename: {app}\Help\index.html; WorkingDir: {app}; IconFilename: {sys}\ieframe.dll; IconIndex: 36; Comment: {#MyAppName} Help
Name: {commondesktop}\{#MyAppName}; Filename: {app}\{#AppExeName}; WorkingDir: {app}; IconFilename: {app}\{#AppExeName}; IconIndex: 0; Comment: {#MyAppName}; Tasks: desktopicon
Name: {group}\{#MyAppName} website; Filename: {app}\{#MyAppName}.url; IconFilename: {sys}\ieframe.dll; IconIndex: 36
Name: {group}\{cm:UninstallProgram, My Home Library}; Filename: {uninstallexe}

[UninstallDelete]
Name: {userappdata}\{#MyAppName}\Data; Type: filesandordirs
Name: {userappdata}\{#MyAppName}\Presets; Type: filesandordirs
Name: {userappdata}\{#MyAppName}\*.*; Type: files
Name: {userappdata}\{#MyAppName}; Type: dirifempty
Name: {app}; Type: files

[Run]
Filename: {app}\{#AppExeName}; WorkingDir: {app}; Description: {cm:LaunchProgram,{#MyAppName}}; Flags: nowait postinstall skipifsilent

[InstallDelete]
Type: files; Name: {app}\MyHomeLib.chm

[Files]
Source: {#FullSourcePath}; DestDir: {app}; DestName: {#AppExeName}; Flags: replacesameversion

Source: {#LibFolder + 'sqlite3.dll'}; DestDir: {app}; Flags: replacesameversion

; MCP server for AI assistants (see Help\mcp_server.html). Taken straight from
; the build output, like MHLIcons.dll below, so it always matches the packaged
; app. Needs the sqlite3.dll above sitting beside it: the DAO layer imports it
; at load time, so without it the server fails to start at all.
Source: {#SourceFolder + 'MHLMcpServer.exe'}; DestDir: {app}; Flags: replacesameversion

; Icon resource DLL, loaded at runtime by dm_Images from {app}\Icons.
; Taken from the build output so it always matches the exe being packaged.
; Deliberately no skipifsourcedoesntexist: if this is missing the app installs
; with no icons at all, so the installer build must fail instead.
Source: {#SourceFolder + 'Icons\MHLIcons.dll'}; DestDir: {app}\Icons; Flags: replacesameversion

Source: Common\AlReader\*; DestDir: {app}\AlReader; Flags: recursesubdirs
Source: Common\converters\fb2lrf\*; DestDir: {app}\converters\fb2lrf\; Flags: skipifsourcedoesntexist
Source: Common\converters\fb2pdf\*; DestDir: {app}\converters\fb2pdf\; Flags: skipifsourcedoesntexist
Source: Common\converters\fb2epub\*; DestDir: {app}\converters\fb2epub\; Flags: skipifsourcedoesntexist
Source: Common\converters\fb2mobi\*; DestDir: {app}\converters\fb2mobi\; Flags: skipifsourcedoesntexist
Source: Common\genres_nonfb2.glst; DestDir: {app}; Flags: replacesameversion
Source: Common\genres_fb2.glst; DestDir: {app}; Flags: replacesameversion
; Per-locale genre lists. The app prefers genres_<base>_<locale>.glst over the
; Russian original when one exists, so these are purely additive -- a install
; missing them behaves exactly as before.
Source: Common\genres_fb2_uk.glst; DestDir: {app}; Flags: replacesameversion
Source: Common\genres_nonfb2_uk.glst; DestDir: {app}; Flags: replacesameversion
Source: Common\genres_fb2_en.glst; DestDir: {app}; Flags: replacesameversion
Source: Common\genres_nonfb2_en.glst; DestDir: {app}; Flags: replacesameversion
Source: Common\collections.ini; DestDir: {userappdata}\MyHomeLib; Flags: onlyifdoesntexist
Source: Common\Help\*; DestDir: {app}\Help; Flags: recursesubdirs
Source: Common\MyHomeLib.url; DestDir: {app}; Flags: replacesameversion
Source: Common\License.txt; DestDir: {app}; Flags: replacesameversion
Source: Common\License_uk.txt; DestDir: {app}; Flags: replacesameversion

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}

[Languages]
; LicenseFile here overrides the [Setup] default, so each language shows the
; licence in its own language. Both files are UTF-8 with a BOM -- Inno 6 reads
; a BOM-less text file as the system ANSI codepage and mangles non-ASCII.
Name: English; MessagesFile: compiler:Default.isl; LicenseFile: Common\License.txt
Name: Ukrainian; MessagesFile: compiler:Languages\Ukrainian.isl; LicenseFile: Common\License_uk.txt
