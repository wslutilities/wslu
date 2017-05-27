# wslu - Windows 10 linux Subsystem Utility
This is a series of utilities for Windows 10 Linux Subsystem, such as enabling sound in WSL or  creating your favorite linux GUI application shortcuts on Windows 10 Desktop. Requires Windows 10 Creators Update. Tested on my 16193 Machine and 15063 Virtual Machine.

# Install
Download the package from [release](https://github.com/patrick330602/wslu/releases) and install it using `sudo dpkg -i wslu*`.

# Feature
## install
install is a minimal package manager for installing special packages. Also, it provide some simple commands to install apps from third-party repositories.
### install pulseaudio
install pulseaudio to provide additional sound playing feature to WSL. 
### install vcxsrv
install vcxsrv to provide additional GUI feature to WSL.
### install \[third-party packages\] \[repository\]
install a application with a certain third-party repository.
## fetch
the minimal screen fetch program inspired by **ufetch** and **ScreenFetch**. 
## system
system will help print out the system information without any parameters. more options are following:
### system [-B|--build]
print Windows build information, for example: **Windows 10 Build 16193**
### system [-K|--kernel]
print WSL kernel info, for example: **Linux 4.4.0-43-Microsoft**
### system [-R|--release]
print WSL system release info, for example: **Ubuntu 16.04.2 LTS**
### system [-P|--package]
print total installed packages, for example: **1511**
## shortcut [appname]
shortcut command help you create a shortcut on the Windows 10 Desktop. 

# Credit
PulseAudio and VcXsrv Installation inspired by aseering/wsl_gui_autoinstall<https://github.com/aseering/wsl_gui_autoinstall>.
PulseAudio packages belong to @aseering and @therealkenc from <https://github.com/Microsoft/BashOnWindows/issues/486>
