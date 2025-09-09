@echo off
setlocal enabledelayedexpansion

:: Set directories
set "TOOLS_DIR=%USERPROFILE%\DeveloperTools"
set "TEMP_DIR=%TEMP%\DevSetup"
set "KICK_DIR=%TOOLS_DIR%\KickAssembler"
set "APPLEII_DIR=%TOOLS_DIR%\AppleII"
set "RETRODEBUG_DIR=%TOOLS_DIR%\RetroDebugger"
set "EXTENSION=paulhocker.kick-assembler-vscode-ext"
set "CONFIG_DIR=%USERPROFILE%\AppData\Roaming\Code\User"
set "SETTINGS_FILE=%CONFIG_DIR%\settings.json"

:: Create directories
mkdir "%TOOLS_DIR%" 2>nul
mkdir "%TEMP_DIR%" 2>nul
mkdir "%KICK_DIR%" 2>nul
mkdir "%APPLEII_DIR%" 2>nul
mkdir "%RETRODEBUG_DIR%" 2>nul

:: Check for curl or fallback
where curl >nul 2>nul
if errorlevel 1 (
    echo curl not found. Trying bitsadmin...
    set "DOWNLOADER=bitsadmin"
) else (
    set "DOWNLOADER=curl"
)

echo ========================================
echo INSTALLING JDK 8 (Temurin from Adoptium)
echo ========================================
set "JDK_URL=https://download.java.net/java/GA/jdk24.0.1/24a58e0e276943138bf3e963e6291ac2/9/GPL/openjdk-24.0.1_windows-x64_bin.zip"
set "JDK_ZIP=%TEMP_DIR%\jdk.zip"
set "JDK_DEST=%TOOLS_DIR%\jdk"

mkdir "%JDK_DEST%" 2>nul

if "%DOWNLOADER%"=="curl" (
    curl -L -o "%JDK_ZIP%" "%JDK_URL%"
) else (
    bitsadmin /transfer "JDKDownload" "%JDK_URL%" "%JDK_ZIP%"
)

tar -xf "%JDK_ZIP%" --strip-components=1 -C "%JDK_DEST%"

set PATH=%PATH%;%JDK_DEST%\jdk-24.0.1\bin

echo ========================================
echo INSTALLING Visual C++ Redistributable x86
echo ========================================
set MSVC_URL="https://aka.ms/vs/17/release/vc_redist.x86.exe"
set "MSVC_EXE=%TEMP_DIR%\vc_redist.x86.exe"
curl -L -o "%MSVC_EXE%" "%MSVC_URL%"
echo.
echo CHECK Taskbar for UAC prompt
"%MSVC_EXE%" /QUIET /NORESTART

echo ========================================
echo INSTALLING Visual C++ Redistributable x64
echo ========================================
set MSVC2_URL="https://aka.ms/vs/17/release/vc_redist.x64.exe"
set "MSVC2_EXE=%TEMP_DIR%\vc_redist.x64.exe"
curl -L -o "%MSVC2_EXE%" "%MSVC2_URL%"
echo.
echo CHECK Taskbar for UAC prompt
"%MSVC2_EXE%" /QUIET /NORESTART

echo ========================================
echo INSTALLING GIT
echo ========================================
set "GIT_URL=https://github.com/git-for-windows/git/releases/download/v2.50.0.windows.1/Git-2.50.0-64-bit.exe"
set "GIT_EXE=%TEMP_DIR%\git-installer.exe"

curl -L -o "%GIT_EXE%" "%GIT_URL%"
"%GIT_EXE%" /VERYSILENT /NORESTART /DIR="%TOOLS_DIR%\Git"

set PATH=%PATH%;%TOOLS_DIR%\Git\cmd

echo ========================================
echo INSTALLING VISUAL STUDIO CODE
echo ========================================
set "VSCODE_URL=https://update.code.visualstudio.com/latest/win32-x64-user/stable"
set "VSCODE_EXE=%TEMP_DIR%\vscode-installer.exe"

