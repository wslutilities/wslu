# wslu - A collection of utilities for WSL

[![Wiki](https://img.shields.io/badge/Wiki-wslu-blue.svg)](https://github.com/patrick330602/wslu/wiki) [![GitHub license](https://img.shields.io/github/license/patrick330602/wslu.svg)](https://github.com/patrick330602/wslu/blob/master/LICENSE) [![GitHub (pre-)release](https://img.shields.io/github/release/qubyte/rubidium/all.svg)](https://github.com/patrick330602/wslu)

This is a collection of utilities for Windows 10 Linux Subsystem, such as enabling sound in WSL or creating your favorite linux GUI application shortcuts on Windows 10 Desktop. Requires Windows 10 Creators Update. 

**Currently supported Distro:**
- Ubuntu 16.04(Legacy)
- Ubuntu (Store)
- OpenSUSE
- SUSE Linux Enterprise Server(SLES)

## Installation

**Ubuntu**

1. Install dependencies: `sudo apt install build-essential bc ppa-purge wget unzip`
2. Download the `.deb` package from [release](https://github.com/patrick330602/wslu/releases) and install it using `sudo dpkg -i wslu*`.

**OpenSUSE/SLES**

1. Install dependencies: `sudo zypper install bc lsb-release hostname wget unzip`
2. Download the `.rpm` package from [release](https://github.com/patrick330602/wslu/releases) and install it using `sudo rpm -ivh "wslu*"`.

**Source**

clone the repository and install the package using `chmod +x install; ./install`. To uninstall, run `sudo make uninstall`.

## Feature
**wslusc**
This is a WSL shortcut creator to create shortcut on your Windows 10 Desktop. 

**wslsys**
This is a WSL system information printer to print out some basic system information.

**wslpkg** 
This is WSL Package Installer, which is a minimal package manager for installing special packages. Also, it provide some simple commands to install apps from third-party repositories.

**wslfetch**
This is a WSL Screenshoot Information Tool to print information in a elegant way.

**wslpath**
This is a WSL Windows path Converter that can convert Windows path to other styles of path.

# License

This is free software; you can redistribute it and/or modify

it under the terms of the GNU GPL version 3 or (at your option) any later version.

There is NO warranty; not even MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
