version="22"

help_short="wslsys (-h|-v|-S|-U|-b|-B|-fB|-R|-K|-P) -s"
branch=`reg.exe query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v "BuildBranch" 2>&1 | sed -n 3p | sed -e "s/BuildBranch//" | sed -e 's/^[[:space:]]*//' | awk '{$1=""; sub("  ", " "); print}' | sed -e 's|\r||g'`
build=`reg.exe query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v "CurrentBuild" 2>&1 | egrep -o '([0-9]{5})'`
full_build=`reg.exe query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v "BuildLabEx" 2>&1 | sed -n 3p | sed -e "s/BuildLabEx//" | sed -e 's/^[[:space:]]*//' | awk '{$1=""; sub("  ", " "); print}' | sed -e 's|\r||g'`
installdate=`reg.exe query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v "InstallDate" | egrep -o "(0x|0X)[a-fA-F0-9]+" | xargs printf "%d\n" | bc | xargs -I '{}' date --date="@{}"`
release="$(cat /etc/os-release | grep "PRETTY_NAME=" | sed -e 's/PRETTY_NAME=//g' -e 's/"//g')"
kernel="$(</proc/sys/kernel/ostype) $(</proc/sys/kernel/osrelease)"

uptime=$(</proc/uptime)
uptime=${uptime//.*}
days=$((${uptime}/86400))
hours=$((${uptime}/3600%24))
minutes=$((${uptime}/60%60))
uptime="${days}d ${hours}h ${minutes}m"

case "$distro" in
	'ubuntu'|'kali'|'debian'|'wlinux')
		packages="$((packages+=$(dpkg --get-selections | grep -cv deinstall$)))";;
	'opensuse'|'sles')
		packages="$(rpm -qa | wc -l)"
		;;
esac

function printer
{
	if [[ $2 != "-s" ]]; then
		echo $1
	else
		echo $1 | sed 's/^.*: //'
	fi
}

case $1 in
        -h|--help) help $0 "$help_short"; exit;;
	    -v|--version) echo "wslsys v$wslu_version.$version"; exit;;
		-I|--sys-installdate) printer "Release Install Date: $installdate" $2;exit;;
		-b|--branch) printer "Branch: $branch" $2;exit;;
		-B|--build) printer "Build: $build" $2;exit;;
		-fB|--full-build) printer "Full Build: $full_build" $2;exit;;
		-U|--uptime) printer "Uptime: $uptime" $2;exit;;
		-R|--release) printer "Linux Release: $release" $2;exit;;
		-K|--kernel) printer "Linux Kernel: $kernel" $2;exit;;
		-P|--package) printer "Packages Count: $packages" $2;exit;;
		*) echo -e "Release Install Date: $installdate\nBranch: $branch\nBuild: $build\nFull Build: $full_build\nUptime: $uptime\nLinux Release: $release\nLinux Kernel: $kernel\nPackages Count: $packages";exit;;
esac
