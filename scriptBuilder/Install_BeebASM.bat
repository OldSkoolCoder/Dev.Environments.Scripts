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
echo DOWNLOADING BEEBASM
echo ========================================
:: Set installation directories
set "BEEBASM_URL=https://github.com/stardot/beebasm/releases/download/v1.10/beebasm-win32.zip"
set "BEEBASM_ZIP=%TEMP_DIR%\beebasm.zip"
set "BEEBASM_DIR=%TOOLS_DIR%\BeebAsm"
mkdir "%BEEBASM_DIR%" 2>nul

:: Download BeebAsm
if "%DOWNLOADER%"=="curl" (
    curl -L -o "%BEEBASM_ZIP%" "%BEEBASM_URL%"
) else (
    bitsadmin /transfer "BEEBASMDownload" "%BEEBASM_URL%" "%BEEBASM_ZIP%"
)

:: Extract BeebAsm
tar -xf "%BEEBASM_ZIP%" -C "%BEEBASM_DIR%"
