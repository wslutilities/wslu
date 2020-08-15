<div align="center">

<img width="150" height="150" src="extras/icon.png">

# wslu - 一套 Windows 10 Linux 子系統工具組

[![GitHub license](https://img.shields.io/github/license/wslutilities/wslu?style=flat-square&label=授權條款&color=blue&logo=github)](https://github.com/wslutilities/wslu/blob/master/LICENSE)
[![GitHub (pre-)release](https://img.shields.io/github/v/release/wslutilities/wslu?include_prereleases&label=版本&logo=github&style=flat-square)](https://github.com/wslutilities/wslu)
[![GitLab](https://img.shields.io/static/v1?label=gitlab&logo=gitlab&color=E24329&message=已映象&style=flat-square)](https://gitlab.com/callmepk/wslu)
[![Launchpad](https://img.shields.io/static/v1?label=launchpad&logo=launchpad&color=F8C300&message=已映象&style=flat-square)](https://launchpad.net/wslu)
[![碼雲](https://img.shields.io/static/v1?label=碼雲&color=C71D23&message=已映象&style=flat-square)](https://gitee.com/mirrors/wslu)
[![Twitter Follow](https://img.shields.io/twitter/follow/wslutilities?style=flat-square&logo=twitter&color=1DA1F2&label=跟隨)
](https://twitter.com/wslutilities)

[English](README.md) | [简体中文](README.hans.md) | 繁體中文 | [Esperanto](README.eo.md)

</div>

這是一套適用於 Windows 10 Linux 子系統的工具組，可以在 Windows 10 Linux 子系統下完成諸如獲取 Windows 環境變數或者建立你最喜愛的 Linux 程式桌面捷徑等工作。

需要 Windows 10 創造者更新；部分功能需要更高版本的Windows 10；支援 WSL2。

## 功能

**wslusc**

用於建立 Linux 程式的 Windows 桌面捷徑的 WSL 工具。

**wslsys**

展示 Windows 和 WSL 下系統資訊的 WSL 工具。

**wslfetch**

類似於 screenfetch 的 WSL 系統資訊展示工具。

**wslvar**

可以幫助你獲取 Windows 系統環境變數的 WSL 工具。

**wslview**

**擁有別名 `wview/wslstart/wstart`**

虛擬 WSL 瀏覽器，可以通過其在 Windows 預設網路瀏覽器開啟連結或在 Windows 裡開啟 WSL 下的檔案。

**wslupath**

*⚠ 已棄用*

可以轉換不同路徑類型的 WSL 工具。

**wslact**

一組 WSL 快捷動作，如快速掛載所有硬碟或手動與 Windows 同步時間。


## 安装

### Alpine Linux

你可以用以下指令通過 **Alpine Linux 3.12+** 安裝 `wslu`：

```
sudo apk add wslu
```

### Arch Linux

AUR 上的 [wslu](https://aur.archlinux.org/packages/wslu/) 和 [wslu-git](https://aur.archlinux.org/packages/wslu-git/)。

### CentOS/RHEL

為相應的發行版新增倉庫：

- **CentOS 7**: `sudo yum-config-manager --add-repo https://download.opensuse.org/repositories/home:/wslutilities/CentOS_7/home:wslutilities.repo`
- **CentOS 8**: `sudo yum-config-manager --add-repo https://download.opensuse.org/repositories/home:/wslutilities/CentOS_8/home:wslutilities.repo`
- **Red Hat Enterprise Linux 7**: `sudo yum-config-manager --add-repo https://download.opensuse.org/repositories/home:/wslutilities/RHEL_7/home:wslutilities.repo`

然後用以下指令 `sudo yum install wslu` 安裝 `wslu`。


### Debian

你可以用以下指令安裝 `wslu`：

```
sudo apt install gnupg2 apt-transport-https
wget -O - https://access.patrickwu.space/wslu/public.asc | sudo apt-key add -
echo "deb https://access.patrickwu.space/wslu/debian buster main" | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo apt install wslu
```

### Fedora Remix

你可以用以下指令通過 `COPR` 安裝 `wslu`：

```
sudo dnf copr enable wslutilities/wslu
sudo dnf install wslu
```

### Kali Linux

你可以用以下指令安装 `wslu`：

```
sudo apt install gnupg2 apt-transport-https
wget -O - https://access.patrickwu.space/wslu/public.asc | sudo apt-key add -
echo "deb https://access.patrickwu.space/wslu/kali kali-rolling main" | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo apt install wslu
```

### Pengwin

已預載。

### Pengwin Enterprise

你可以用以下指令安装 `wslu`：

```
sudo yum-config-manager --add-repo https://download.opensuse.org/repositories/home:/wslutilities/ScientificLinux_7/home:wslutilities.repo
sudo yum install wslu
```

### Ubuntu

> 注意!
>
> Ubuntu 版本的 `wslu` 為修改版。你需要在[此](https://bugs.launchpad.net/ubuntu/+source/wslu)對 Ubuntu 版問題進行反饋。

最新版本已預載。針對舊版本的安裝，請安裝依賴於 wslu 的 ubuntu-wsl:

```
sudo apt update
sudo apt install ubuntu-wsl
```

### OpenSUSE

你可以用以下指令安装 `wslu`：

```
sudo zypper addrepo https://download.opensuse.org/repositories/home:/wslutilities/openSUSE_Leap_15.1/home:wslutilities.repo
sudo zypper up
sudo zypper in wslu
```

### SUSE Linux Enperprise Server

你可以用以下指令安装 `wslu`：

```
SLESCUR_VERSION="$(grep VERSION= /etc/os-release | sed -e s/VERSION=//g -e s/\"//g -e s/-/_/g)"
sudo zypper addrepo https://download.opensuse.org/repositories/home:/wslutilities/SLE_$SLESCUR_VERSION/home:wslutilities.repo
sudo zypper addrepo https://download.opensuse.org/repositories/graphics/SLE_12_SP3_Backports/graphics.repo
sudo zypper up
sudo zypper in wslu
```

### 其他發行版

> **⚠ 不建議**
> 
> `curl | bash` 這種方法並不安全。 [相關文章](https://sandstorm.io/news/2015-09-24-is-curl-bash-insecure-pgp-verified-install)

在你想要安裝的發行版下執行以下指令：`curl -sL https://raw.githubusercontent.com/wslutilities/wslu/master/extras/scripts/wslu-install | bash`

## 貢獻者

沒有你們，這個項目不可能存在。[[為這項目作出貢獻](CONTRIBUTING.md)]。
<img src="https://opencollective.com/wslu/contributors.svg?width=890&button=false" />

## 授權及版權

<img width="150" src="https://www.gnu.org/graphics/gplv3-with-text-136x68.png">

本項目使用 [GPLv3](LICENSE) 授權條款。

WSL Utilities 的圖示及 `wslusc` 桌面快捷方式係採用[創用 CC 姓名標示-非商業性 4.0 國際 授權條款](http://creativecommons.org/licenses/by-nc/4.0/)授權。

對於使用的第三方檔案與資源，請參照 [THIRD_PARTY_LICENSE](THIRD_PARTY_LICENSE)。
