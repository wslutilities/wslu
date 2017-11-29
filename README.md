# wslu - A collection of utilities for WSL
This is a collection of utilities for Windows 10 Linux Subsystem, such as enabling sound in WSL or creating your favorite linux GUI application shortcuts on Windows 10 Desktop. Requires Windows 10 Creators Update. 

**Currently supported Distro:**
- Ubuntu 16.04(Legacy)
- Ubuntu (Store)
- OpenSUSE
- SUSE Linux Enterprise Server(SLES)

## Installation

**Ubuntu**

1. Install dependencies: `sudo apt install build-essential bc`
2. Download the `.deb` package from [release](https://github.com/patrick330602/wslu/releases) and install it using `sudo dpkg -i wslu*`.

**OpenSUSE/SLES**

1. Install dependencies: `sudo zypper install bc lsb-release hostname`
2. Download the `.rpm` package from [release](https://github.com/patrick330602/wslu/releases) and install it using `sudo rpm -ivh "wslu*"`.

**Source**

clone the repository and install the package using `sudo make install`. To uninstall, run `sudo make uninstall`.

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

## Extras

### ZSH theme
this is a zsh theme specifically designed by me for WSL originally called `dealer`, a nice and minimal theme for your WSL. The file is in `extras` folder.

Here is a preview:

[![asciicast](https://asciinema.org/a/150053.png)](https://asciinema.org/a/150053)

## Credit
PulseAudio and VcXsrv Installation inspired by aseering/wsl_gui_autoinstall<https://github.com/aseering/wsl_gui_autoinstall>.

PulseAudio Linux packages belong to @aseering and @therealkenc from <https://github.com/Microsoft/BashOnWindows/issues/486>.

PulseAudio 6 Windows package provided by @kitor. 
