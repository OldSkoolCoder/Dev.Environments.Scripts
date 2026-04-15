#!/bin/bash

# Exit if any command fails
set -e

# ====== Configurable Variables ======
CONFIG_DIR="$HOME/.config/Code/User"
# URL of the zip file
RETRO_DEBUGGER_DIR="$HOME/Documents/Tools/RetroDebugger"

sudo apt update
sudo apt-get install -y curl unzip build-essential cmake
sudo apt install -y libsdl2-dev
sudo apt install -y libglew-dev
sudo apt install -y libgtk-3-dev 

# ====== Install Retro Debugger ======
echo "Installing Retro Debugger..."
mkdir "$RETRO_DEBUGGER_DIR"
git clone https://github.com/slajerek/RetroDebugger.git "$RETRO_DEBUGGER_DIR"
cd "$RETRO_DEBUGGER_DIR"
./build-linux.sh

echo "Retro Debugger is installed"