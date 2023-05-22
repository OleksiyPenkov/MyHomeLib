; ****************************************************************************
;
; InnoSetup script for MyHomeLib
;
; Copyright: ©2023 Oleksiy Penkov (aka Koreec)
;
; Author: Oleksiy Penkov   oleksiy.penkov@gmail.com
;
; Created                  22.05.2023
; Description              
;
;
;*****************************************************************************

#include "common.iss"

[Setup]
#define SourceFolder = '..\Program\Out\Bin64\'
#define AppURL = 'https://github.com/OleksiyPenkov/'
#define protected Major 
#define protected Minor
#define protected Revision
#define protected Build
#define protected MyAppName = 'MyHomeLib'
#define protected AppExeName = MyAppName + '.exe'
#define protected FullSourcePath = SourceFolder + AppExeName
 
#define AppVersion GetVersionComponents(FullSourcePath, Major, Minor, Revision, Build)
#define protected ShortVersion = Str(Major) +'.' + Str(Minor) +'.' + Str(Revision) 

OutputBaseFilename = {#'Setup_' + MyAppName + '_' + ShortVersion + '_x64'}
ArchitecturesInstallIn64BitMode = x64

VersionInfoVersion = {#AppVersion}
AppName = {#MyAppName}
DefaultDirName = {commonpf}\{#MyAppName}\
DefaultGroupName = {#MyAppName}
AppVerName = {#MyAppName + " v. " + ShortVersion}
UninstallDisplayIcon = {app}\{#AppExeName}
AppPublisherURL = {#AppURL + MyAppName + '/'}
AppSupportURL = {#AppURL + MyAppName + '/'}
AppUpdatesURL = {#AppURL + MyAppName + '/'}

[Files]
Source: x64\sqlite3.dll; DestDir: {app}; Flags: replacesameversion
Source: x64\libeay32.dll; DestDir: {app}; Flags: replacesameversion
Source: x64\ssleay32.dll; DestDir: {app}; Flags: replacesameversion
Source: {#FullSourcePath}; DestDir: {app}; DestName: {#AppExeName}; Flags: replacesameversion

[Dirs]
Name: "{userappdata}\{#MyAppName}"; Permissions: everyone-modify
[Icons]
Name: {group}\{#MyAppName}; Filename: {app}\{#AppExeName}; WorkingDir: {app}; IconFilename: {app}\{#AppExeName}; IconIndex: 0; Comment: {#MyAppName}
Name: {group}\Довідка {#MyAppName}; Filename: {app}\{#MyAppName}.chm; WorkingDir: {app}; IconFilename: {sys}\ieframe.dll; IconIndex: 36; Comment: {#MyAppName} Help
Name: {commondesktop}\{#MyAppName}; Filename: {app}\{#AppExeName}; WorkingDir: {app}; IconFilename: {app}\{#AppExeName}; IconIndex: 0; Comment: {#MyAppName}; Tasks: desktopicon
Name: {group}\{#MyAppName} website; Filename: {app}\{#MyAppName}.url; IconFilename: {sys}\ieframe.dll; IconIndex: 36
Name: {group}\{cm:UninstallProgram, My Home Library}; Filename: {uninstallexe}
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#AppExeName}"; Tasks: quicklaunchicon

[UninstallDelete]
Name: {userappdata}\{#MyAppName}\Data; Type: filesandordirs
Name: {userappdata}\{#MyAppName}\Presets; Type: filesandordirs
Name: {userappdata}\{#MyAppName}\*.*; Type: files
Name: {userappdata}\{#MyAppName}; Type: dirifempty
Name: {app}; Type: files

[Run]
Filename: {app}\{#AppExeName}; WorkingDir: {app}; Description: {cm:LaunchProgram,{#MyAppName}}; Flags: nowait postinstall skipifsilent; Check: ; Tasks: 

