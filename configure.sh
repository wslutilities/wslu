#/bin/bash
# configure.sh
# configure script for wslu
# <https://github.com/wslutilities/wslu>
# Copyright (C) 2019 Patrick Wu
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

function interop_prefix {
	if [ -f /etc/wsl.conf ]; then
		tmp=$(awk -F '=' '/root/ {print $2}' /etc/wsl.conf)
		if [ "$tmp" == "" ]; then
			echo "/mnt/"
		else
			echo $tmp
		fi
	else
		echo "/mnt/"
	fi
}

function env_check {
if [ -f /etc/fake-wsl-release ]
then
    echo "[fake WSL Environment]"
elif [ ! -f /proc/sys/fs/binfmt_misc/WSLInterop ]
then
    echo "Your distro do not support WSL Interopability. Installation Aborted."
    exit 1
fi
}

function prsh_check {
PATH="$(interop_prefix)c/Windows/System32/WindowsPowerShell/v1.0/:$PATH"
powershell.exe -NoProfile -NonInteractive -Command Get-History
if [[ $? -eq 0 ]]; then
	echo "powershell.exe can be invoked."
else
	echo "powershell.exe failed to launch."
	exit 1
fi
ppep="`powershell.exe Get-ExecutionPolicy 2>&1 | tail -n1 | sed 's/\r$//'`"
echo -e "Powershell Execution Policy: $ppep"
if [[ "$ppep" = "Restricted" ]]; then
	cat << EOF
***************************************
               WARNING
***************************************
The execution policy for powershell.exe
should not be Restricted. You should se
t Powershell Execution Policy to Unrest
ricted with a Powershell Prompt with Ad
ministrator right:

   Set-ExecutionPolicy Unrestricted

Due to the limitation, it is not possib
le to invoke this command from WSL.
EOF
fi
PATH=$(getconf PATH)
}

function pkg_inst {
distro="$(cat /etc/os-release | head -n1 | sed -e 's/NAME=\"//g')"
case $distro in
	*WLinux*|Ubuntu*|*Debian*|*Kali*)
		sudo apt purge -y wslu
		sudo apt install -y git bc gzip make imagemagick
		;;
	openSUSE*|SLES*)
		sudo zypper -n rm wslu
		sudo zypper -n install git bc gzip make imagemagick
		;;
	Alpine*)
		sudo apk add git bc gzip make bash-completion imagemagick
		;;
    Arch*)
		sudo pacman -Syyu git bc gzip make bash-completion imagemagick
		;;
    Scientific*)
		sudo yum install -y git bc gzip make bash-completion imagemagick
		;;
    *Fedora*)
		sudo dnf install -y git bc gzip make bash-completion ImageMagick
		;;
	*Generic*) [ "fedora" == "$(cat /etc/os-release | grep -e "LIKE=" | sed -e 's/ID_LIKE=//g')" ] && sudo dnf install -y git || exit 1;;
    *) exit 1;;
esac
}

function main_inst {
env_check
prsh_check
pkg_inst
make
sudo make install
}

for args; do
	case $args in
		-e|--env) env_check; exit;;
		-p|--prsh) prsh_check; exit;;
		-P|--pkg) pkg_inst; exit;;
		-i|--install) main_inst; exit;;
		*) exit 1;;
	esac
done

env_check; prsh_check; pkg_inst
