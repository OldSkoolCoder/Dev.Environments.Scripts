@echo off
setlocal enabledelayedexpansion

:: Set directories
set "TOOLS_DIR=%USERPROFILE%\DeveloperTools"
set "TEMP_DIR=%TEMP%\DevSetup"
set "KICK_DIR=%TOOLS_DIR%\KickAssembler"
set "C64_DIR=%TOOLS_DIR%\VICE"
set "C64DeBug_DIR=%TOOLS_DIR%\C64Debugger"
set "EXTENSION=paulhocker.kick-assembler-vscode-ext"
set "CONFIG_DIR=%USERPROFILE%\AppData\Roaming\Code\User"
set "SETTINGS_FILE=%CONFIG_DIR%\settings.json"

:: Create directories
mkdir "%TOOLS_DIR%" 2>nul
mkdir "%TEMP_DIR%" 2>nul
mkdir "%KICK_DIR%" 2>nul
mkdir "%C64_DIR%" 2>nul
mkdir "%C64DeBug_DIR%" 2>nul

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

tar -xf "%JDK_ZIP%" -C "%JDK_DEST%"

set PATH=%PATH%;%JDK_DEST%\jdk-24.0.1\bin

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
echo DOWNLOADING VICE EMULATOR
echo ========================================
set "VICE_URL=https://github.com/VICE-Team/svn-mirror/releases/download/r45737/GTK3VICE-3.9-win64-r45737.zip"
set "VICE_ZIP=%TEMP_DIR%\VICE.zip"

curl -L -o "%VICE_ZIP%" "%VICE_URL%"
tar -xf "%VICE_ZIP%" --strip-components=1 -C "%C64_DIR%"

echo ========================================
echo DOWNLOADING C64 Debugger
echo ========================================
set "C64Debug_URL=https://commodore.software/downloads?task=download.send&id=13870:c64-debugger-v0-64-58-all-platforms&catid=675"
set "C64Debug_ZIP=%TEMP_DIR%\C64Debug.zip"

curl -L -o "%C64Debug_ZIP%" "%C64Debug_URL%"
tar -xf "%C64Debug_ZIP%" -C "%TEMP_DIR%"

tar -xf "%TEMP_DIR%\C64-65XE-Debugger-v0.64.58-win32.zip" --strip-components=1 -C "%C64DeBug_DIR%"

@echo on
> %SETTINGS_FILE% echo {
>> %SETTINGS_FILE% echo     "editor.tabSize": 4,
>> %SETTINGS_FILE% echo     "editor.rulers": [60],
>> %SETTINGS_FILE% echo     "terminal.integrated.defaultProfile.windows": "Command Prompt",
>> %SETTINGS_FILE% echo     "files.autoSave": "afterDelay",
>> %SETTINGS_FILE% echo     "kickassembler.byteDumpFile": true,
>> %SETTINGS_FILE% echo     "kickassembler.assembler.option.outputDirectory": "./build",
>> %SETTINGS_FILE% echo     "kickassembler.java.runtime": "%JDK_DEST:\=/%/bin/java.exe",
>> %SETTINGS_FILE% echo     "kickassembler.assembler.jar": "%KICK_DIR:\=/%/KickAss.jar",
>> %SETTINGS_FILE% echo     "kickassembler.emulator.runtime": "%TOOLS_DIR:\=/%/VICE/bin/x64sc.exe",
>> %SETTINGS_FILE% echo     "kickassembler.debugger.runtime": "%C64DeBug_DIR:\=/%/C64Debugger.exe",
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
echo Add these to your PATH (manually):
echo   %JDK_DEST%\bin
echo   %TOOLS_DIR%\Git\bin
echo   %KICK_DIR%
echo   %X16_DIR%
echo ========================================
start rundll32 sysdm.cpl,EditEnvironmentVariables
pause
@echo on
