@echo off
setlocal enabledelayedexpansion
cls
:: Set Common directories
set "TOOLS_DIR=%USERPROFILE%\DeveloperTools"
set "TEMP_DIR=%TEMP%\DevSetup"
set "CONFIG_DIR=%USERPROFILE%\AppData\Roaming\Code\User"
set "SETTINGS_FILE=%CONFIG_DIR%\settings.json"

set "JDK_DEST=%TOOLS_DIR%\jdk"
set "KICK_DIR=%TOOLS_DIR%\KickAssembler"
set "X16_DIR=%TOOLS_DIR%\CommanderX16"
set "C64_DIR=%TOOLS_DIR%\VICE"
set "NES_DIR=%TOOLS_DIR%\NES"
set "RETRODEBUG_DIR=%TOOLS_DIR%\RetroDebugger"
set "C64DeBug_DIR=%TOOLS_DIR%\C64Debugger"
set "BEEBASM_DIR=%TOOLS_DIR%\BeebAsm"
set "BEEBEM_DIR=%TOOLS_DIR%\BeebEm"
set "PASMO_DIR=%TOOLS_DIR%\Pasmo"
set "ZESARUX_DIR=%TOOLS_DIR%\ZEsarUX"

set "EXTENSION=paulhocker.kick-assembler-vscode-ext"
set "Z80EXTENSION=boukichi.pasmo"
set "BEEBASM_EXTENSION=simondotm.beeb-vsc"

:: Create Commondirectories
mkdir "%TOOLS_DIR%" 2>nul
mkdir "%TEMP_DIR%" 2>nul
mkdir "%JDK_DEST%" 2>nul
mkdir "%KICK_DIR%" 2>nul
mkdir "%BEEBEM_DIR%" 2>nul
mkdir "%BEEBASM_DIR%" 2>nul
mkdir "%C64_DIR%" 2>nul
mkdir "%C64DeBug_DIR%" 2>nul
mkdir "%X16_DIR%" 2>nul
mkdir "%PASMO_DIR%" 2>nul
mkdir "%ZESARUX_DIR%" 2>nul
mkdir "%NES_DIR%" 2>nul
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


if "%DOWNLOADER%"=="curl" (
    curl -L -o "%JDK_ZIP%" "%JDK_URL%"
) else (
    bitsadmin /transfer "JDKDownload" "%JDK_URL%" "%JDK_ZIP%"
)

tar -xf "%JDK_ZIP%" --strip-components=1 -C "%JDK_DEST%"

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

echo ========================================
echo INSTALLING VISUAL STUDIO CODE
echo ========================================
set "VSCODE_URL=https://update.code.visualstudio.com/latest/win32-x64-user/stable"
set "VSCODE_EXE=%TEMP_DIR%\vscode-installer.exe"

curl -L -o "%VSCODE_EXE%" "%VSCODE_URL%"
"%VSCODE_EXE%" /VERYSILENT /NORESTART /MERGETASKS=!runcode

set "PATH=%PATH%;%USERPROFILE%\AppData\Local\Programs\Microsoft VS Code\bin"

echo ========================================
echo DOWNLOADING KICK ASSEMBLER
echo ========================================
set "KICK_DIR=%TOOLS_DIR%\KickAssembler"
set "KICK_URL=https://www.theweb.dk/KickAssembler/KickAssembler.zip"
set "KICK_ZIP=%TEMP_DIR%\kickassembler.zip"

curl -L -o "%KICK_ZIP%" "%KICK_URL%"
tar -xf "%KICK_ZIP%" -C "%KICK_DIR%"


echo ========================================
echo DOWNLOADING BEEBASM
echo ========================================
set "BEEBASM_URL=https://github.com/stardot/beebasm/releases/download/v1.10/beebasm-win32.zip"
set "BEEBASM_ZIP=%TEMP_DIR%\beebasm.zip"

curl -L -o "%BEEBASM_ZIP%" "%BEEBASM_URL%"
tar -xf "%BEEBASM_ZIP%" -C "%BEEBASM_DIR%"

echo ========================================
echo DOWNLOADING beebem EMULATOR
echo ========================================
set "beebem_url=https://github.com/stardot/beebem-windows/releases/download/4.19/BeebEm419.zip"
set "beebem_ZIP=%TEMP_DIR%\beebem419.zip"

curl -L -o "%beebem_ZIP%" "%beebem_url%"
tar -xf "%beebem_ZIP%" -C "%TOOLS_DIR%"

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

echo ========================================
echo DOWNLOADING COMMANDER X16 EMULATOR
echo ========================================
set "X16_URL=https://github.com/X16Community/x16-emulator/releases/download/r48/x16emu_win64-r48.zip"
set "X16_ZIP=%TEMP_DIR%\x16.zip"

curl -L -o "%X16_ZIP%" "%X16_URL%"
tar -xf "%X16_ZIP%" -C "%X16_DIR%"

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

echo ========================================
echo DOWNLOADING RETRO Debugger
echo ========================================
set "RETRODEBUG_URL=https://github.com/slajerek/RetroDebugger/releases/download/v0.64.72/RetroDebugger.v0.64.72-windows-x64-notsigned.zip"
set "RETRODEBUG_ZIP=%TEMP_DIR%\RetroDebugger.zip"

curl -L -o "%RETRODEBUG_ZIP%" "%RETRODEBUG_URL%"
tar -xf "%RETRODEBUG_ZIP%" --strip-components=1 -C "%RETRODEBUG_DIR%"

echo ========================================
echo DOWNLOADING NES EMULATOR
echo ========================================
set "NES_URL=https://github.com/TASEmulators/fceux/releases/download/v2.6.6/fceux-2.6.6-win64.zip"
set "NES_ZIP=%TEMP_DIR%\NES.zip"

curl -L -o "%NES_ZIP%" "%NES_URL%"
tar -xf "%NES_ZIP%" -C "%NES_DIR%"

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
