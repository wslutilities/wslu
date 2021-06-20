<div align="center">

<img width="150" height="150" src="extras/icon.png">

# wslu - A collection of utilities for WSL

[![GitHub license](https://img.shields.io/github/license/wslutilities/wslu?style=flat-square&label=license&color=blue&logo=github)](https://github.com/wslutilities/wslu/blob/master/LICENSE)
[![GitHub (pre-)release](https://img.shields.io/github/v/release/wslutilities/wslu?include_prereleases&logo=github&style=flat-square)](https://github.com/wslutilities/wslu)
[![GitLab](https://img.shields.io/static/v1?label=gitlab&logo=gitlab&color=E24329&message=mirrored&style=flat-square)](https://gitlab.com/wslutilities/wslu)
[![Launchpad](https://img.shields.io/static/v1?label=launchpad&logo=launchpad&color=F8C300&message=mirrored&style=flat-square)](https://launchpad.net/wslu)
[![Gitee](https://img.shields.io/static/v1?label=gitee&color=C71D23&message=mirrored&style=flat-square)](https://gitee.com/mirrors/wslu)
[![Twitter Follow](https://img.shields.io/twitter/follow/wslutilities?style=flat-square&logo=twitter&color=1DA1F2&label=follow)](https://twitter.com/wslutilities)

English | [简体中文](README.hans.md) | [繁體中文](README.hant.md) | [Esperanto](README.eo.md)

</div>

This is a collection of utilities for Windows 10 Linux Subsystem, such as retrieving Windows 10 environment variables or creating your favorite Linux GUI application shortcuts on Windows 10 Desktop.

Requires Windows 10 Creators Update; Some of the feature requires a higher version of Windows 10; Supports WSL2.

## Feature

**wslusc**

A WSL shortcut creator to create a shortcut on your Windows 10 Desktop.

**wslsys**

A WSL system information printer to print out system informations from Windows 10 or WSL.

**wslfetch**

A WSL screenshot information tool to print information in an elegant way.

**wslvar**

A WSL tool to help you get Windows system environment variables.

**wslview**

*With alias `wview/wslstart/wstart`*

A fake WSL browser that can help you open link in default Windows browser or open files on Windows.

**wslupath**

*⚠ Deprecated*

A WSL tool to convert path styles.

**wslact**

A set of quick actions for WSL such as quickly mounting all drives or manually sync time between Windows and WSL.


## Installation

### Alpine Linux

You can install `wslu` on **Alpine Linux 3.12+** with the following command:

```
sudo apk add wslu
```

### Arch Linux

> AUR version of `wslu` is pulled due to that it violated its policy.

Download the latest package from release and install using the command: `sudo pacman -U *.zst`

### CentOS/RHEL

Add the repository for the corresponding Linux distribution:

- **CentOS 7**: `sudo yum-config-manager --add-repo https://download.opensuse.org/repositories/home:/wslutilities/CentOS_7/home:wslutilities.repo`
- **CentOS 8**: `sudo yum-config-manager --add-repo https://download.opensuse.org/repositories/home:/wslutilities/CentOS_8/home:wslutilities.repo`
- **Red Hat Enterprise Linux 7**: `sudo yum-config-manager --add-repo https://download.opensuse.org/repositories/home:/wslutilities/RHEL_7/home:wslutilities.repo`

Then install with the command `sudo yum install wslu`.


### Debian

You can install `wslu` with the following command:

```
sudo apt install gnupg2 apt-transport-https
wget -O - https://pkg.wslutiliti.es/public.key | sudo tee -a /etc/apt/trusted.gpg.d/wslu.asc
echo "deb https://pkg.wslutiliti.es/debian buster main" | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo apt install wslu
```

### Fedora
```
sudo dnf copr enable wslutilities/wslu
sudo dnf install wslu
```

### Fedora Remix for WSL

Preinstalled.

### Kali Linux

You can install `wslu` with the following command:

```
sudo apt install gnupg2 apt-transport-https
wget -O - https://pkg.wslutiliti.es/public.key | sudo tee -a /etc/apt/trusted.gpg.d/wslu.asc
echo "deb https://pkg.wslutiliti.es/kali kali-rolling main" | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo apt install wslu
```

### Pengwin

Preinstalled.

### Pengwin Enterprise 7

You can install `wslu` with the following command:

```
sudo yum install wslu
```

### Ubuntu

> Attention!
>
> For Ubuntu version, you should not only report bug here but also report bug at [Launchpad](https://bugs.launchpad.net/ubuntu/+source/wslu).

Preinstalled in the latest apps. On older installations of Ubuntu please install `ubuntu-wsl` that depends on `wslu`:

```
sudo apt update
sudo apt install ubuntu-wsl
```

To install the latest version before `wslu` reaches `main` reporsitory, you can install via our PPA: <https://launchpad.net/~wslutilities/+archive/ubuntu/wslu>

### OpenSUSE

You can install `wslu` with the following command:

```
sudo zypper addrepo https://download.opensuse.org/repositories/home:/wslutilities/openSUSE_Leap_15.1/home:wslutilities.repo
sudo zypper up
sudo zypper in wslu
```

### SUSE Linux Enperprise Server

You can install `wslu` with the following command:

```
SLESCUR_VERSION="$(grep VERSION= /etc/os-release | sed -e s/VERSION=//g -e s/\"//g -e s/-/_/g)"
sudo zypper addrepo https://download.opensuse.org/repositories/home:/wslutilities/SLE_$SLESCUR_VERSION/home:wslutilities.repo
sudo zypper addrepo https://download.opensuse.org/repositories/graphics/SLE_12_SP3_Backports/graphics.repo
sudo zypper up
sudo zypper in wslu
```

### Other distributions

> **⚠ Not Recommend**
> 
> `curl | bash` method is not secure. [Related article](https://sandstorm.io/news/2015-09-24-is-curl-bash-insecure-pgp-verified-install)

You can install `wslu` with the following command on your preferred distribution: `curl -sL https://raw.githubusercontent.com/wslutilities/wslu/master/extras/scripts/wslu-install | bash`

## Contributors

This project exists thanks to all the people who contribute. [ [Contribute](CONTRIBUTING.md) ].
<img src="https://opencollective.com/wslu/contributors.svg?width=890&button=false" />

## License & Credits

<img width="150" src="https://www.gnu.org/graphics/gplv3-with-text-136x68.png">

This project uses [GPLv3](LICENSE) License.

Logo of WSL Utilities and icons for `wslusc` desktop shortcuts are licensed under [CC BY 4.0 International License](http://creativecommons.org/licenses/by/4.0/).

For other third party files and assets used, please refer to [THIRD_PARTY_LICENSE](THIRD_PARTY_LICENSE).
