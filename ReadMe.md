# 🛠️ Retro Dev Environment Installer

## 🚀 Install Scripts for Windows & Linux
Set up a complete development environment for **Commander X16** and **Commodore 64** projects using:

- 🧠 **Kick Assembler**
- 💻 **Visual Studio Code (VSCode)**
- 🔌 **Kick 8-Bit Retro Studio** – Paul Hocker’s powerful VSCode extension

Whether you're a retro game developer, hobbyist, or enthusiast, these scripts make it simple to get started on your favorite platform.

---

## 📦 Features

- 🏗️ Automated setup of **Kick Assembler** (Java-based)
- 📦 Installation of **Java Runtime Environment** if needed
- 📂 Download and setup of **Commander X16 emulator** (Linux/Windows)
- 📂 Download and setup of **Commodore VICE System specificall C64** (Windows)
- 🧰 Configuration of **VSCode** and **Kick 8-Bit Retro Studio**
- 🔄 Environment variable setup for seamless usage in terminal/build tasks

---

## 🖥️ Platforms Supported

- ✅ Windows 10/11
- ✅ Linux (Debian/Ubuntu-based distros tested)
- ✅ Raspian (Debian/Ubuntu-based distros for RaspberryPi)
---

## 🧰 Whats Installed

|  Requirement         | Description                                           |
|----------------------|-------------------------------------------------------|
|  Java (JRE/JDK)      | Needed for Kick Assembler (auto-installed if missing) |
|  Git                 | For cloning the repository and downloading tools      |
| *Visual C Redist     | Required for beebasm to run*                          |
|  Curl/Wget           | For downloading binaries                              |
|  VSCode              | Will be auto-installed if not found                   |
| *CommanderX16        | Will be auto-installed if not found*                  |
| *VICE Emulator       | Will be auto-installed if not found*                  |
| *SEarUX Emulator     | Will be auto-installed if not found*                  |
| *Pasmo Z80 Assembler | Will be auto-installed if not found*                  |
| *BeebEm Emulator     | Will be auto-installed if not found*                  |
| *Beebasm Emulator    | Will be auto-installed if not found*                  |

#### *Depending on installer script used 
---

## 📥 Installation

### 🔷 Windows

1. Clone this repository or download the install script:
    ```powershell
    git clone https://github.com/OldSkoolCoder/Dev.Environments.Scripts.git
    cd retro-dev-installer
    ```

2. Run the installer For Commander X16:
    ```powershell
    .\Windows_Install_X16.bat
    ```

3. or Run the installer For VICE Emulator:
    ```powershell
    .\Windows_Install_C64.bat
    ```

> ⚠️ **Note**: Make sure to run command prompt in user mode not adminstration mode.

---

### 🐧 Linux

1. Clone this repository:
    ```bash
    git clone https://github.com/OldSkoolCoder/Dev.Environments.Scripts.git
    cd retro-dev-installer
    ```

2. Make the installer executable:
    ```bash
    chmod +x VSCode_Install_X16.sh
    ```

3. Run the installer For Commander X16:
    ```bash
    ./VSCode_Install_X16.sh
    ```

---

## 🛠️ What's Included

- ✅ Kick Assembler latest version from official source
- ✅ Kick 8-Bit Retro Studio (VSCode extension)
- ✅ Optional: Commander X16 Emulator
- ✅ Optional: VICE C64 Emulator
- ✅ Environment setup (`$PATH`, `.vscode/tasks.json`, etc.)

---

## 📚 Resources

- [Kick Assembler Official Site](http://www.theweb.dk/KickAssembler/)
- [Pasmo Assembler](https://pasmo.speccy.org/)
- [BeebASM Assembler](https://github.com/stardot/beebasm)
- [SEsarUX Emulator](https://github.com/chernandezba/zesarux/)
- [Commander X16](https://www.commanderx16.com/)
- [BeebEm Emulator](http://www.mkw.me.uk/beebem/)
- [VICE Emulator (Versatile Commodore Emulator)](https://vice-emu.sourceforge.io/)
- [Kick 8-Bit Retro Studio extension]([https://marketplace.visualstudio.com/items?itemName=paulhocker.kickassembler](https://marketplace.visualstudio.com/items?itemName=paulhocker.kick-assembler-vscode-ext))
- [pasmo Extension](https://marketplace.visualstudio.com/items?itemName=boukichi.pasmo)
- [beeb VSC (BeebASM)](https://marketplace.visualstudio.com/items?itemName=simondotm.beeb-vsc)
- 


---

## 🧾 License

MIT License – feel free to use, modify, and share.

Happy Hacking! 👾

