#/bin/bash
# configure script for wslu

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
PATH="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/:$PATH"
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

function preinst_check {
distro="$(cat /etc/os-release | head -n1 | sed -e 's/NAME="//g')"
if [[ "$distro" == *WLinux* ]] || [[ "$distro" == Ubuntu* ]] || [[ "$distro" == *Debian* ]] || [[ "$distro" == *Kali* ]]; then
	sudo apt purge -y wlinux-wslu wslu
	sudo apt install -y git build-essential bc wget unzip make ruby-ronn imagemagick
elif [[ "$distro" == openSUSE* ]] || [[ "$distro" == SLES* ]]; then
	sudo zypper -n rm wslu
	sudo zypper -n install git bc wget unzip make rubygem-ronn imagemagick
elif [[ "$distro" == Alpine* ]]; then
	sudo apk add git bc wget unzip make bash-completion imagemagick
elif [[ "$distro" == Arch* ]]; then
	sudo pacman -Syyu git bc wget unzip make bash-completion imagemagick
fi
}

env_check
prsh_check
preinst_check