curl -L -o "%VSCODE_EXE%" "%VSCODE_URL%"
"%VSCODE_EXE%" /VERYSILENT /NORESTART /MERGETASKS=!runcode

set PATH=%PATH%;%USERPROFILE%\AppData\Local\Programs\Microsoft VS Code\bin

echo ========================================
echo DOWNLOADING KICK ASSEMBLER
echo ========================================
set "KICK_URL=https://www.theweb.dk/KickAssembler/KickAssembler.zip"
set "KICK_ZIP=%TEMP_DIR%\kickassembler.zip"

curl -L -o "%KICK_ZIP%" "%KICK_URL%"
tar -xf "%KICK_ZIP%" -C "%KICK_DIR%"

echo ========================================
echo DOWNLOADING APPLE][ EMULATOR
echo ========================================
set "APPLEII_URL=https://github.com/AppleWin/AppleWin/releases/download/v1.30.21.0/AppleWin1.30.21.0.zip"
set "APPLEII_ZIP=%TEMP_DIR%\APPLEII.zip"

curl -L -o "%APPLEII_ZIP%" "%APPLEII_URL%"
tar -xf "%APPLEII_ZIP%" -C "%APPLEII_DIR%"

echo ========================================
echo DOWNLOADING RETRO Debugger
echo ========================================
set "RETRODEBUG_URL=https://github.com/slajerek/RetroDebugger/releases/download/v0.64.72/RetroDebugger.v0.64.72-windows-x64-notsigned.zip"
set "RETRODEBUG_ZIP=%TEMP_DIR%\RetroDebugger.zip"

curl -L -o "%RETRODEBUG_ZIP%" "%RETRODEBUG_URL%"
tar -xf "%RETRODEBUG_ZIP%" --strip-components=1 -C "%RETRODEBUG_DIR%"

@echo on
> %SETTINGS_FILE% echo {
>> %SETTINGS_FILE% echo     "editor.tabSize": 4,
>> %SETTINGS_FILE% echo     "editor.rulers": [60],
>> %SETTINGS_FILE% echo     "terminal.integrated.defaultProfile.windows": "Command Prompt",
>> %SETTINGS_FILE% echo     "files.autoSave": "afterDelay",
>> %SETTINGS_FILE% echo     "kickassembler.byteDumpFile": true,
>> %SETTINGS_FILE% echo     "kickassembler.assembler.option.binfile": true,
>> %SETTINGS_FILE% echo     "kickassembler.assembler.option.outputDirectory": "./build",
>> %SETTINGS_FILE% echo     "kickassembler.java.runtime": "%JDK_DEST:\=/%/bin/java.exe",
>> %SETTINGS_FILE% echo     "kickassembler.assembler.jar": "%KICK_DIR:\=/%/KickAss.jar",
>> %SETTINGS_FILE% echo     "kickassembler.emulator.runtime": "%TOOLS_DIR:\=/%/APPLEII/AppleWin.exe",
>> %SETTINGS_FILE% echo     "kickassembler.emulator.options": " ${kickassembler:buildFilename}",
>> %SETTINGS_FILE% echo     "files.associations": {
>> %SETTINGS_FILE% echo         "*.asm": "kickassembler",
>> %SETTINGS_FILE% echo         "*.6502": "beebasm", 
>> %SETTINGS_FILE% echo         "*.z80": "pasmo"
>> %SETTINGS_FILE% echo     }
>> %SETTINGS_FILE% echo }

@echo off
cls
start /MIN code --install-extension "%EXTENSION%" --force
start /MIN code --install-extension "%BEEBASM_EXTENSION%" --force

echo.
echo ========================================
echo DONE!
echo.
echo Add these to your PATH (manually):
echo.
echo   %JDK_DEST%\bin
echo ========================================
echo.
start rundll32 sysdm.cpl,EditEnvironmentVariables
pause
@echo on
