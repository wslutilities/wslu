version="28"

help_short="wslsys (-h|-v|-S|-U|-b|-B|-fB|-R|-K|-P) -s"

## Windows 10 information
branch=`$(interop_prefix)c/Windows/System32/reg.exe query "HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion" /v BuildBranch | tail -n 2 | head -n 1`
branch=${branch##* }
build=`$(interop_prefix)c/Windows/System32/reg.exe query "HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion" /v CurrentBuild | tail -n 2 | head -n 1`
build=${build##* }
full_build=`$(interop_prefix)c/Windows/System32/reg.exe query "HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion" /v BuildLabEx | tail -n 2 | head -n 1`
full_build=${full_build##* }
installdate=`$(interop_prefix)c/Windows/System32/reg.exe query "HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion" /v InstallDate | tail -n 2 | head -n 1`
installdate=${installdate##* }

## WSL information
release="$(grep "PRETTY_NAME=" /etc/os-release | sed -e 's/PRETTY_NAME=//g' -e 's/"//g')"
kernel="$(</proc/sys/kernel/ostype) $(</proc/sys/kernel/osrelease)"
uptime=$(</proc/uptime)
uptime=${uptime//.*}
days=$((uptime/86400))
hours=$((uptime/3600%24))
minutes=$((uptime/60%60))
uptime="${days}d ${hours}h ${minutes}m"

### WSL package information
case "$distro" in
	'ubuntu'|'kali'|'debian'|'wlinux')
		packages="$((packages+=$(dpkg --get-selections | grep -cv deinstall$)))";;
	'opensuse'|'sles'|'scilinux'|'fedora'|'oracle')
		packages="$(rpm -qa | wc -l)";;
	'alpine')
		packages=$(apk info | wc -l);;
	'archlinux')
		packages=$(pacman -Qq | wc -l);;
esac

## fedora remix specific information
if [ "$distro" == "fedora" ]; then
	release="Fedora Remix $(grep -e "^VERSION=" /etc/os-release | sed -e 's/\"//g' | sed -e 's/VERSION=//g')"
fi

## Simple printer defined for fetching information
function printer {
	if [[ $3 != "-s" ]]; then
		echo "$1: $2"
	else
		echo "$2"
	fi
}

case $1 in
		-h|--help) help "$0" "$help_short"; exit;;
		-v|--version) echo "wslu v$wslu_version; wslsys v$version"; exit;;
		-I|--sys-installdate) printer "Release Install Date: $installdate" $2;exit;;
		-b|--branch) printer "Branch" "$branch" $2;exit;;
		-B|--build) printer "Build" "$build" $2;exit;;
		-fB|--full-build) printer "Full Build" "$full_build" $2;exit;;
		-U|--uptime) printer "Uptime" "$uptime" $2;exit;;
		-R|--release) printer "Linux Release" "$release" $2;exit;;
		-K|--kernel) printer "Linux Kernel" "$kernel" $2;exit;;
		-P|--package) printer "Packages Count" "$packages" $2;exit;;
		*) echo -e "Release Install Date: $installdate\nBranch: $branch\nBuild: $build\nFull Build: $full_build\nUptime: $uptime\nLinux Release: $release\nLinux Kernel: $kernel\nPackages Count: $packages";exit;;
esac
