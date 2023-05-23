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
#define LibFolder = 'x64\'

OutputBaseFilename = {#'Setup_' + MyAppName + '_' + ShortVersion + '_x64'}
ArchitecturesInstallIn64BitMode = x64

#include "common.iss"



