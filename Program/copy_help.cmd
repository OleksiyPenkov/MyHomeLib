@echo off
setlocal
:: ============================================================================
:: Copies the HTML help from Program\Help into <destination>\Help.
::
:: Usage: copy_help.cmd <destination-folder>
::
:: Mirrors, so topics removed from the source disappear from the destination.
:: ============================================================================

set "SRC=%~dp0Help"
set "DEST=%~1"

if "%DEST%"=="" (
    echo ERROR: destination folder not specified.
    exit /b 1
)

if not exist "%SRC%" (
    echo ERROR: help source not found at "%SRC%".
    exit /b 1
)

robocopy "%SRC%" "%DEST%\Help" /mir /njh /njs /ndl /nc /ns /np >nul
if errorlevel 8 (
    echo ERROR: failed to copy help to "%DEST%\Help".
    exit /b 1
)

exit /b 0
