#!/usr/bin/env bash

CURRENT_PATH="$(pwd)"

if [[ ! -f /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
	echo "Your distro do not support WSL Interopability. Installation Aborted."
	exit 1
fi

cat << EOF
WSLU
---------------
Windows 10 Linux Subsystem Utilities
EOF

distro="$(cat /etc/os-release | head -n1 | sed -e 's/NAME="//g')"
if [[ "$distro" == Ubuntu* ]]; then
	distro="ubuntu"
elif [[ "$distro" == *Debian* ]]; then
	distro="debian"
elif [[ "$distro" == *Kali* ]]; then
	distro="kali"
elif [[ "$distro" == openSUSE* ]]; then
	distro="opensuse"
elif [[ "$distro" == SLES* ]]; then
	distro="sles"
fi

echo "You are using: $distro"

echo "Installing dependencies...."
case "$distro" in
	'ubuntu'|'debian'|'kali')
		sudo apt install -y git build-essential bc ppa-purge wget unzip lsb-release
		;;
	'opensuse')
		sudo zypper -n install git bc lsb-release hostname wget unzip
		;;
	'sles')
		sudo zypper -n install git bc lsb-release wget unzip
		;;
esac

echo -e "\nWSL Interopability\n*********************"
cat /proc/sys/fs/binfmt_misc/WSLInterop
echo ""

echo -e "\ntesting cmd.exe..."
cmd.exe /c ver
if [[ $? -eq 0 ]]; then
	echo "cmd.exe can be invoked."
else
	echo "cmd.exe failed to launch."
	exit 1
fi

echo -e "\ntesting reg.exe..."
reg.exe /? 
if [[ $? -eq 0 ]]; then
	echo "reg.exe can be invoked."
else
	echo "reg.exe failed to launch."
	exit 1
fi

git submodule init
git submodule update
extras/bats/libexec/bats tests/wslu.bats tests/wslsys.bats tests/wslusc.bats tests/wslupath.bats tests/wslfetch.bats tests/wslpkg.bats 

for f in src/wsl*; do
	bname="$(basename $f)"
   		sudo ln -s $CURRENT_PATH/$f /usr/bin/$bname;
	echo "exec $f linked to /usr/bin/$bname";
done
sudo ln -s $CURRENT_PATH/configure /usr/bin/wsluconf
echo "this file(./configure) has linked to /usr/bin/wsluconf."
echo "Installation Completed. If you want to configure wslu, please run 'wsluconf'."
