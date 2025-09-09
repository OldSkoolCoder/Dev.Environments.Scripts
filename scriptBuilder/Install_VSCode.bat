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
echo INSTALLING VISUAL STUDIO CODE
echo ========================================

:: Set download URL and output file
set "VSCODE_URL=https://update.code.visualstudio.com/latest/win32-x64-user/stable"
set "VSCODE_EXE=%TEMP_DIR%\vscode-installer.exe"

:: Download Visual Studio Code
if "%DOWNLOADER%"=="curl" (
    curl -L -o "%VSCODE_EXE%" "%VSCODE_URL%"
) else (
    bitsadmin /transfer "VSCODEDownload" "%VSCODE_URL%" "%VSCODE_EXE%"
)

:: Install Visual Studio Code
"%VSCODE_EXE%" /VERYSILENT /NORESTART /MERGETASKS=!runcode

:: Update PATH
setx PATH "PATH=%PATH%;%USERPROFILE%\AppData\Local\Programs\Microsoft VS Code\bin"
