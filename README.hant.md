<div align="center">

<img width="150" height="150" src="extras/icon.png">

# wslu - 一套Windows 10 Linux子系統工具組

[![GitHub license](https://flat.badgen.net/github/license/wslutilities/wslu?icon=github&label=&color=cyan)](https://github.com/wslutilities/wslu/blob/master/LICENSE)
[![GitHub (pre-)release](https://flat.badgen.net/github/release/wslutilities/wslu?icon=github&label=)](https://github.com/wslutilities/wslu)
[![Circle CI master](https://flat.badgen.net/circleci/github/wslutilities/wslu/master?label=master&icon=circleci)](https://circleci.com/gh/wslutilities/wslu/tree/master)
[![Circle CI develop](https://flat.badgen.net/circleci/github/wslutilities/wslu/develop?label=develop&icon=circleci)](https://circleci.com/gh/wslutilities/wslu/tree/develop)
[![Donate](https://flat.badgen.net/badge/Donate/Paypal/purple)](https://www.paypal.me/callmepk/)
[![Backers on Open Collective](https://flat.badgen.net/opencollective/backers/wslu)](CONTRIBUTING.md#financial-contributions)
[![Chat On Gitter](https://flat.badgen.net/badge/chat/on%20gitter/cyan)](https://gitter.im/wslutilities/wslu)
[![Twitter](https://flat.badgen.net/twitter/follow/wslutilities)](https://twitter.com/wslutilities)

[English](README.md) | [简体中文](README.hans.md) | 繁體中文

</div>

這是一套適用於Windows 10 Linux子系統的工具組，可以在Windows 10 Linux子系統下完成諸如將Windows路徑轉換為WSL專屬路徑或者建立你最喜愛的Linux程式桌面快捷方式等工作。需要Windows 10創造者更新或更高。

## 功能

**wslusc**
用於建立 Linux 程式的 Windows 桌面快捷方式的工具。

**wslsys**
展示 Windows 和 Linux 下的系統資訊的工具。

**wslfetch**
類似於 screenfetch 的系統資訊展示工具。

**wslvar**
可以幫助你獲取 Windows 系統常量的工具。

**wslview**
將 Windows 預設網路瀏覽器繫結為WSL網路瀏覽器的包裝工具。

**wslupath** ⚠ *已棄用*
可以轉換不同類型路徑的工具。

## 安裝

### Pengwin/Fedora Remix

已內建。

### Ubuntu

最新版本已內建。針對舊版本的安裝，請安裝依賴於 wslu 的 ubuntu-wsl:

```
sudo apt update
sudo apt install ubuntu-wsl
```

### 基於Debian的分發版(Ubuntu/Debian/Kali Linux)

你可以從 Releases 介面下載`.deb`進行安裝：`sudo dpkg -i wslu*`。

#### Ubuntu/Debian

你可以用以下命令進行安裝：

```
curl -s https://packagecloud.io/install/repositories/whitewaterfoundry/wslu/script.deb.sh | sudo bash
```

### 基於RPM的分發版(OpenSUSE/SLES/Pengwin企業版/Oracle Linux)

你可以用以下命令進行安裝：

```
curl -s https://packagecloud.io/install/repositories/whitewaterfoundry/wslu/script.rpm.sh | sudo bash
```

你也可以從 Releases 介面下載`.rpm`進行安裝：`sudo rpm -ivh "wslu*"`。

### Arch Linux

wslu 已在 [AUR](https://aur.archlinux.org/packages/wslu/) 庫中。你可以下載 *PKGBUILD* 手動安裝或者使用 AUR 助手（比如 yay）進行安裝。

### Alpine Linux

你可以從 Releases 介面下載`.apk`進行安裝：`sudo apk add --allow-untrusted "wslu*"`.

### 其他發行版

> **⚠ 不建議**
> 
> `curl | bash`這種方法並不安全。 [相關文章](https://sandstorm.io/news/2015-09-24-is-curl-bash-insecure-pgp-verified-install)

在你想要安裝的發行版下執行一下命令：`curl -sL https://wslu.patrickwu.space/install | bash`

## 貢獻者

沒有你們，這個項目不可能存在。[[為這項目作出貢獻](CONTRIBUTING.md)]。
<img src="https://opencollective.com/wslu/contributors.svg?width=890&button=false" />

## 許可及版權（英文）

<img width="150" src="https://www.gnu.org/graphics/gplv3-with-text-136x68.png">

This project uses [GPLv3](LICENSE) License.

Logo of WSL Utilities is licensed under [CC BY-NC 4.0 International License](http://creativecommons.org/licenses/by-nc/4.0/).

### Assets

Tux logo used in `\src\etc\wsl.ico` was originally made by Larry Ewing in the Gimp and re-illustrated in vector by Garrett LeSage, using Inkscape.

Some of `wslfetch` ASCII Arts comes from [`neofetch`](https://github.com/dylanaraps/neofetch/) with [MIT](https://github.com/dylanaraps/neofetch/blob/master/LICENSE.md) License and [`screenFetch`](https://github.com/KittyKatt/screenFetch/) with [GPLv3](https://github.com/KittyKatt/screenFetch/blob/master/COPYING) License.

Pengwin Logo used in `wslfetch` ASCII art is ASCII version of the artwork by [Dennis D. Bednarz](https://twitter.com/DennisBednarz), with use permission from Whitewater Foundry.


WLinux Logo used in `wslfetch` ASCII art is ASCII version of the artwork by Larry Ewing.