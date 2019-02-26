<div align="center">

<img width="150" height="150" src="extras/icon.png">

# wslu - A collection of utilities for WSL

[![GitHub license](https://flat.badgen.net/github/license/wslutilities/wslu?icon=github&label=&color=cyan)](https://github.com/wslutilities/wslu/blob/master/LICENSE)
[![GitHub (pre-)release](https://flat.badgen.net/github/release/wslutilities/wslu?icon=github&label=)](https://github.com/wslutilities/wslu)
[![Circle CI master](https://flat.badgen.net/circleci/github/wslutilities/wslu/master?label=master&icon=circleci)](https://circleci.com/gh/wslutilities/wslu/tree/master)
[![Circle CI develop](https://flat.badgen.net/circleci/github/wslutilities/wslu/develop?label=develop&icon=circleci)](https://circleci.com/gh/wslutilities/wslu/tree/develop)
[![Donate](https://flat.badgen.net/badge/Donate/Paypal/purple)](https://www.paypal.me/callmepk/)
[![Backers on Open Collective](https://flat.badgen.net/opencollective/backers/wslu)](CONTRIBUTING.md#financial-contributions)
[![Chat On Gitter](https://flat.badgen.net/badge/chat/on%20gitter/cyan)](https://gitter.im/wslutilities/wslu)
[![Twitter](https://flat.badgen.net/twitter/follow/wslutilities)](https://twitter.com/wslutilities)

English | [简体中文](README.hans.md) | [繁體中文](README.hant.md)

</div>

This is a collection of utilities for Windows 10 Linux Subsystem, such as converting WSL path to Windows path or creating your favorite linux GUI application shortcuts on Windows 10 Desktop. Requires Windows 10 Creators Update.

## Feature

**wslusc**
A WSL shortcut creator to create a shortcut on your Windows 10 Desktop.

**wslsys**
A WSL system information printer to print out system informations from Windows 10 or Linux.

**wslfetch**
A WSL Screenshoot Information Tool to print information in an elegant way.

**wslvar**
A WSL tool to help you get Windows system environment variables.

**wslview**
A fake WSL browser that can help you open link in default Windows browser.

**wslupath** ⚠ *Deprecated*
A WSL tool to convert path styles.

## Installation

### WLinux/Fedora Remix

Preinstalled in WLinux and Fedora Remix for WSL.

### Ubuntu/Debian/Kali Linux

You can download the `.deb` package from release and install it using `sudo dpkg -i wslu*`.

### OpenSUSE/SLES/WLinux Enterprise

You can download the `.rpm` package from release and install it using `sudo rpm -ivh "wslu*"`.

### Arch Linux

wslu is live on [AUR](https://aur.archlinux.org/packages/wslu/). You can download *PKGBUILD* and install manually or install via PKGBUILD helpers like yay.

### Alpine Linux

You can download the `.apk` package from release and install it using `sudo apk add "wslu*"`.

### Other distributions

> **⚠ Not Recommend**
> 
> `curl | bash` method is not secure. [Related article](https://sandstorm.io/news/2015-09-24-is-curl-bash-insecure-pgp-verified-install)

Run the following command in your preferred distro: `curl -sL https://wslu.patrickwu.space/install | bash`

## Contributors

This project exists thanks to all the people who contribute. [[Contribute](CONTRIBUTING.md)].
<img src="https://opencollective.com/wslu/contributors.svg?width=890&button=false" />

## License

<img width="150" src="https://www.gnu.org/graphics/gplv3-with-text-136x68.png">

This project uses [GPLv3](LICENSE) License.
