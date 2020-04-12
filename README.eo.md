<div align="center">

<img width="150" height="150" src="extras/icon.png">

# wslu - kolekto de utilaĵoj por WSL

[![GitHub permesilo](https://img.shields.io/github/license/wslutilities/wslu?style=flat-square&label=permesilo&color=blue&logo=github)](https://github.com/wslutilities/wslu/blob/master/LICENSE)
[![GitHub (pre-)release](https://img.shields.io/github/v/release/wslutilities/wslu?include_prereleases&label=eldono&logo=github&style=flat-square)](https://github.com/wslutilities/wslu)
[![GitLab](https://img.shields.io/static/v1?label=gitlab&logo=gitlab&color=E24329&message=spegulita&style=flat-square)](https://gitlab.com/wslutilities/wslu)
[![Launchpad](https://img.shields.io/static/v1?label=launchpad&logo=launchpad&color=F8C300&message=spegulita&style=flat-square)](https://launchpad.net/wslu)
[![Gitee](https://img.shields.io/static/v1?label=gitee&color=C71D23&message=spegulita&style=flat-square)](https://gitee.com/mirrors/wslu)
[![Twitter Sekvo](https://img.shields.io/twitter/follow/wslutilities?style=flat-square&logo=twitter&color=1DA1F2&label=sekvi)](https://twitter.com/wslutilities)

[English](README.md) | [简体中文](README.hans.md) | [繁體中文](README.hant.md) | Esperanto

</div>

> This is still a beta translation. I am still learning Esperanto, so there will be mistakes.

Estas kolekto de utilaĵoj por Vindoza Subsistemo por Linukso (Windows Subsystem for Linux, WSL), kiel ricevi Vindozajn medivariablojn aŭ krei viajn plej ŝatatajn Linuksajn Grafikinterfacajn aplikaĵojn ŝparvojojn sur Vindoza labortablo.

Deviĝi Vindozo 10 1703; Iom de funkciojn deviĝas pli alian version de Vindozo 10;Ankaŭ subteni WSL2.


## Funkcioj

**wslusc**

WSL ŝparvoja kreinto kiu kreas ŝparvojo sur via Vindoza labortablo.

**wslsys**

WSL sistema informa presilo kiu presilas sistemajn informojn el Vindozo 10 aŭ WSL.

**wslfetch**

WSL ekrankopia informa ilo kiu presilas informojn elegante.

**wslvar**

WSL ilo por helpi vin ricevi Vindozajn sistemajn medivariablojn.

**wslview**

*Kun simbola ligilo `wview/wslstart/wstart`*

Falsa WSL retumilo/foliumilo kiu povas helpi vin malfermi ligilojn en via defaŭlta Vindoza retumilon aŭ malfermi dosierojn sur Vindozo.

**wslupath**

*⚠ Evitinda*

WSL ilo kiu konvertas dosierindikojn.

**wslact**

Aro de rapidaj agoj por WSL, kiel repide surmeti ĉiuj Vindozajn diskingojn aŭ mane sinkronigi tempon inter Vindozo kaj WSL.

**wslgsu**

WSL ilo kiu helpas krei starta tasko por Linuksajn procezojn sur Vindozo.


## Instalo

### Alpine Linux

Oni povas instali `wslu` el **Alpine Linux testing** kun la jenaj komandoj:

```
$ echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing/" | sudo tee -a /etc/apk/repositories
$ sudo apk update
$ sudo apk add wslu@testing
```

### Arch Linux

[wslu](https://aur.archlinux.org/packages/wslu/) kaj [wslu-git](https://aur.archlinux.org/packages/wslu-git/) sur AUR.

### CentOS/RHEL

Aldonu la deponejon por la respondanta Linuksa distribuo:

- **CentOS 7**: `sudo yum-config-manager --add-repo https://download.opensuse.org/repositories/home:/wslutilities/CentOS_7/home:wslutilities.repo`
- **CentOS 8**: `sudo yum-config-manager --add-repo https://download.opensuse.org/repositories/home:/wslutilities/CentOS_8/home:wslutilities.repo`
- **Red Hat Enterprise Linux 7**: `sudo yum-config-manager --add-repo https://download.opensuse.org/repositories/home:/wslutilities/RHEL_7/home:wslutilities.repo`

Tiam instalu kun la komando `sudo yum install wslu`.


### Debian

Oni povas instali `wslu` kun la jenaj komandoj:

```
sudo apt install gnupg2 apt-transport-https
wget -O - https://access.patrickwu.space/wslu/public.asc | sudo apt-key add -
echo "deb https://access.patrickwu.space/wslu/debian buster main" | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo apt install wslu
```

### Fedora Remix

Oni povas instali `wslu` el **COPR** kun la jenaj komandoj:

```
sudo dnf copr enable wslutilities/wslu
sudo dnf install wslu
```

### Kali Linux

Oni povas instali `wslu` kun la jenaj komandoj:

```
sudo apt install gnupg2 apt-transport-https
wget -O - https://access.patrickwu.space/wslu/public.asc | sudo apt-key add -
echo "deb https://access.patrickwu.space/wslu/kali kali-rolling main" | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo apt install wslu
```

### Pengwin

Antaŭinstalita.

### Pengwin Enterprise

Oni povas instali `wslu` kun la jenaj komandoj:

```
sudo yum-config-manager --add-repo https://download.opensuse.org/repositories/home:/wslutilities/ScientificLinux_7/home:wslutilities.repo
sudo yum install wslu
```

### Ubuntu

> Attenu!
>
> La Ubuntu versio de `wslu` estas modifita versio. Oni devas raporti cimojn [ĉi tie](https://bugs.launchpad.net/ubuntu/+source/wslu).

Antaŭinstalita en la plej freŝa versio. Sur pli aĝaj instaloj de Ubuntu, oni povas instali `ubuntu-wsl` kiu dependas de `wslu`:

```
sudo apt update
sudo apt install ubuntu-wsl
```

### OpenSUSE

Oni povas instali `wslu` kun la jenaj komandoj:

```
sudo zypper addrepo https://download.opensuse.org/repositories/home:/wslutilities/openSUSE_Leap_15.1/home:wslutilities.repo
sudo zypper up
sudo zypper in wslu`.
```

### SUSE Linux Enperprise Server

Oni povas instali `wslu` kun la jenaj komandoj:

```
SLESCUR_VERSION="$(grep VERSION= /etc/os-release | sed -e s/VERSION=//g -e s/\"//g -e s/-/_/g)"
sudo zypper addrepo https://download.opensuse.org/repositories/home:/wslutilities/SLE_$SLESCUR_VERSION/home:wslutilities.repo
sudo zypper addrepo https://download.opensuse.org/repositories/graphics/SLE_12_SP3_Backports/graphics.repo
sudo zypper up
sudo zypper in wslu
```

### Aliaj Distribuoj

> **⚠ Ne Rekomendu**
> 
> La maniero `curl | bash` estas ne sekura. [Rilata atikolo (La angla)](https://sandstorm.io/news/2015-09-24-is-curl-bash-insecure-pgp-verified-install)

Oni povas instali `wslu` kun la jenaj komandoj sur via preferata distribuoj: `curl -sL https://raw.githubusercontent.com/wslutilities/wslu/master/extras/scripts/wslu-install | bash`

## Kontributanoj

Dankon por ĉiuj homoj kiu kontribuas kaj helpas ĉi tiu projekto ekzisti. [ [Kontribui](CONTRIBUTING.md) ].
<img src="https://opencollective.com/wslu/contributors.svg?width=890&button=false" />

## Permesilo & Agnosko

<img width="150" src="https://www.gnu.org/graphics/gplv3-with-text-136x68.png">

Ĉi tiu projekto uzas [GPLv3](LICENSE) Permesilo.

Emblemo de WSL Utilities kaj bildsimboloj por `wslusc` estas disponebla laŭ la permesilo [Krea Komunaĵo Atribuite 4.0 Tutmonda](http://creativecommons.org/licenses/by/4.0/).

Por aliaj uzataj dosieroj kaj havaĵoj de ekstera liveranto, bonvolu rilatu al [THIRD_PARTY_LICENSE](THIRD_PARTY_LICENSE).
