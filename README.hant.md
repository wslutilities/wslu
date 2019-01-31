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
這是用於建立Linux程式Windows桌面捷徑的工具。

**wslsys**
這是可以展示Windows和Linux下的系統資訊的工具。

**wslfetch**
這是類似於screenfetch的系統資訊展示工具。

**wslvar**
這是可以幫助你獲取Windows系統常量的工具。

**wslview**
這是一個將Windows預設網路瀏覽器繫結為WSL網路瀏覽器的包裝工具。

## 安裝

### WLinux

WLinux已內建。

### Ubuntu/Debian/Kali Linux

你可以從Releases介面下載`.deb`進行安裝：`sudo dpkg -i wslu*`。

### OpenSUSE/SLES/WLinux Enterprise/Fedora Remix

你可以從Releases介面下載`.rpm`進行安裝：`sudo rpm -ivh "wslu*"`。

### 其他Distro

執行以下命令： `curl -sL https://wslu.patrickwu.space/install | bash`

## 貢獻者

沒有你們，這個項目不可能存在。[[為這項目作出貢獻](CONTRIBUTING.md)]。
<img src="https://opencollective.com/wslu/contributors.svg?width=890&button=false" />

## 許可（英文）

<img width="150" src="https://www.gnu.org/graphics/gplv3-with-text-136x68.png">

本項目使用[GPLv3](LICENSE)許可。

