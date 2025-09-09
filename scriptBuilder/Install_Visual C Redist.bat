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
echo INSTALLING Visual C++ Redistributable x86
echo ========================================
:: Set download URL and output file
set MSVC_URL="https://aka.ms/vs/17/release/vc_redist.x86.exe"
set "MSVC_EXE=%TEMP_DIR%\vc_redist.x86.exe"

:: Download Visual C++ Redistributable x86
if "%DOWNLOADER%"=="curl" (
    curl -L -o "%MSVC_EXE%" "%MSVC_URL%"
) else (
    bitsadmin /transfer "MSVCDownload" "%MSVC_URL%" "%MSVC_EXE%"
)

:: Install Visual C++ Redistributable x86
echo.
echo CHECK Taskbar for UAC prompt
"%MSVC_EXE%" /QUIET /NORESTART

echo ========================================
echo INSTALLING Visual C++ Redistributable x64
echo ========================================
:: Set download URL and output file
set MSVC2_URL="https://aka.ms/vs/17/release/vc_redist.x64.exe"
set "MSVC2_EXE=%TEMP_DIR%\vc_redist.x64.exe"

:: Download Visual C++ Redistributable x64
if "%DOWNLOADER%"=="curl" (
    curl -L -o "%MSVC2_EXE%" "%MSVC2_URL%"
) else (
    bitsadmin /transfer "MSVC2Download" "%MSVC2_URL%" "%MSVC2_EXE%"
)

:: Install Visual C++ Redistributable x64
echo.
echo CHECK Taskbar for UAC prompt
"%MSVC2_EXE%" /QUIET /NORESTART
