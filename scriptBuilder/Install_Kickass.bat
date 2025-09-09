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
echo DOWNLOADING KICK ASSEMBLER
echo ========================================

:: Set installation directories
set "KICK_DIR=%TOOLS_DIR%\KickAssembler"
set "KICK_URL=https://www.theweb.dk/KickAssembler/KickAssembler.zip"
set "KICK_ZIP=%TEMP_DIR%\kickassembler.zip"
mkdir "%KICK_DIR%" 2>nul

:: Download Kick Assembler
if "%DOWNLOADER%"=="curl" (
    curl -L -o "%KICK_ZIP%" "%KICK_URL%"
) else (
    bitsadmin /transfer "KICKDownload" "%KICK_URL%" "%KICK_ZIP%"
)

:: Extract Kick Assembler
tar -xf "%KICK_ZIP%" -C "%KICK_DIR%"
