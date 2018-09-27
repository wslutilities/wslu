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
- Ubuntu
- Ubuntu 16.04
- Ubuntu 18.04
- OpenSUSE
- SUSE Linux Enterprise Server (SLES)
- Debian GNU/Linux
- Kali Linux
- [WLinux](https://afflnk.microsoft.com/c/1291904/433017/7593?u=https%3A%2F%2Fwww.microsoft.com%2Fstore%2FproductId%2F9NV1GV1PXZ6P)

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
wget -O - https://api.patrickwu.ml/public.key | sudo apt-key add -
echo "deb https://apt.patrickwu.ml/ stable main" | sudo tee -a /etc/apt/sources.list 
sudo apt update
sudo apt install wslu
```

或者你可以从Releases界面下载.deb进行安装：`sudo dpkg -i wslu*`。

### OpenSUSE/SLES

运行以下命令:
```bash
sudo zypper ar https://rpm.patrickwu.ml/ ruapm
sudo zypper ref
sudo zypper in wslu
```

或者你可以从Releases界面下载.rpm进行安装：`sudo rpm -ivh "wslu*"`。

## 贡献（英文）

请查看[CONTRIBUTING.md](CONTRIBUTING.md)。

## 行为守则（英文）

请查看[CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)。

## 后记

发现过了100个star也没加中文README。。。反而给[隔壁项目](https://afflnk.microsoft.com/c/1291904/433017/7593?u=https%3A%2F%2Fwww.microsoft.com%2Fstore%2FproductId%2F9NV1GV1PXZ6P)加了中文README，给自己扇几个耳光先(￣ε(#￣)☆╰╮o(￣皿￣///)

做项目不易，请我喝杯咖啡呗 (*´﹃\`)

| 微信支付 | 支付宝 |
:-------: | :-----:
<img width="300" height="300" src="https://patrickwu.ml/images/base/wechatpay.jpg"> | <img width="300" height="300" src="https://patrickwu.ml/images/base/alipay.jpg">

## 许可（英文）

<pre>
This is free software; you can redistribute it and/or modify
it under the terms of the GNU GPL version 3 or (at your option) any later version.
There is NO warranty; not even MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
</pre>

更长版本请查看[LICENSE](LICENSE)。

[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fpatrick330602%2Fwslu.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fpatrick330602%2Fwslu?ref=badge_large)

