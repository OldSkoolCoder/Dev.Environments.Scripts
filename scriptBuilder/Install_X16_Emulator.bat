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
echo DOWNLOADING COMMANDER X16 EMULATOR
echo ========================================

:: Set installation directories
set "X16_URL=https://github.com/X16Community/x16-emulator/releases/download/r48/x16emu_win64-r48.zip"
set "X16_ZIP=%TEMP_DIR%\x16.zip"
set "X16_DIR=%TOOLS_DIR%\X16-Emulator"
mkdir "%X16_DIR%" 2>nul

:: Download and extract Commander X16 Emulator
if "%DOWNLOADER%"=="curl" (
    curl -L -o "%X16_ZIP%" "%X16_URL%"
) else (
    bitsadmin /transfer "X16Download" "%X16_URL%" "%X16_ZIP%"
)

:: Extract Commander X16 Emulator
tar -xf "%X16_ZIP%" -C "%X16_DIR%"
