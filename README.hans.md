<div align="center">

<img width="150" height="150" src="extras/icon.png">

# wslu - 一套Windows 10 Linux子系统工具组

[![GitHub license](https://badgen.net/github/license/wslutilities/wslu?icon=github&label=&color=cyan)](https://github.com/wslutilities/wslu/blob/master/LICENSE)
[![GitHub (pre-)release](https://badgen.net/github/release/wslutilities/wslu?icon=github&label=&color=yellow)](https://github.com/wslutilities/wslu)
[![Circle CI master](https://badgen.net/circleci/github/wslutilities/wslu/master?label=master&icon=circleci)](https://circleci.com/gh/wslutilities/wslu/tree/master)
[![Circle CI develop](https://badgen.net/circleci/github/wslutilities/wslu/develop?label=develop&icon=circleci)](https://circleci.com/gh/wslutilities/wslu/tree/develop)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fpatrick330602%2Fwslu.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fpatrick330602%2Fwslu?ref=badge_shield)
[![Donate](https://badgen.net/badge/Donate/Paypal/purple)](https://www.paypal.me/callmepk/)

[English](README.md) | 简体中文 | [繁體中文](README.hant.md)

</div>

这是一套适用于Windows 10 Linux子系统的工具组，可以在Windows 10 Linux子系统下完成诸如将Windows路径转换为WSL专属路径或者创建你最喜爱的Linux程序桌面快捷方式等工作。需要Windows 10创造者更新或更高。

**目前支持的Linux发行版：**
- [WLinux](https://afflnk.microsoft.com/c/1291904/433017/7593?u=https%3A%2F%2Fwww.microsoft.com%2Fstore%2FproductId%2F9NV1GV1PXZ6P)
- Ubuntu
- Ubuntu 16.04 LTS
- Ubuntu 18.04 LTS
- OpenSUSE Leap 42
- OpenSUSE 15.0
- SUSE Linux Enterprise Server 12
- SUSE Linux Enterprise Server 15 
- Debian GNU/Linux
- Kali Linux


旧版Ubuntu不再被支持。

## 功能

**wslusc**
这是用于创建Linux程序的Windows桌面快捷方式的工具。

**wslsys**
这是可以展示Windows和Linux下的系统信息的工具。

**wslfetch**
这是类似于screenfetch的系统信息展示工具。

**wslupath**
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

## 贡献（英文）

请查看[CONTRIBUTING.md](CONTRIBUTING.md)。

## 行为守则（英文）

请查看[CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)。

## 捐助

WSL Utilites是一套个人业余开发的项目。你的捐助可以让这个项目持续开发下去！ 

[![Sponsor](https://opencollective.com/wslu/tiers/sponsor/badge.svg?label=捐助者&color=brightgreen)](https://opencollective.com/wslu)
[![Backer](https://opencollective.com/wslu/tiers/backer/badge.svg?label=赞助者&color=brightgreen)](https://opencollective.com/wslu)
[![Paypal](https://badgen.net/badge/捐助/Paypal/purple)](https://www.paypal.me/callmepk/)

| 微信支付 | 支付宝 |
:-------: | :-----:
<img width="300" height="300" src="https://patrickwu.space/images/base/wechatpay.jpg"> | <img width="300" height="300" src="https://patrickwu.space/images/base/alipay.jpg"> 


## 许可（英文）

本应用使用了[LGPLv3](LICENSE)许可。

[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fpatrick330602%2Fwslu.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fpatrick330602%2Fwslu?ref=badge_large)

