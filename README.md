<div align="center">

<img width="150" height="150" src="extras/icon.png">

# wslu - A collection of utilities for WSL

[![GitHub license](https://img.shields.io/github/license/wslutilities/wslu?style=flat-square&label=license&color=blue&logo=github)](https://github.com/wslutilities/wslu/blob/master/LICENSE)
[![GitHub (pre-)release](https://img.shields.io/github/v/release/wslutilities/wslu?include_prereleases&logo=github&style=flat-square)](https://github.com/wslutilities/wslu)
[![GitLab](https://img.shields.io/static/v1?label=gitlab&logo=gitlab&color=E24329&message=mirrored&style=flat-square)](https://gitlab.com/callmepk/wslu)
[![Gitee](https://img.shields.io/static/v1?label=gitee&color=C71D23&message=mirrored&style=flat-square)](https://gitee.com/mirrors/wslu)
[![Twitter Follow](https://img.shields.io/twitter/follow/wslutilities?style=flat-square&logo=twitter&color=1DA1F2&label=follow)](https://twitter.com/wslutilities)

English | [简体中文](README.hans.md) | [繁體中文](README.hant.md)

</div>

This is a collection of utilities for Windows 10 Linux Subsystem, such as retriving Windows environment variables or creating your favorite linux GUI application shortcuts on Windows 10 Desktop. Requires Windows 10 Creators Update. Some of the feature requires higher version of Windows 10. Supports WSL2.

## Feature

**wslusc**
A WSL shortcut creator to create a shortcut on your Windows 10 Desktop.

**wslsys**
A WSL system information printer to print out system informations from Windows 10 or Linux.

**wslfetch**
A WSL screenshoot information tool to print information in an elegant way.

**wslvar**
A WSL tool to help you get Windows system environment variables.

**wslview**
A fake WSL browser that can help you open link in default Windows browser.

**wslupath**
A WSL tool to convert path styles.

**wslact**
A set of quick actions for WSL such as creating startup tasks and manually sync time between Windows ans WSL.

## Status

| | Service | Master | Develop |
| ------ | ------ |:------:|:-------:|
| License Check | FOSSA | [![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fpatrick330602%2Fwslu.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fpatrick330602%2Fwslu%2develop?ref=badge_shield) | - |
| Code Quality | CodeFactor | [![CodeFactor Grade Master](https://img.shields.io/codefactor/grade/github/wslutilities/wslu/master)](https://www.codefactor.io/repository/github/wslutilities/wslu/overview/master) | [![CodeFactor Grade Master](https://img.shields.io/codefactor/grade/github/wslutilities/wslu/develop)](https://www.codefactor.io/repository/github/wslutilities/wslu/overview/develop) |
| Testing | AppVeyor | [![Build status](https://ci.appveyor.com/api/projects/status/gcttf7igb0s40xak/branch/master?svg=true)](https://ci.appveyor.com/project/patrick330602/wslu/branch/master) | [![Build status](https://ci.appveyor.com/api/projects/status/gcttf7igb0s40xak/branch/develop?svg=true)](https://ci.appveyor.com/project/patrick330602/wslu/branch/develop) |
| Deployment | CircleCI | [![CircleCI](https://img.shields.io/circleci/build/gh/wslutilities/wslu/master)](https://circleci.com/gh/wslutilities/wslu/tree/master) | [![CircleCI](https://img.shields.io/circleci/build/gh/wslutilities/wslu/develop)](https://circleci.com/gh/wslutilities/wslu/tree/develop) |


## Installation

### Alpine Linux

You can install wslu from Alpine Linux testing with following way:

```
$ echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing/" | sudo tee -a /etc/apk/repositories
$ sudo apk update
$ sudo apk add wslu@testing
```

### Arch Linux

[wslu](https://aur.archlinux.org/packages/wslu/) and [wslu-git](https://aur.archlinux.org/packages/wslu-git/) on AUR.

### Debian

You can download the `.deb` package from release and install it using `sudo dpkg -i wslu*`.

### Fedora Remix

Preinstalled.

### Kali Linux

You can install wslu using the following command:

```
sudo apt install gnupg2 apt-transport-https
wget -O - https://access.patrickwu.space/wslu/public.asc | sudo apt-key add -
echo "deb https://access.patrickwu.space/wslu/kali kali-rolling main" | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo apt install wslu
```

### Pengwin

Preinstalled.

### Ubuntu

> Attention!
>
> The Ubuntu version of `wslu` is maintained by [Balint Reczey](https://launchpad.net/~rbalint) and its source code is hosted on [launchpad.net](https://code.launchpad.net/~ubuntu-core-dev/ubuntu/+source/wslu/+git/wslu).

Preinstalled in the latest apps. On older installations of Ubuntu please install `ubuntu-wsl` that depends on wslu:

```
sudo apt update
sudo apt install ubuntu-wsl
```

### For RPM-based systems(OpenSUSE/SLES/Pengwin Enterprise/Oracle Linux)

> TODO

### Other distributions

> **⚠ Not Recommend**
> 
> `curl | bash` method is not secure. [Related article](https://sandstorm.io/news/2015-09-24-is-curl-bash-insecure-pgp-verified-install)

Run the following command in your preferred distro: `curl -sL https://raw.githubusercontent.com/wslutilities/wslu/master/extras/scripts/wslu-install | bash`

## Contributors

This project exists thanks to all the people who contribute. [[Contribute](CONTRIBUTING.md)].
<img src="https://opencollective.com/wslu/contributors.svg?width=890&button=false" />

## License & Credits

<img width="150" src="https://www.gnu.org/graphics/gplv3-with-text-136x68.png">

This project uses [GPLv3](LICENSE) License.

Logo of WSL Utilities and icons for `wslusc` desktop shortcuts are licensed under [CC BY 4.0 International License](http://creativecommons.org/licenses/by/4.0/).

For other third party files and assets used, please refer to [THIRD_PARTY_LICENSE](THIRD_PARTY_LICENSE).
