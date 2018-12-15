<div align="center">

<img width="150" height="150" src="extras/icon.png">

# wslu - A collection of utilities for WSL

[![GitHub license](https://flat.badgen.net/github/license/wslutilities/wslu?icon=github&label=&color=cyan)](https://github.com/wslutilities/wslu/blob/master/LICENSE)
[![GitHub (pre-)release](https://flat.badgen.net/github/release/wslutilities/wslu?icon=github&label=&color=yellow)](https://github.com/wslutilities/wslu)
[![Circle CI master](https://flat.badgen.net/circleci/github/wslutilities/wslu/master?label=master&icon=circleci)](https://circleci.com/gh/wslutilities/wslu/tree/master)
[![Circle CI develop](https://flat.badgen.net/circleci/github/wslutilities/wslu/develop?label=develop&icon=circleci)](https://circleci.com/gh/wslutilities/wslu/tree/develop)
[![Donate](https://flat.badgen.net/badge/Donate/Paypal/purple)](https://www.paypal.me/callmepk/)
[![Backers on Open Collective](https://flat.badgen.net/opencollective/backers/wslu)](CONTRIBUTING.md#financial-contributions)

English | [简体中文](README.hans.md) | [繁體中文](README.hant.md)

</div>

This is a collection of utilities for Windows 10 Linux Subsystem, such as converting WSL path to Windows path or creating your favorite linux GUI application shortcuts on Windows 10 Desktop. Requires Windows 10 Creators Update.

**Currently supported Distro:**
- [WLinux](https://www.microsoft.com/store/productId/9NV1GV1PXZ6P) and its [Enterprise Edition](https://www.microsoft.com/store/productId/9N8LP0X93VCP)
- Ubuntu [Latest](https://www.microsoft.com/store/productId/9NBLGGH4MSV6), [16.04 LTS](https://www.microsoft.com/store/productId/9PJN388HP8C9) and [18.04 LTS](https://www.microsoft.com/store/productId/9N9TNGVNDL3Q)
- OpenSUSE Leap [42](https://www.microsoft.com/store/productId/9NJVJTS82TJX) and [15.0](https://www.microsoft.com/store/productId/9N1TB6FPVJ8C)
- SUSE Linux Enterprise Server [12](https://www.microsoft.com/store/productId/9P32MWBH6CNS) and [15](https://www.microsoft.com/store/productId/9PMW35D7FNLX)
- [Debian GNU/Linux](https://www.microsoft.com/store/productId/9MSVKQC78PK6)
- [Kali Linux](https://www.microsoft.com/store/productId/9PKR34TNCV07)
- Arch Linux via [ArchWSL](https://github.com/yuk7/ArchWSL)
- Alpine Linux via [AlpineWSL](https://github.com/yuk7/AlpineWSL) or [Alpine WSL](https://www.microsoft.com/store/productId/9P804CRF0395)


Legacy Ubuntu is no longer supported.

## Feature

**wslusc**
This is a WSL shortcut creator to create a shortcut on your Windows 10 Desktop.

**wslsys**
This is a WSL system information printer to print out system informations from Windows 10 or Linux.

**wslfetch**
This is a WSL Screenshoot Information Tool to print information in an elegant way.

**wslvar**
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
wget -O - https://api.patrickwu.space/public.key | sudo apt-key add -
echo "deb https://apt.patrickwu.space/ stable main" | sudo tee -a /etc/apt/sources.list 
sudo apt update
sudo apt install wslu
```

Or you can download the .deb package from release and install it using `sudo dpkg -i wslu*`.

### For OpenSUSE/SLES

Run following commands:
```bash
sudo zypper ar https://rpm.patrickwu.space/ ruapm
sudo zypper ref
sudo zypper in wslu
```

Or you can download the .rpm package from release and install it using `sudo rpm -ivh "wslu*"`.

## Contributors

This project exists thanks to all the people who contribute. [[Contribute](CONTRIBUTING.md)].
<img src="https://opencollective.com/wslu/contributors.svg?width=890&button=false" />

## License

<img width="150" src="https://www.gnu.org/graphics/gplv3-with-text-136x68.png">

This project uses [GPLv3](LICENSE) License.
