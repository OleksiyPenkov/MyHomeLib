@echo off
setlocal
:: ============================================================================
:: Copies the icon resource DLL into <destination>\Icons.
::
:: Usage: copy_icons.cmd <destination-folder> <platform>
::
:: <platform> is Win32 or Win64 and picks the matching build: the icon project
:: builds into Resources\Icons\<platform>, so an x64 build no longer overwrites
:: the x86 DLL. dm_Images loads the file with LOAD_LIBRARY_AS_DATAFILE, so the
:: bitness does not stop the resources from being read - keeping the builds
:: apart is what stops each platform from rewriting the other one's binary.
::
:: dm_Images loads it at runtime from <exe folder>\Icons\MHLIcons.dll. Without
:: it every image collection silently ends up empty and the whole UI runs with
:: no icons, so treat a missing source as a build failure rather than a warning.
:: ============================================================================

set "DEST=%~1"
set "PLATFORM=%~2"

if "%DEST%"=="" (
    echo ERROR: destination folder not specified.
    exit /b 1
)

if "%PLATFORM%"=="" (
    echo ERROR: platform not specified ^(Win32 or Win64^).
    exit /b 1
)

set "SRC=%~dp0Resources\Icons\%PLATFORM%\MHLIcons.dll"

if not exist "%SRC%" (
    echo ERROR: icon resource not found at "%SRC%".
    echo        Build Program\Resources\Icons\MHLIcons.dproj for %PLATFORM% first.
    exit /b 1
)

if not exist "%DEST%\Icons" mkdir "%DEST%\Icons"

copy /y "%SRC%" "%DEST%\Icons\MHLIcons.dll" >nul
if errorlevel 1 (
    echo ERROR: failed to copy icons to "%DEST%\Icons".
    exit /b 1
)

:: ----------------------------------------------------------------------------
:: libzstd.dll - runtime dependency of metabib dataset import (unit_ZstdStream
:: loads it dynamically from the exe folder). Missing DLL only disables that
:: import, so a missing source is a build failure to keep the package complete.
:: ----------------------------------------------------------------------------
set "ZSRC=%~dp0Resources\zstd\%PLATFORM%\libzstd.dll"

if not exist "%ZSRC%" (
    echo ERROR: libzstd.dll not found at "%ZSRC%".
    exit /b 1
)

copy /y "%ZSRC%" "%DEST%\libzstd.dll" >nul
if errorlevel 1 (
    echo ERROR: failed to copy libzstd.dll to "%DEST%".
    exit /b 1
)

exit /b 0
