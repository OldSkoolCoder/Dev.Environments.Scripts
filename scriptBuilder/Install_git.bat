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
echo INSTALLING GIT
echo ========================================
:: Set download URL and output file
set "GIT_URL=https://github.com/git-for-windows/git/releases/download/v2.50.0.windows.1/Git-2.50.0-64-bit.exe"
set "GIT_EXE=%TEMP_DIR%\git-installer.exe"

:: Download GIT
if "%DOWNLOADER%"=="curl" (
    curl -L -o "%GIT_EXE%" "%GIT_URL%"
) else (
    bitsadmin /transfer "GITDownload" "%GIT_URL%" "%GIT_EXE%"
)

:: Install GIT
"%GIT_EXE%" /VERYSILENT /NORESTART /DIR="%TOOLS_DIR%\Git"
