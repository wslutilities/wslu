<div align="center">

<img width="150" height="150" src="extras/icon.png">

# wslu - 一套Windows 10 Linux子系統工具組

[![GitHub license](https://flat.badgen.net/github/license/wslutilities/wslu?icon=github&label=&color=cyan)](https://github.com/wslutilities/wslu/blob/master/LICENSE)
[![GitHub (pre-)release](https://flat.badgen.net/github/release/wslutilities/wslu?icon=github&label=&color=yellow)](https://github.com/wslutilities/wslu)
[![Circle CI master](https://flat.badgen.net/circleci/github/wslutilities/wslu/master?label=master&icon=circleci)](https://circleci.com/gh/wslutilities/wslu/tree/master)
[![Circle CI develop](https://flat.badgen.net/circleci/github/wslutilities/wslu/develop?label=develop&icon=circleci)](https://circleci.com/gh/wslutilities/wslu/tree/develop)
[![Donate](https://flat.badgen.net/badge/Donate/Paypal/purple)](https://www.paypal.me/callmepk/)
[![Backers on Open Collective](https://flat.badgen.net/opencollective/backers/wslu)](CONTRIBUTING.md#financial-contributions)

[English](README.md) | [简体中文](README.hans.md) | 繁體中文

</div>

這是一套適用於Windows 10 Linux子系統的工具組，可以在Windows 10 Linux子系統下完成諸如將Windows路徑轉換為WSL專屬路徑或者建立你最喜愛的Linux程式桌面快捷方式等工作。需要Windows 10創造者更新或更高。

**目前支援的Linux發行版：**
- [WLinux](https://www.microsoft.com/store/productId/9NV1GV1PXZ6P)和其[企業版](https://www.microsoft.com/store/productId/9N8LP0X93VCP)
- Ubuntu[最新版](https://www.microsoft.com/store/productId/9NBLGGH4MSV6)，[16.04 LTS](https://www.microsoft.com/store/productId/9PJN388HP8C9)和[18.04 LTS](https://www.microsoft.com/store/productId/9N9TNGVNDL3Q)
- OpenSUSE Leap [42](https://www.microsoft.com/store/productId/9NJVJTS82TJX)和[15.0](https://www.microsoft.com/store/productId/9N1TB6FPVJ8C)
- SUSE Linux Enterprise Server [12](https://www.microsoft.com/store/productId/9P32MWBH6CNS)和[15](https://www.microsoft.com/store/productId/9PMW35D7FNLX)
- [Debian GNU/Linux](https://www.microsoft.com/store/productId/9MSVKQC78PK6)
- [Kali Linux](https://www.microsoft.com/store/productId/9PKR34TNCV07)
- 通過[ArchWSL](https://github.com/yuk7/ArchWSL)實現的Arch Linux
- 通過[AlpineWSL](https://github.com/yuk7/AlpineWSL)或[Alpine WSL](https://www.microsoft.com/store/productId/9P804CRF0395)實現的Alpine Linux

舊版Ubuntu不再被支援。

## 功能

**wslusc**
這是用於建立Linux程式Windows桌面捷徑的工具。

**wslsys**
這是可以展示Windows和Linux下的系統資訊的工具。

**wslfetch**
這是類似於screenfetch的系統資訊展示工具。

**wslvar**
這是用於轉換Windows/WSL路徑的工具。

**wslview**
這是一個將Windows預設網路瀏覽器繫結為WSL網路瀏覽器的包裝工具。

## 安裝

### WLinux

WLinux已內建。

### Ubuntu/Debian/Kali Linux

執行以下命令:
```bash
sudo apt install apt-transport-https
wget -O - https://api.patrickwu.space/public.key | sudo apt-key add -
echo "deb https://apt.patrickwu.space/ stable main" | sudo tee -a /etc/apt/sources.list 
sudo apt update
sudo apt install wslu
```

或者你可以從Releases介面下載.deb進行安裝：`sudo dpkg -i wslu*`。

### OpenSUSE/SLES

執行以下命令:執行以下命令:
```bash
sudo zypper ar https://rpm.patrickwu.space/ ruapm
sudo zypper ref
sudo zypper in wslu
```

或者你可以從Releases介面下載.rpm進行安裝：`sudo rpm -ivh "wslu*"`。

## 貢獻者

沒有你們，這個項目不可能存在。[[為這項目作出貢獻](CONTRIBUTING.md)]。
<img src="https://opencollective.com/wslu/contributors.svg?width=890&button=false" />

## 許可（英文）

<img width="150" src="https://www.gnu.org/graphics/gplv3-with-text-136x68.png">

本項目使用[GPLv3](LICENSE)許可。

