@echo off
setlocal enabledelayedexpansion
set "PATH=%SystemRoot%\System32;%PATH%"

:: ============================================================================
:: MyHomeLib Installer Build Script
::
:: Collects redistributables from the build output into the Installer staging
:: directories (Common, x86, x64) and invokes Inno Setup to compile the
:: installer(s).
::
:: Usage:
::   build_installer.cmd [x86|x64|all]
::
:: Default: x86
:: ============================================================================

set "SCRIPT_DIR=%~dp0"
set "ROOT_DIR=%SCRIPT_DIR%.."
set "BIN_DIR=%ROOT_DIR%\Program\Out\Bin"
set "BIN64_DIR=%ROOT_DIR%\Program\Out\Bin64"
set "COMMON_DIR=%SCRIPT_DIR%Common"
set "X86_DIR=%SCRIPT_DIR%x86"
set "X64_DIR=%SCRIPT_DIR%x64"
set "ISCC=C:\Program Files (x86)\Inno Setup 6\ISCC.exe"

set "TARGET=%~1"
if "%TARGET%"=="" set "TARGET=x86"

:: ============================================================================
:: Validate
:: ============================================================================
if not exist "%BIN_DIR%\MyHomeLib.exe" (
    echo ERROR: %BIN_DIR%\MyHomeLib.exe not found. Build the project first.
    exit /b 1
)

if /i "%TARGET%"=="x64" (
    if not exist "%BIN64_DIR%\MyHomeLib.exe" (
        echo ERROR: %BIN64_DIR%\MyHomeLib.exe not found. Build the x64 project first.
        exit /b 1
    )
)

if /i "%TARGET%"=="all" (
    if not exist "%BIN64_DIR%\MyHomeLib.exe" (
        echo ERROR: %BIN64_DIR%\MyHomeLib.exe not found. Build the x64 project first.
        exit /b 1
    )
)

if not exist "%ISCC%" (
    echo ERROR: Inno Setup compiler not found at "%ISCC%"
    exit /b 1
)

:: ============================================================================
:: Collect Common redistributables (shared between x86 and x64)
:: ============================================================================
echo.
echo === Collecting Common redistributables ===

if not exist "%COMMON_DIR%" mkdir "%COMMON_DIR%"

:: Genre lists
copy /y "%BIN_DIR%\genres_fb2.glst"    "%COMMON_DIR%\" >nul
copy /y "%BIN_DIR%\genres_nonfb2.glst" "%COMMON_DIR%\" >nul

:: Help, URL, License
copy /y "%BIN_DIR%\MyHomeLib.chm" "%COMMON_DIR%\" >nul
copy /y "%BIN_DIR%\MyHomeLib.url" "%COMMON_DIR%\" >nul
copy /y "%BIN_DIR%\License.txt"   "%COMMON_DIR%\" >nul

:: Default collections config
copy /y "%BIN_DIR%\collections.ini" "%COMMON_DIR%\" >nul

:: AlReader
if exist "%BIN_DIR%\AlReader" (
    echo   Copying AlReader...
    robocopy "%BIN_DIR%\AlReader" "%COMMON_DIR%\AlReader" /s /e /njh /njs /ndl /nc /ns /np >nul
)

:: Converters
for %%C in (fb2lrf fb2epub fb2pdf fb2mobi) do (
    if exist "%BIN_DIR%\converters\%%C" (
        robocopy "%BIN_DIR%\converters\%%C" "%COMMON_DIR%\converters\%%C" /s /e /njh /njs /ndl /nc /ns /np >nul
    )
)

echo   Common files collected.

:: ============================================================================
:: Collect x86 DLLs
:: ============================================================================
if /i "%TARGET%"=="x86" goto :collect_x86
if /i "%TARGET%"=="all" goto :collect_x86
goto :skip_x86

:collect_x86
echo.
echo === Collecting x86 DLLs ===
if not exist "%X86_DIR%" mkdir "%X86_DIR%"

:: SQLite — prefer the one from SQLite/x32 if it exists (known good version)
if exist "%BIN_DIR%\SQLite\x32\sqlite3.dll" (
    copy /y "%BIN_DIR%\SQLite\x32\sqlite3.dll" "%X86_DIR%\" >nul
) else (
    copy /y "%BIN_DIR%\sqlite3.dll" "%X86_DIR%\" >nul
)

echo   x86 DLLs collected.
:skip_x86

:: ============================================================================
:: Collect x64 DLLs
:: ============================================================================
if /i "%TARGET%"=="x64" goto :collect_x64
if /i "%TARGET%"=="all" goto :collect_x64
goto :skip_x64

:collect_x64
echo.
echo === Collecting x64 DLLs ===
if not exist "%X64_DIR%" mkdir "%X64_DIR%"

:: SQLite — prefer the one from SQLite/x64 if it exists
if exist "%BIN_DIR%\SQLite\x64\sqlite3.dll" (
    copy /y "%BIN_DIR%\SQLite\x64\sqlite3.dll" "%X64_DIR%\" >nul
) else (
    copy /y "%BIN64_DIR%\sqlite3.dll" "%X64_DIR%\" >nul
)

echo   x64 DLLs collected.
:skip_x64

:: ============================================================================
:: Build installer(s)
:: ============================================================================
if not exist "%SCRIPT_DIR%Out" mkdir "%SCRIPT_DIR%Out"

if /i "%TARGET%"=="x86" goto :build_x86
if /i "%TARGET%"=="all" goto :build_x86
goto :skip_build_x86

:build_x86
echo.
echo === Building x86 installer ===
"%ISCC%" "%SCRIPT_DIR%Setup_Script_MyHomeLib.iss"
if errorlevel 1 (
    echo ERROR: x86 installer build failed!
    exit /b 1
)
:skip_build_x86

if /i "%TARGET%"=="x64" goto :build_x64
if /i "%TARGET%"=="all" goto :build_x64
goto :skip_build_x64

:build_x64
echo.
echo === Building x64 installer ===
"%ISCC%" "%SCRIPT_DIR%Setup_Script_MyHomeLib_x64.iss"
if errorlevel 1 (
    echo ERROR: x64 installer build failed!
    exit /b 1
)
:skip_build_x64

:: ============================================================================
:: Done
:: ============================================================================
echo.
echo === Done ===
echo.
for %%F in ("%SCRIPT_DIR%Out\Setup_MyHomeLib_*.exe") do (
    echo   Created: %%~nxF
)
echo.
