<div align="center">

<img width="150" height="150" src="extras/icon.png">

# wslu - 一套Windows 10 Linux子系统工具组

[![GitHub license](https://flat.badgen.net/github/license/wslutilities/wslu?icon=github&label=&color=cyan)](https://github.com/wslutilities/wslu/blob/master/LICENSE)
[![GitHub (pre-)release](https://flat.badgen.net/github/release/wslutilities/wslu?icon=github&label=&color=yellow)](https://github.com/wslutilities/wslu)
[![Circle CI master](https://flat.badgen.net/circleci/github/wslutilities/wslu/master?label=master&icon=circleci)](https://circleci.com/gh/wslutilities/wslu/tree/master)
[![Circle CI develop](https://flat.badgen.net/circleci/github/wslutilities/wslu/develop?label=develop&icon=circleci)](https://circleci.com/gh/wslutilities/wslu/tree/develop)
[![Donate](https://flat.badgen.net/badge/Donate/Paypal/purple)](https://www.paypal.me/callmepk/)
[![Backers on Open Collective](https://flat.badgen.net/opencollective/backers/wslu)](CONTRIBUTING.md#financial-contributions)

[English](README.md) | 简体中文 | [繁體中文](README.hant.md)

</div>

这是一套适用于Windows 10 Linux子系统的工具组，可以在Windows 10 Linux子系统下完成诸如将Windows路径转换为WSL专属路径或者创建你最喜爱的Linux程序桌面快捷方式等工作。需要Windows 10创造者更新或更高。

## 功能

**wslusc**
这是用于创建Linux程序的Windows桌面快捷方式的工具。

**wslsys**
这是可以展示Windows和Linux下的系统信息的工具。

**wslfetch**
这是类似于screenfetch的系统信息展示工具。

**wslvar**
这是用于转换Windows/WSL路径的工具。

**wslview**
这是一个将Windows默认网络浏览器绑定为WSL网络浏览器的包装工具。

## 安装

### WLinux

WLinux已内置。

### Ubuntu/Debian/Kali Linux

运行以下命令:
```bash
sudo apt install apt-transport-https
wget -O - https://api.patrickwu.space/public.key | sudo apt-key add -
echo "deb https://apt.patrickwu.space/ stable main" | sudo tee -a /etc/apt/sources.list 
sudo apt update
sudo apt install wslu
```

或者你可以从Releases界面下载.deb进行安装：`sudo dpkg -i wslu*`。

### OpenSUSE/SLES

运行以下命令:
```bash
sudo zypper ar https://rpm.patrickwu.space/ ruapm
sudo zypper ref
sudo zypper in wslu
```

或者你可以从Releases界面下载.rpm进行安装：`sudo rpm -ivh "wslu*"`。

## 贡献者

没有你们，这个项目不可能存在。[[为这项目作出贡献](CONTRIBUTING.md)]。
<img src="https://opencollective.com/wslu/contributors.svg?width=890&button=false" />


## 许可（英文）

<img width="150" src="https://www.gnu.org/graphics/gplv3-with-text-136x68.png">

本应用使用了[GPLv3](LICENSE)许可。

