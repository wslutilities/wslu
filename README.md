<div align="center">

<img width="150" height="150" src="extras/icon.png">

# wslu - A collection of utilities for WSL

[![GitHub license](https://img.shields.io/github/license/wslutilities/wslu?style=flat-square&label=license&color=blue&logo=github)](https://github.com/wslutilities/wslu/blob/master/LICENSE)
[![GitHub (pre-)release](https://img.shields.io/github/v/release/wslutilities/wslu?include_prereleases&logo=github&style=flat-square)](https://github.com/wslutilities/wslu)
[![GitLab](https://img.shields.io/static/v1?label=gitlab&logo=gitlab&color=E24329&message=mirrored&style=flat-square)](https://gitlab.com/callmepk/wslu)
[![Gitee](https://img.shields.io/static/v1?label=gitee&color=C71D23&message=mirrored&style=flat-square)](https://gitee.com/mirrors/wslu)

[![CircleCI Master](https://img.shields.io/circleci/build/github/wslutilities/wslu/master?label=master&logo=circleci&style=flat-square)](https://circleci.com/gh/wslutilities/wslu/tree/master)
[![CircleCI](https://img.shields.io/circleci/build/github/wslutilities/wslu/develop?label=develop&logo=circleci&style=flat-square)](https://circleci.com/gh/wslutilities/wslu/tree/develop)
[![CodeFactor Grade Master](https://img.shields.io/codefactor/grade/github/wslutilities/wslu/master?label=codefactor%20%7C%20master&style=flat-square)](https://www.codefactor.io/repository/github/wslutilities/wslu/overview/master)
[![CodeFactor Grade Master](https://img.shields.io/codefactor/grade/github/wslutilities/wslu/develop?label=codefactor%20%7C%20develop&style=flat-square)](https://www.codefactor.io/repository/github/wslutilities/wslu/overview/develop)

[![Gitter](https://img.shields.io/gitter/room/wslutilities/wslu?color=ED1965&logo=gitter&style=flat-square)](https://gitter.im/wslutilities/wslu)
[![Twitter Follow](https://img.shields.io/twitter/follow/wslutilities?style=flat-square&logo=twitter&color=1DA1F2)
](https://twitter.com/wslutilities)

English | [简体中文](README.hans.md) | [繁體中文](README.hant.md)

</div>

This is a collection of utilities for Windows 10 Linux Subsystem, such as converting WSL path to Windows path or creating your favorite linux GUI application shortcuts on Windows 10 Desktop. Requires Windows 10 Creators Update.

## Feature

**wslusc**
A WSL shortcut creator to create a shortcut on your Windows 10 Desktop.

**wslsys**
A WSL system information printer to print out system informations from Windows 10 or Linux.

**wslfetch**
A WSL Screenshoot Information Tool to print information in an elegant way.

**wslvar**
A WSL tool to help you get Windows system environment variables.

**wslview**
A fake WSL browser that can help you open link in default Windows browser.

**wslupath** ⚠ *Deprecated*
A WSL tool to convert path styles.

## Installation

### Pengwin/Fedora Remix

Preinstalled in WLinux and Fedora Remix for WSL.

### Ubuntu

Preinstalled in the latest apps. On older installations please install ubuntu-wsl that depends on wslu:

```
sudo apt update
sudo apt install ubuntu-wsl
```

### For other Debian-based systems(Debian/Kali Linux)

You can download the `.deb` package from release and install it using `sudo dpkg -i wslu*`.

#### Debian

You can use the following command for easy installation:

```
curl -s https://packagecloud.io/install/repositories/whitewaterfoundry/wslu/script.deb.sh | sudo bash
```

### For RPM-based systems(OpenSUSE/SLES/Pengwin Enterprise/Oracle Linux)

You can use the following command for easy installation:

```
curl -s https://packagecloud.io/install/repositories/whitewaterfoundry/wslu/script.rpm.sh | sudo bash
```

You can download the `.rpm` package from release and install it using `sudo rpm -ivh "wslu*"`.

### Arch Linux

wslu is live on [AUR](https://aur.archlinux.org/packages/wslu/). You can download *PKGBUILD* and install manually or install via PKGBUILD helpers like yay.

### Alpine Linux

You can download the `.apk` package from release and install it using `sudo apk add --allow-untrusted "wslu*"`.

### Other distributions

> **⚠ Not Recommend**
> 
> `curl | bash` method is not secure. [Related article](https://sandstorm.io/news/2015-09-24-is-curl-bash-insecure-pgp-verified-install)

Run the following command in your preferred distro: `curl -sL https://wslu.patrickwu.space/install | bash`

## Contributors

This project exists thanks to all the people who contribute. [[Contribute](CONTRIBUTING.md)].
<img src="https://opencollective.com/wslu/contributors.svg?width=890&button=false" />

## License & Credits

<img width="150" src="https://www.gnu.org/graphics/gplv3-with-text-136x68.png">

This project uses [GPLv3](LICENSE) License.

Logo of WSL Utilities is licensed under [CC BY-NC 4.0 International License](http://creativecommons.org/licenses/by-nc/4.0/).

### Assets

Tux logo used in `\src\etc\wsl.ico` was originally made by Larry Ewing in the Gimp and re-illustrated in vector by Garrett LeSage, using Inkscape.

Some of `wslfetch` ASCII Arts comes from [`neofetch`](https://github.com/dylanaraps/neofetch/) with [MIT](https://github.com/dylanaraps/neofetch/blob/master/LICENSE.md) License and [`screenFetch`](https://github.com/KittyKatt/screenFetch/) with [GPLv3](https://github.com/KittyKatt/screenFetch/blob/master/COPYING) License.

Pengwin Logo used in `wslfetch` ASCII art is ASCII version of the artwork by [Dennis D. Bednarz](https://twitter.com/DennisBednarz), with use permission from Whitewater Foundry.

WLinux Logo used in `wslfetch` ASCII art is ASCII version of the artwork by Larry Ewing.