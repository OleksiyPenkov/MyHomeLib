@echo off
setlocal
:: ============================================================================
:: Copies the icon resource DLL into <destination>\Icons.
::
:: Usage: copy_icons.cmd <destination-folder>
::
:: dm_Images loads it at runtime from <exe folder>\Icons\MHLIcons.dll. Without
:: it every image collection silently ends up empty and the whole UI runs with
:: no icons, so treat a missing source as a build failure rather than a warning.
:: ============================================================================

set "SRC=%~dp0Resources\Icons\MHLIcons.dll"
set "DEST=%~1"

if "%DEST%"=="" (
    echo ERROR: destination folder not specified.
    exit /b 1
)

if not exist "%SRC%" (
    echo ERROR: icon resource not found at "%SRC%".
    echo        Build Program\Resources\Icons\MHLIcons.dproj first.
    exit /b 1
)

if not exist "%DEST%\Icons" mkdir "%DEST%\Icons"

copy /y "%SRC%" "%DEST%\Icons\MHLIcons.dll" >nul
if errorlevel 1 (
    echo ERROR: failed to copy icons to "%DEST%\Icons".
    exit /b 1
)

exit /b 0
