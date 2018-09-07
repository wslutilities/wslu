#!/usr/bin/env bash
ORI_PATH="$(pwd)"

if [[ -f /etc/fake-wsl-release ]]; then
	echo "You are using fake WSL Environment. This is for building and testing only."
elif [[ ! -f /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
	echo "Your distro do not support WSL Interopability. Installation Aborted."
	exit 1
fi

cat << EOF
Wslu Installation
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
		sudo apt install -y git build-essential bc wget unzip make
		;;
	'opensuse'|'sles')
		sudo zypper -n install git bc wget unzip make
		;;
esac
if [[ ! -f /etc/fake-wsl-release ]]; then
	echo -e "\nWSL Interopability\n*********************"
	cat /proc/sys/fs/binfmt_misc/WSLInterop
	echo ""
fi

ppep="`powershell.exe Get-ExecutionPolicy 2>&1 | tail -n1 | sed 's/\r$//'`"
echo -e "Powershell Execution Policy: $ppep"
if [[ "$ppep" = "Restricted" ]]; then
	cat << EOF
***************************************
               WARNING
***************************************
The execution policy for powershell.exe
is set to Restricted. You should set P-
owershell Execution Policy to Unrestri-
cted with a Powershell Prompt with Adm-
inistrator right:
   Set-ExecutionPolicy Unrestricted
Due to the limitation, it is not possi-
ble to invoke this command from Bash P-
rompt.
EOF
fi

if [ `pwd | grep wslu` ]; then
	cd ../
	CURRENT_PATH="$(pwd)"
else
	git clone https://github.com/patrick330602/wslu.git
	cd wslu
	CURRENT_PATH="$(pwd)"
fi

make
chmod +x $CURRENT_PATH/out/*


for f in out/wsl*; do
	bname="$(basename $f)"
   		sudo ln -s $CURRENT_PATH/$f /usr/bin/$bname;
	echo "$bname Installed.";
done

sudo cp $CURRENT_PATH/src/mime/* /usr/lib/mime/packages/
[ -d /usr/share/wslu ] || sudo mkdir /usr/share/wslu
sudo cp $CURRENT_PATH/src/etc/* /usr/share/wslu

sudo update-mime
sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/bin/wslview 1
sudo update-alternatives --install /usr/bin/www-browser www-browser /usr/bin/wslview 1

cat <<EOF
Installation Completed.

Keep in remind that the installation method is different from installing from the package; DO NOT INSTALL PACKAGE VERSION AFTERWARDS. IT WILL BREAK YOUR INSTALLATION.
EOF

cd $ORI_PATH
