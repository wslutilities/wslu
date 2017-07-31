# wslu - A collection of utilities for WSL
This is a collection of utilities for Windows 10 Linux Subsystem, such as enabling sound in WSL or creating your favorite linux GUI application shortcuts on Windows 10 Desktop. Requires Windows 10 Creators Update. Not fully supported in OpenSUSE.


## Installation

**Depedency:**
`bc`

**Install from package:**

Download the package from [release](https://github.com/patrick330602/wslu/releases) and install it using `sudo dpkg -i wslu*`.
**Install from source:**

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

## Credit
PulseAudio and VcXsrv Installation inspired by aseering/wsl_gui_autoinstall<https://github.com/aseering/wsl_gui_autoinstall>.

PulseAudio Linux packages belong to @aseering and @therealkenc from <https://github.com/Microsoft/BashOnWindows/issues/486>.

PulseAudio 6 Windows package provided by @kitor. 
