<div align="center">

<img width="150" height="150" src="extras/icon.png">

# wslu - 一套Windows 10 Linux子系统工具组

[![GitHub license](https://img.shields.io/github/license/wslutilities/wslu?style=flat-square&label=许可协议&color=blue&logo=github)](https://github.com/wslutilities/wslu/blob/master/LICENSE)
[![GitHub (pre-)release](https://img.shields.io/github/v/release/wslutilities/wslu?include_prereleases&label=版本&logo=github&style=flat-square)](https://github.com/wslutilities/wslu)
[![GitLab](https://img.shields.io/static/v1?label=gitlab&logo=gitlab&color=E24329&message=已镜像&style=flat-square)](https://gitlab.com/callmepk/wslu)
[![码云](https://img.shields.io/static/v1?label=码云&color=C71D23&message=已镜像&style=flat-square)](https://gitee.com/mirrors/wslu)
[![Twitter Follow](https://img.shields.io/twitter/follow/wslutilities?style=flat-square&logo=twitter&color=1DA1F2&label=关注)
](https://twitter.com/wslutilities)

[English](README.md) | 简体中文 | [繁體中文](README.hant.md)

</div>

这是一套适用于 Windows 10 Linux 子系统的工具组，可以在 Windows 10 Linux 子系统下完成诸如将 Windows 路径转换为 WSL 专属路径或者创建你最喜爱的 Linux 程序桌面快捷方式等工作。需要 Windows 10 创造者更新或更高。

## 功能

**wslusc**
用于创建 Linux 程序的 Windows 桌面快捷方式的工具。

**wslsys**
展示 Windows 和 Linux 下的系统信息的工具。

**wslfetch**
类似于 screenfetch 的系统信息展示工具。

**wslvar**
可以帮助你获取 Windows 系统常量的工具。

**wslview**
将 Windows 默认网络浏览器绑定为WSL网络浏览器的包装工具。

**wslupath** ⚠ *已弃用*
可以转换不同类型路径的工具。

## 状态

| | 服务 | Master | Develop |
| ------ | ------ |:------:|:-------:|
| 证书检查 | FOSSA | [![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fpatrick330602%2Fwslu.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fpatrick330602%2Fwslu%2develop?ref=badge_shield) | - |
| 代码质量 | CodeFactor | [![CodeFactor Grade Master](https://img.shields.io/codefactor/grade/github/wslutilities/wslu/master)](https://www.codefactor.io/repository/github/wslutilities/wslu/overview/master) | [![CodeFactor Grade Master](https://img.shields.io/codefactor/grade/github/wslutilities/wslu/develop)](https://www.codefactor.io/repository/github/wslutilities/wslu/overview/develop) |
| 测试 | AppVeyor | [![Build status](https://ci.appveyor.com/api/projects/status/gcttf7igb0s40xak/branch/master?svg=true)](https://ci.appveyor.com/project/patrick330602/wslu/branch/master) | [![Build status](https://ci.appveyor.com/api/projects/status/gcttf7igb0s40xak/branch/develop?svg=true)](https://ci.appveyor.com/project/patrick330602/wslu/branch/develop) |
| 部署 | CircleCI | [![CircleCI](https://img.shields.io/circleci/build/gh/wslutilities/wslu/master)](https://circleci.com/gh/wslutilities/wslu/tree/master) | [![CircleCI](https://img.shields.io/circleci/build/gh/wslutilities/wslu/develop)](https://circleci.com/gh/wslutilities/wslu/tree/develop) |

## 安装

### Pengwin/Fedora Remix

已内置。

### Ubuntu

最新版本已内置。针对旧版本的安装，请安装依赖于 wslu 的 ubuntu-wsl:

```
sudo apt update
sudo apt install ubuntu-wsl
```

### 基于Debian的分发版(Debian/Kali Linux)

你可以从 Releases 界面下载`.deb`进行安装：`sudo dpkg -i wslu*`。

#### Debian

你可以用以下命令进行安装：

```
curl -s https://packagecloud.io/install/repositories/whitewaterfoundry/wslu/script.deb.sh | sudo bash
```

### 基于RPM的分发版(OpenSUSE/SLES/Pengwin企业版/Oracle Linux)

你可以用以下命令进行安装：

```
curl -s https://packagecloud.io/install/repositories/whitewaterfoundry/wslu/script.rpm.sh | sudo bash
```

你也可以从 Releases 界面下载`.rpm`进行安装：`sudo rpm -ivh "wslu*"`。

### Arch Linux

wslu 已在 [AUR](https://aur.archlinux.org/packages/wslu/) 库中。你可以下载 *PKGBUILD* 手动安装或者使用 AUR 助手（比如 yay）进行安装。

### Alpine Linux

你可以从 Releases 界面下载`.apk`进行安装：`sudo apk add --allow-untrusted "wslu*"`.

### 其他发行版

> **⚠ 不建议**
> 
> `curl | bash`这种方法并不安全。 [相关文章](https://sandstorm.io/news/2015-09-24-is-curl-bash-insecure-pgp-verified-install)

在你想要安装的发行版下运行一下命令：`curl -sL https://wslu.patrickwu.space/install | bash`

## 贡献者

没有你们，这个项目不可能存在。[[为这项目作出贡献](CONTRIBUTING.md)]。
<img src="https://opencollective.com/wslu/contributors.svg?width=890&button=false" />

## 许可及版权（英文）

<img width="150" src="https://www.gnu.org/graphics/gplv3-with-text-136x68.png">

This project uses [GPLv3](LICENSE) License.

Logo of WSL Utilities is licensed under [CC BY-NC 4.0 International License](http://creativecommons.org/licenses/by-nc/4.0/).

For other third party files and assets used, please refer to [THIRD_PARTY_LICENSE](THIRD_PARTY_LICENSE).

