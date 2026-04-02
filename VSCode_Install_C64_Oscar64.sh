#!/bin/bash

# Exit if any command fails
set -e

# ====== Configurable Variables ======
EXTENSION="rosc.vs64"
CONFIG_DIR="$HOME/.config/Code/User"
SETTINGS_FILE="$CONFIG_DIR/settings.json"
# URL of the zip file
KICK_URL="https://theweb.dk/KickAssembler/KickAssembler.zip"
VICE_ROM_FILE="vice-3.10.tar.gz"
VICE_ROM_DIR="$HOME/Documents/Tools/VICE"
VICE_ROM_URL="https://sourceforge.net/projects/vice-emu/files/releases/vice-3.10.tar.gz"
KICK_FILE="KickAss.zip"
KICK_DIR="$HOME/Documents/Tools/KickAss"
OSCAR64_DIR="$HOME/Documents/Tools/OSCAR64"

sudo apt update
sudo apt-get install -y curl unzip build-essential

# ====== Install GIT ======
echo "Installing GIT..."
sudo apt install -y git

# ====== Install Java ======
echo "Installing Java..."
sudo apt install -y default-jdk

# ====== Install Kick Assembler ======
echo "Installing Kick Assembler..."
if [ -e "$KICK_DIR/$KICK_FILE" ]; then
    echo "File exists."
else
    mkdir -p "$KICK_DIR"
    curl -L -o "$KICK_DIR/$KICK_FILE" "$KICK_URL"
    unzip "$KICK_DIR/$KICK_FILE" -d "$KICK_DIR"
fi

# ====== Install VICE Emulator =====
sudo apt install -y vice

mkdir -p "$VICE_ROM_DIR"
curl -L -o "$VICE_ROM_DIR/$VICE_ROM_FILE" "$VICE_ROM_URL"
#tar -zxvf "$VICE_ROM_DIR/$VICE_ROM_FILE" -C "$VICE_ROM_DIR"
tar -xzf "$VICE_ROM_DIR/$VICE_ROM_FILE" -C "$VICE_ROM_DIR" --wildcards '*.bin'

sudo cp -r "$VICE_ROM_DIR"/vice-3.10/data/* /usr/share/vice/


# ====== Install VS Code ======
echo "Installing VS Code..."
ARCH=$(dpkg --print-architecture)
if [[ "$ARCH" == "armhf" ]]; then
    sudo apt install -y code
elif [[ "$ARCH" == "arm64" ]]; then
    sudo apt install -y code
else
    #sudo snap install code --classic

    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64,arm64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
    sudo apt update
    sudo apt install code
fi

# ====== Install VS Code Extension ======
echo "Installing VS Code extension: $EXTENSION..."
code --install-extension "$EXTENSION" --force

mkdir "$OSCAR64_DIR"
git clone https://github.com/drmortalwombat/oscar64 "$OSCAR64_DIR"
cd "$OSCAR64_DIR"
make -C make all

# cat <<EOF >> "$HOME/.bashrc"
# export PATH="$PATH:$OSCAR64_DIR/bin"
# EOF

# ====== Create settings.json ======
echo "Configuring VS Code settings..."
mkdir -p "$CONFIG_DIR"

cat <<EOF >> "$SETTINGS_FILE"
{
    "editor.tabSize": 4,
    "editor.rulers": [80, 120],
    "files.autoSave": "afterDelay",
    "kickassembler.java.runtime": "/usr/bin/java",
    "kickassembler.assembler.jar": "$KICK_DIR/KickAss.jar",

    "vs64.showWelcome": false,
    "vs64.oscar64InstallDir": "$OSCAR64_DIR",
    "vs64.viceExecutable": "/usr/bin/x64sc",
    "vs64.viceArgs": "-VICIIdsize -VICIIfilter 0 -autostartprgmode 1",
}
EOF

# [Version]
# ConfigVersion=3.7.1

# [C64SC]
# SaveResourcesOnExit=1
# ConfirmOnExit=0
# Window0Height=849
# Window0Width=960
# Window0Xpos=471
# Window0Ypos=34
# VICIIFilter=0
# AutostartPrgMode=1
# BinaryMonitorServer=1


mkdir "$OSCAR64_DIR/Tutorials"
cd "$OSCAR64_DIR/Tutorials"
git clone https://github.com/drmortalwombat/OscarTutorials "$OSCAR64_DIR/Tutorials"


echo "VS Code is installed and configured with the $EXTENSION extension!"