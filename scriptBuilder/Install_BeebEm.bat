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
echo DOWNLOADING beebem EMULATOR
echo ========================================

:: Set installation directories
set "beebem_url=https://github.com/stardot/beebem-windows/releases/download/4.19/BeebEm419.zip"
set "beebem_ZIP=%TEMP_DIR%\beebem419.zip"
set "beebem_DIR=%TOOLS_DIR%\BeebEm"
mkdir "%beebem_DIR%" 2>nul

:: Download BeebEm
if "%DOWNLOADER%"=="curl" (
    curl -L -o "%beebem_ZIP%" "%beebem_url%"
) else (
    bitsadmin /transfer "BEEBEMDownload" "%beebem_url%" "%beebem_ZIP%"
)

:: Extract BeebEm
tar -xf "%beebem_ZIP%" -C "%beebem_DIR%"
