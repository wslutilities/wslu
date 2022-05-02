#!/bin/bash
#shellcheck disable=SC2198,SC2124,SC2002,SC1001,SC2164,SC2072,SC2086,SC2035
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

function pkg_inst {
distro="$(head -n1 /etc/os-release | sed -e 's/NAME=\"//g')"
case $distro in
	*Pengwin*)
		sudo dpkg --force-depends --remove wslu
		sudo apt install -y git gzip make shellcheck bats
		;;
	*WLinux*|Ubuntu*|*Debian*|*Kali*)
		sudo apt purge -y wslu
		sudo apt install -y git bc gzip make imagemagick shellcheck bats
		;;
	openSUSE*|SLES*)
		sudo zypper -n rm wslu
		sudo zypper -n install git bc gzip make imagemagick ShellCheck
		;;
	Alpine*)
		sudo apk add git bc gzip make bash-completion imagemagick
		;;
	Arch*)
		sudo pacman -Syyu git bc gzip make bash-completion imagemagick shellcheck iproute2 --noconfirm
		;;
	*Oracle*|Scientific*)
		sudo yum install -y git bc gzip make bash-completion imagemagick iproute ShellCheck
		;;
	Alma*)
		sudo yum install -y git bc gzip make bash-completion ImageMagick iproute ShellCheck
		;;
	*Fedora*)
		sudo dnf install -y git bc gzip make bash-completion ImageMagick ShellCheck
		;;
	*Gentoo*)
		sudo emerge -a n sys-devel/bc media-gfx/imagemagick app-shells/bash-completion sys-devel/make dev-vcs/git app-arch/gzip dev-util/shellcheck
		;;
	*Generic*) [ "fedora" == "$(grep -e "LIKE=" /etc/os-release | sed -e 's/ID_LIKE=//g')" ] && sudo dnf install -y git bc gzip make bash-completion ImageMagick ShellCheck || exit 1;;
	*) exit 1;;
esac
}

function main_inst {
env_check
pkg_inst
make
sudo make DESTDIR=/usr install
}

function general_build_prep {
	sed -i s/VERSIONPLACEHOLDER/"$(cat ./VERSION)"/g ./src/wslu-header
}

function deb_build_prep {
	mkdir -p ./debian
	cp -r ./extras/build/debian/* ./debian
	chmod +x ./debian/rules
	sed -i s/DISTROPLACEHOLDER/"$*"/g ./debian/changelog
	sed -i s/VERSIONPLACEHOLDER/"$(cat ./VERSION)"/g ./debian/changelog
	sed -i s/DATETIMEPLACEHOLDER/"$(date +'%a, %d %b %Y %T %z')"/g ./debian/changelog
}

function rpm_build_prep {
	BUILD_VER_NUM=$(cat ./VERSION | cut -f1 -d-)
	REL_VER_NUM=$(cat ./VERSION | cut -f2 -d-)
	is_canary=""
	if [ "$@" = "obs_canary" ]; then
		FOR_BUILD="obs"
		is_canary="-canary"
	else
		FOR_BUILD="$@"
	fi

	sed -i s/BUILDVERPLACEHOLDER/"$BUILD_VER_NUM"/g ./extras/build/rpm/"$FOR_BUILD"/wslu.spec
	sed -i s/RELVERPLACEHOLDER/"$REL_VER_NUM"/g ./extras/build/rpm/"$FOR_BUILD"/wslu.spec
	sed -i s/DATETIMEPLACEHOLDER/"$(date +'%a %b %d %Y')"/g ./extras/build/rpm/"$FOR_BUILD"/wslu.spec
	sed -i s/Name\:\ wslu/Name\:\ wslu$is_canary/g ./extras/build/rpm/"$FOR_BUILD"/wslu.spec
	sed -i s/^Source\:\ wslu/Source\:\ wslu$is_canary/g ./extras/build/rpm/"$FOR_BUILD"/wslu.spec
	mkdir -p ../wslu$is_canary-$BUILD_VER_NUM/
	cp -r * ../wslu$is_canary-$BUILD_VER_NUM/
	cd ../
	tar -czvf wslu$is_canary-$BUILD_VER_NUM.tar.gz ./wslu$is_canary-$BUILD_VER_NUM
	cd ./wslu
}

for args; do
	case $args in
		--build) general_build_prep; exit;;
		--rpm) rpm_build_prep $2; exit;;
		--deb) deb_build_prep $2; exit;;
		-e|--env) env_check; exit;;
		-P|--pkg) pkg_inst; exit;;
		-i|--install) main_inst; exit;;
		*) exit 1;;
	esac
done

env_check; pkg_inst
