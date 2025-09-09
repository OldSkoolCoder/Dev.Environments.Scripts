@echo off
setlocal enabledelayedexpansion

:: Set directories
set "TOOLS_DIR=%USERPROFILE%\DeveloperTools"
set "TEMP_DIR=%TEMP%\DevSetup"
set "PASMO_DIR=%TOOLS_DIR%\Pasmo"
set "ZESARUX_DIR=%TOOLS_DIR%\ZEsarUX"
set "EXTENSION=boukichi.pasmo"
set "CONFIG_DIR=%USERPROFILE%\AppData\Roaming\Code\User"
set "SETTINGS_FILE=%CONFIG_DIR%\settings.json"

:: Create directories
mkdir "%TOOLS_DIR%" 2>nul
mkdir "%TEMP_DIR%" 2>nul
mkdir "%PASMO_DIR%" 2>nul
mkdir "%ZESARUX_DIR%" 2>nul

:: Check for curl or fallback
where curl >nul 2>nul
if errorlevel 1 (
    echo curl not found. Trying bitsadmin...
    set "DOWNLOADER=bitsadmin"
) else (
    set "DOWNLOADER=curl"
)

@REM echo ========================================
@REM echo INSTALLING JDK 8 (Temurin from Adoptium)
@REM echo ========================================
@REM set "JDK_URL=https://download.java.net/java/GA/jdk24.0.1/24a58e0e276943138bf3e963e6291ac2/9/GPL/openjdk-24.0.1_windows-x64_bin.zip"
@REM set "JDK_ZIP=%TEMP_DIR%\jdk.zip"
@REM set "JDK_DEST=%TOOLS_DIR%\jdk"

@REM mkdir "%JDK_DEST%" 2>nul

@REM if "%DOWNLOADER%"=="curl" (
@REM     curl -L -o "%JDK_ZIP%" "%JDK_URL%"
@REM ) else (
@REM     bitsadmin /transfer "JDKDownload" "%JDK_URL%" "%JDK_ZIP%"
@REM )

@REM tar -xf "%JDK_ZIP%" -C "%JDK_DEST%"

@REM set PATH=%PATH%;%JDK_DEST%\jdk-24.0.1\bin

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
echo DOWNLOADING PASMO ASSEMBLER
echo ========================================
set "PASMO_URL=https://pasmo.speccy.org/bin/pasmo-0.5.4.beta2.zip"
set "PASMO_ZIP=%TEMP_DIR%\pasmo.zip"

curl -L -o "%PASMO_ZIP%" "%PASMO_URL%"
tar -xf "%PASMO_ZIP%" -C "%PASMO_DIR%"

echo ========================================
echo DOWNLOADING ZEsarUX EMULATOR
echo ========================================
set "ZESARUX_URL=https://github.com/chernandezba/zesarux/releases/download/ZEsarUX-12.1-Beta1/ZEsarUX_win-12.1-Beta1.zip"
set "ZESARUX_ZIP=%TEMP_DIR%\ZEsarUX.zip"

curl -L -o "%ZESARUX_ZIP%" "%ZESARUX_URL%"
tar -xf "%ZESARUX_ZIP%" --strip-components=1 -C "%ZESARUX_DIR%"

set PATH=%PATH%;%TOOLS_DIR%\ZEsarUX

@echo on
> %SETTINGS_FILE% echo {
>> %SETTINGS_FILE% echo     "editor.tabSize": 4,
>> %SETTINGS_FILE% echo     "editor.rulers": [60],
>> %SETTINGS_FILE% echo     "terminal.integrated.defaultProfile.windows": "Command Prompt",
>> %SETTINGS_FILE% echo     "files.autoSave": "afterDelay",
>> %SETTINGS_FILE% echo     "files.associations": {
>> %SETTINGS_FILE% echo         "*.asm": "kickassembler",
>> %SETTINGS_FILE% echo         "*.6502": "beebasm", 
>> %SETTINGS_FILE% echo         "*.z80": "pasmo"
>> %SETTINGS_FILE% echo     }
>> %SETTINGS_FILE% echo }
@echo off
cls
start /MIN code --install-extension "%Z80EXTENSION%" --force

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
