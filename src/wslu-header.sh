#!/usr/bin/env bash
# wslu - Windows 10 linux Subsystem Utility Core
# Component of Windows 10 linux Subsystem Utility
# <https://github.com/patrick330602/wslu>

# Copyleft 2018 Patrick Wu J M <wotingwu@live.com>

# data segment
wslu_version=1.4

## color
black=`echo -e '\e[30m'`
red=`echo -e '\e[31m'`
green=`echo -e '\e[32m'`
brown=`echo -e '\e[33m'`
blue=`echo -e '\e[34m'`
purple=`echo -e '\e[35m'`
cyan=`echo -e '\e[36m'`
yellow=`echo -e '\e[1;33m'`
white=`echo -e '\e[1;37m'`
dark_gray=`echo -e '\e[1;30m'`
light_red=`echo -e '\e[1;31m'`
light_green=`echo -e '\e[1;32m'`
light_blue=`echo -e '\e[1;34m'`
light_purple=`echo -e '\e[1;35m'`
light_cyan=`echo -e '\e[1;36m'`
light_gray=`echo -e '\e[37m'`
orange=`echo -e '\e[38;5;202m'`
light_orange=`echo -e '\e[38;5;214m'`
bold=`tput bold`
reset=`tput sgr0`

## indicator
info="${green}[info]${reset}"
error="${red}[error]${reset}"
warn="${orange}[warn]${reset}"
debug="${cyan}[debug]${reset}"

## constants
help_short="wslu (-h|-v|-s)"

## basic distro detection
distro="$(cat /etc/os-release | head -n1 | sed -e 's/NAME="//g')"
if [[ "$distro" == Ubuntu* ]]; then
	distro="ubuntu"
elif [[ "$distro" = *Debian* ]]; then
	distro="debian"
elif [[ "$distro" == *Kali* ]]; then
	distro="kali"
elif [[ "$distro" == openSUSE* ]]; then
	distro="opensuse"
elif [[ "$distro" == SLES* ]]; then
	distro="sles"
fi

function ins_locate
{
	[ -L /usr/bin/wslu ] && echo "$(dirname $(readlink -f /usr/bin/wslu))" || echo "/usr/bin"
}


function help
{
	echo -e "`basename "$1"` - Component of Windows 10 Linux Subsystem Utility
Usage: $2

For more help for `basename "$1"`, visit the following site:
https://github.com/patrick330602/wslu/wiki/`basename "$1"`"
}

# commands
## general
case $1 in
	-v|--version) echo "wslu v$wslu_version";;
	-h|--help) help $0 "$help_short";;
	-s|--silent);;
	*)echo "$help_short"; exit 20;;
esac
