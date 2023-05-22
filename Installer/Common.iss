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

[Setup]
PrivilegesRequired=poweruser
AppID={{B9B6C409-01CB-4AB6-8E4F-403B49A25B56}
OutputDir=.\Out
SourceDir=.
AppCopyright=© 2023 Oleksiy Penkov
WizardImageFile=.\Images\SetupModern20.bmp
WizardSmallImageFile=.\Images\SetupModernSmall20.bmp
SetupIconFile=.\Images\Setup.ico
UsePreviousAppDir=yes
AllowNoIcons=yes
Compression=lzma/ultra
SolidCompression=yes
LicenseFile=Common\License.txt

[Files]
Source: Common\AlReader\*.*; DestDir: {app}\AlReader
Source: Common\AlReader\AlReader2\*.*; DestDir: {app}\AlReader\AlReader2\
Source: Common\converters\fb2lrf\*.*; DestDir: {app}\converters\fb2lrf\
Source: Common\converters\fb2pdf\*.*; DestDir: {app}\converters\fb2pdf\
Source: Common\converters\fb2epub\*.*; DestDir: {app}\converters\fb2epub\
Source: Common\converters\fb2mobi\*.*; DestDir: {app}\converters\fb2mobi\
Source: Common\genres_nonfb2.glst; DestDir: {app}; Flags: replacesameversion
Source: Common\genres_fb2.glst; DestDir: {app}; Flags: replacesameversion
Source: Common\collections.ini; DestDir: {userappdata}\MyHomeLib
Source: Common\MyHomeLib.chm; DestDir: {app}; Flags: replacesameversion
Source: Common\MyHomeLib.url; DestDir: {app}; Flags: replacesameversion
Source: Common\License.txt; DestDir: {app}; Flags: replacesameversion

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}
Name: "quicklaunchicon"; Description: "Create a &Quick Launch icon"; GroupDescription: "Additional icons:"; Flags: unchecked

[Languages]
Name: English; MessagesFile: compiler:Default.isl
Name: Ukrainian; MessagesFile: compiler:Languages\Ukrainian.isl
