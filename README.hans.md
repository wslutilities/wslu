<div align="center">

<img width="150" height="150" src="extras/icon.png">

# wslu - 一套 Windows 10 Linux 子系统工具组

[![GitHub license](https://img.shields.io/github/license/wslutilities/wslu?style=flat-square&label=许可协议&color=blue&logo=github)](https://github.com/wslutilities/wslu/blob/master/LICENSE)
[![GitHub (pre-)release](https://img.shields.io/github/v/release/wslutilities/wslu?include_prereleases&label=版本&logo=github&style=flat-square)](https://github.com/wslutilities/wslu)
[![GitLab](https://img.shields.io/static/v1?label=gitlab&logo=gitlab&color=E24329&message=已镜像&style=flat-square)](https://gitlab.com/callmepk/wslu)
[![Launchpad](https://img.shields.io/static/v1?label=launchpad&logo=launchpad&color=F8C300&message=已镜像&style=flat-square)](https://launchpad.net/wslu)
[![码云](https://img.shields.io/static/v1?label=码云&color=C71D23&message=已镜像&style=flat-square)](https://gitee.com/mirrors/wslu)
[![Twitter Follow](https://img.shields.io/twitter/follow/wslutilities?style=flat-square&logo=twitter&color=1DA1F2&label=关注)
](https://twitter.com/wslutilities)

[English](README.md) | 简体中文 | [繁體中文](README.hant.md) | [Esperanto](README.eo.md)

</div>

这是一套适用于 Windows 10 Linux 子系统的工具组，可以在 Windows 10 Linux 子系统下完成诸如获取 Windows 环境变量或者创建你最喜爱的 Linux 程序桌面快捷方式等工作。

需要 Windows 10 创造者更新; 部分功能需要更高版本的Windows 10；支持 WSL2。

## 功能

**wslusc**

用于创建 Linux 程序的 Windows 桌面快捷方式的 WSL 工具。

**wslsys**

展示 Windows 和 WSL 下系统信息的 WSL 工具。

**wslfetch**

类似于 screenfetch 的 WSL 系统信息展示工具。

**wslvar**

可以帮助你获取 Windows 系统环境变量的 WSL 工具。

**wslview**

**拥有别名 `wview/wslstart/wstart`**

虚拟 WSL 浏览器，可以通过其在 Windows 默认网络浏览器打开链接或在 Windows 里打开 WSL 下的文件。

**wslupath**

*⚠ 已弃用*

可以转换不同路径类型的 WSL 工具。

**wslact**

一组 WSL 快速动作，如快速挂载所有硬盘或手动与 Windows 同步时间。

## 安装

### Alpine Linux

你可以用以下命令安装 `wslu`：

```
$ echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/community/" | sudo tee -a /etc/apk/repositories
$ sudo apk update
$ sudo apk add wslu@testing
```

### Arch Linux

AUR 上的 [wslu](https://aur.archlinux.org/packages/wslu/) 和 [wslu-git](https://aur.archlinux.org/packages/wslu-git/)。

### CentOS/RHEL

为相应的发行版添加仓库：

- **CentOS 7**: `sudo yum-config-manager --add-repo https://download.opensuse.org/repositories/home:/wslutilities/CentOS_7/home:wslutilities.repo`
- **CentOS 8**: `sudo yum-config-manager --add-repo https://download.opensuse.org/repositories/home:/wslutilities/CentOS_8/home:wslutilities.repo`
- **Red Hat Enterprise Linux 7**: `sudo yum-config-manager --add-repo https://download.opensuse.org/repositories/home:/wslutilities/RHEL_7/home:wslutilities.repo`

然后用以下命令 `sudo yum install wslu` 安装 `wslu`。


### Debian

你可以用以下命令安装 `wslu`：

```
sudo apt install gnupg2 apt-transport-https
wget -O - https://access.patrickwu.space/wslu/public.asc | sudo apt-key add -
echo "deb https://access.patrickwu.space/wslu/debian buster main" | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo apt install wslu
```

### Fedora Remix

你可以用以下命令从 `COPR` 安装 `wslu`：

```
sudo dnf copr enable wslutilities/wslu
sudo dnf install wslu
```

### Kali Linux

你可以用以下命令安装 `wslu`：

```
sudo apt install gnupg2 apt-transport-https
wget -O - https://access.patrickwu.space/wslu/public.asc | sudo apt-key add -
echo "deb https://access.patrickwu.space/wslu/kali kali-rolling main" | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo apt install wslu
```

### Pengwin

已预装。

### Pengwin Enterprise

你可以用以下命令安装 `wslu`：

```
sudo yum-config-manager --add-repo https://download.opensuse.org/repositories/home:/wslutilities/ScientificLinux_7/home:wslutilities.repo
sudo yum install wslu
```

### Ubuntu

> 注意!
>
> Ubuntu 版本的 `wslu` 为修改版。你需要在[此](https://bugs.launchpad.net/ubuntu/+source/wslu)反馈 Ubuntu 版问题。

最新版本已预装。针对旧版本的安装，请安装依赖于 wslu 的 ubuntu-wsl:

```
sudo apt update
sudo apt install ubuntu-wsl
```

### OpenSUSE

你可以用以下命令安装 `wslu`：

```
sudo zypper addrepo https://download.opensuse.org/repositories/home:/wslutilities/openSUSE_Leap_15.1/home:wslutilities.repo
sudo zypper up
sudo zypper in wslu
```

### SUSE Linux Enperprise Server

你可以用以下命令安装 `wslu`：

```
SLESCUR_VERSION="$(grep VERSION= /etc/os-release | sed -e s/VERSION=//g -e s/\"//g -e s/-/_/g)"
sudo zypper addrepo https://download.opensuse.org/repositories/home:/wslutilities/SLE_$SLESCUR_VERSION/home:wslutilities.repo
sudo zypper addrepo https://download.opensuse.org/repositories/graphics/SLE_12_SP3_Backports/graphics.repo
sudo zypper up
sudo zypper in wslu
```

### 其他发行版

> **⚠ 不建议**
> 
> `curl | bash` 这种方法并不安全。 [相关文章](https://sandstorm.io/news/2015-09-24-is-curl-bash-insecure-pgp-verified-install)

在你想要安装的发行版下运行以下命令：`curl -sL https://raw.githubusercontent.com/wslutilities/wslu/master/extras/scripts/wslu-install | bash`

## 贡献者

没有你们，这个项目不可能存在。[[为这项目作出贡献](CONTRIBUTING.md)]。
<img src="https://opencollective.com/wslu/contributors.svg?width=890&button=false" />

## 许可及版权

<img width="150" src="https://www.gnu.org/graphics/gplv3-with-text-136x68.png">

本项目使用 [GPLv3](LICENSE) 许可协议。

WSL Utilities 的图标及 `wslusc` 桌面快捷方式采用[知识共享署名-非商业性使用 4.0 国际许可协议](http://creativecommons.org/licenses/by-nc/4.0/)进行许可。

对于使用的第三方文件与资源，请参照 [THIRD_PARTY_LICENSE](THIRD_PARTY_LICENSE)。

