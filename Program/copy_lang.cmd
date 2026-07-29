@echo off
setlocal
:: ============================================================================
:: Copies the localization catalogs from Program\Lang into <destination>\Lang.
::
:: Usage: copy_lang.cmd <destination-folder>
::
:: Mirrors, so locales removed from the source disappear from the destination.
:: A missing source is not fatal: the Ukrainian strings are compiled into the
:: exe, so an app with no Lang folder runs correctly in Ukrainian.
:: ============================================================================

set "SRC=%~dp0Lang"
set "DEST=%~1"

if "%DEST%"=="" (
    echo ERROR: destination folder not specified.
    exit /b 1
)

if not exist "%SRC%" (
    echo NOTE: no localization catalogs at "%SRC%" - skipping.
    exit /b 0
)

robocopy "%SRC%" "%DEST%\Lang" /mir /njh /njs /ndl /nc /ns /np >nul
if errorlevel 8 (
    echo ERROR: failed to copy catalogs to "%DEST%\Lang".
    exit /b 1
)

exit /b 0
