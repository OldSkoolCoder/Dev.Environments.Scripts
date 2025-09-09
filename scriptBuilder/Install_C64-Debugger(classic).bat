@echo off
setlocal enabledelayedexpansion
cls

:: Set Common directories
set "TOOLS_DIR=%USERPROFILE%\DeveloperTools"
set "TEMP_DIR=%TEMP%\DevSetup"
:: Create Common directories
mkdir "%TOOLS_DIR%" "%TEMP_DIR%"

:: Check for curl or fallback
where curl >nul 2>nul
if errorlevel 1 (
    echo curl not found. Trying bitsadmin...
    set "DOWNLOADER=bitsadmin"
) else (
    set "DOWNLOADER=curl"
)

echo ========================================
echo DOWNLOADING C64 Debugger
echo ========================================
:: Set installation directories
set "C64Debug_URL=https://commodore.software/downloads?task=download.send&id=13870:c64-debugger-v0-64-58-all-platforms&catid=675"
set "C64Debug_ZIP=%TEMP_DIR%\C64Debug.zip"
set "C64Debug_DIR=%TOOLS_DIR%\C64-Debugger"
mkdir "%C64Debug_DIR%" 2>nul

:: Download and extract C64 Debugger
if "%DOWNLOADER%"=="curl" (
    curl -L -o "%C64Debug_ZIP%" "%C64Debug_URL%"
) else (
    bitsadmin /transfer "C64DebugDownload" "%C64Debug_URL%" "%C64Debug_ZIP%"
)

:: Extract C64 Debugger
tar -xf "%C64Debug_ZIP%" -C "%TEMP_DIR%"
tar -xf "%TEMP_DIR%\C64-65XE-Debugger-v0.64.58-win32.zip" --strip-components=1 -C "%C64Debug_DIR%"
