<div align="center">

<img width="150" height="150" src="extras/icon.png">

# wslu - A collection of utilities for WSL

[![GitHub license](https://badgen.net/github/license/wslutilities/wslu?icon=github&label=&color=cyan)](https://github.com/wslutilities/wslu/blob/master/LICENSE)
[![GitHub (pre-)release](https://badgen.net/github/release/wslutilities/wslu?icon=github&label=&color=yellow)](https://github.com/wslutilities/wslu)
[![Circle CI master](https://badgen.net/circleci/github/wslutilities/wslu/master?label=master&icon=circleci)](https://circleci.com/gh/wslutilities/wslu/tree/master)
[![Circle CI develop](https://badgen.net/circleci/github/wslutilities/wslu/develop?label=develop&icon=circleci)](https://circleci.com/gh/wslutilities/wslu/tree/develop)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fpatrick330602%2Fwslu.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fpatrick330602%2Fwslu?ref=badge_shield)
[![Donate](https://badgen.net/badge/Donate/Paypal/purple)](https://www.paypal.me/callmepk/)

English | [简体中文](README.hans.md) | [繁體中文](README.hant.md)

</div>

This is a collection of utilities for Windows 10 Linux Subsystem, such as converting WSL path to Windows path or creating your favorite linux GUI application shortcuts on Windows 10 Desktop. Requires Windows 10 Creators Update.

**Currently supported Distro:**
- [WLinux](https://afflnk.microsoft.com/c/1291904/433017/7593?u=https%3A%2F%2Fwww.microsoft.com%2Fstore%2FproductId%2F9NV1GV1PXZ6P)
- Ubuntu
- Ubuntu 16.04 LTS
- Ubuntu 18.04 LTS
- OpenSUSE Leap 42
- OpenSUSE Leap 15.0
- SUSE Linux Enterprise Server 12
- SUSE Linux Enterprise Server 15
- Debian GNU/Linux
- Kali Linux

Legacy Ubuntu is no longer supported.

## Feature

**wslusc**
This is a WSL shortcut creator to create a shortcut on your Windows 10 Desktop.

**wslsys**
This is a WSL system information printer to print out system informations from Windows 10 or Linux.

**wslfetch**
This is a WSL Screenshoot Information Tool to print information in an elegant way.

**wslupath**
This is a WSL Windows path Converter that can convert Windows path to other styles of path.

**wslview**
This is a fake WSL browser that can help you open link in default Windows browser.

## Installation

### For WLinux

Preinstalled in WLinux.

### For Ubuntu/Debian/Kali Linux

Run following commands:
```bash
sudo apt install apt-transport-https
wget -O - https://api.patrickwu.ml/public.key | sudo apt-key add -
echo "deb https://apt.patrickwu.ml/ stable main" | sudo tee -a /etc/apt/sources.list 
sudo apt update
sudo apt install wslu
```

Or you can download the .deb package from release and install it using `sudo dpkg -i wslu*`.

### For OpenSUSE/SLES

Run following commands:
```bash
sudo zypper ar https://rpm.patrickwu.ml/ ruapm
sudo zypper ref
sudo zypper in wslu
```

Or you can download the .rpm package from release and install it using `sudo rpm -ivh "wslu*"`.

## Contributing

Check [CONTRIBUTING.md](CONTRIBUTING.md).

## Code of Conduct

Check [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).

## License

This project uses [LGPLv3](LICENSE)License.

[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fpatrick330602%2Fwslu.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fpatrick330602%2Fwslu?ref=badge_large)
