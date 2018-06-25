
<p align="center">
  <img width="300" height="300" src="extras/icon.png">
</p>

<p align="center">
# wslu - A collection of utilities for WSL

[![Wiki](https://img.shields.io/badge/Wiki-wslu-blue.svg)](https://github.com/patrick330602/wslu/wiki) [![GitHub license](https://img.shields.io/github/license/patrick330602/wslu.svg)](https://github.com/patrick330602/wslu/blob/master/LICENSE) [![GitHub (pre-)release](https://img.shields.io/github/release/patrick330602/wslu/all.svg)](https://github.com/patrick330602/wslu) [![Travis branch](https://img.shields.io/travis/patrick330602/wslu/master.svg)](https://travis-ci.org/patrick330602/wslu)
</p>
This is a collection of utilities for Windows 10 Linux Subsystem, such as enabling sound in WSL or creating your favorite linux GUI application shortcuts on Windows 10 Desktop. Requires Windows 10 Creators Update.

**Currently supported Distro:**
- Ubuntu
- Ubuntu 16.04
- Ubuntu 18.04
- OpenSUSE
- SUSE Linux Enterprise Server(SLES)
- Debian GNU/Linux
- Kali Linux

Legacy Ubuntu is no longer supporting.

## Feature

**wslusc**
This is a WSL shortcut creator to create shortcut on your Windows 10 Desktop.

**wslsys**
This is a WSL system information printer to print out some basic system information.

**wslfetch**
This is a WSL Screenshoot Information Tool to print information in a elegant way.

**wslupath**
This is a WSL Windows path Converter that can convert Windows path to other styles of path.

## Installation

Detailed installation is on Wiki/Installation.

### For Ubuntu/Debian

Run following commands:
```bash
sudo apt install software-properties-common apt-transport-https
wget -O - https://apt.patrickwu.ml/pkapt.key | sudo apt-key add -
sudo add-apt-repository https://apt.patrickwu.ml/
sudo apt update
sudo apt install wslu
```

Or you can download the .deb package from release and install it using `sudo dpkg -i wslu*`.

### For Kali Linux

Run following commands:
```bash
sudo apt install apt-transport-https
wget -O - https://apt.patrickwu.ml/pkapt.key | sudo apt-key add -
sudo echo "deb https://apt.patrickwu.ml/ kali main" >> /etc/apt/sources.list 
sudo apt update
sudo apt install wslu
```

Or you can download the .deb package from release and install it using `sudo dpkg -i wslu*`.

### For OpenSUSE/SLES

```bash
sudo zypper ar -G https://rpm.patrickwu.ml/ ruapm
sudo zypper ref
sudo zypper in wslu
```

Or you can download the .rpm package from release and install it using `sudo rpm -ivh "wslu*"`.

### Surce Code

To install, just run the following command in the bash prompt:
`curl -o- https://raw.githubusercontent.com/patrick330602/wslu/master/extras/scripts/install.sh | bash`

## License

<pre>
This is free software; you can redistribute it and/or modify
it under the terms of the GNU GPL version 3 or (at your option) any later version.
There is NO warranty; not even MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
</pre>
