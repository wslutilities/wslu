version="34"

help_short="wslsys (-h|-v|-I|-b|-B|-fB|-U|-R|-K|-P) -s"

## Windows 10 information
function call_branch() {
	branch=$("$(interop_prefix)"c/Windows/System32/reg.exe query "HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion" /v BuildBranch | tail -n 2 | head -n 1 | sed -e 's|\r||g')
	echo "${branch##* }"
}

function call_build() {
	build=$("$(interop_prefix)"c/Windows/System32/reg.exe query "HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion" /v CurrentBuild | tail -n 2 | head -n 1 | sed -e 's|\r||g')
	echo "${build##* }"
}

function call_full_build() {
	full_build=$("$(interop_prefix)"c/Windows/System32/reg.exe query "HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion" /v BuildLabEx | tail -n 2 | head -n 1 | sed -e 's|\r||g')
	echo "${full_build##* }"
}

function call_install_date() {
	installdate=$("$(interop_prefix)"c/Windows/System32/reg.exe query "HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion" /v InstallDate | tail -n 2 | head -n 1 | sed -e 's|\r||g')
	echo "${installdate##* }"
}

function call_display_scaling() {
	display_scaling=$("$(interop_prefix)"c/Windows/System32/reg.exe query "HKCU\\Control Panel\\Desktop\\WindowMetrics" /v AppliedDPI | tail -n 2 | head -n 1 | sed -e 's|\r||g')
	display_scaling=${display_scaling##* }
	echo "$(bc -l <<< "$(printf "%d\n" "$display_scaling")/96" | sed -e "s/\.0//g" -e "s/0*$//g")"
}

function call_windows_uptime() {
	win_uptime=$(winps_exec "((get-date) - (gcim Win32_OperatingSystem).LastBootUpTime).TotalSeconds" | sed -e 's|\r||g')
	win_uptime=${win_uptime//.*}
	w_days=$((win_uptime/86400))
	w_hours=$((win_uptime/3600%24))
	w_minutes=$((win_uptime/60%60))
	echo "${w_days}d ${w_hours}h ${w_minutes}m"
}

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
	'pengwin'|'ubuntu'|'kali'|'debian'|'wlinux')
		packages=$(dpkg -l | grep -c '^i');;
	'opensuse'|'sles'|'scilinux'|'oldfedora'|'fedora'|'oracle')
		packages=$(rpm -qa | wc -l);;
	'alpine')
		packages=$(apk info | wc -l);;
	'archlinux')
		packages=$(pacman -Qq | wc -l);;
esac

##  old version of fedora remix specific information
if [ "$distro" == "oldfedora" ]; then
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
		-I|--sys-installdate) printer "Release Install Date: $(call_install_date)" "$2";exit;;
		-b|--branch) printer "Branch" "$(call_branch)" "$2";exit;;
		-B|--build) printer "Build" "$(call_build)" "$2";exit;;
		-fB|--full-build) printer "Full Build" "$(call_full_build)" "$2";exit;;
		-U|--uptime) printer "WSL Uptime" "$uptime" "$2";exit;;
		-wU|--win-uptime) printer "Windows Uptime" "$(call_windows_uptime)" "$2";exit;;
		-R|--release) printer "WSL Release" "$release" "$2";exit;;
		-K|--kernel) printer "WSL Kernel" "$kernel" "$2";exit;;
		-P|--package) printer "Packages Count" "$packages" "$2";exit;;
		-S|--display-scaling) printer "Display Scaling" "$(call_display_scaling)" "$2";exit;;
		*) echo -e "Release Install Date: $(call_install_date)\nBranch: $(call_branch)\nBuild: $(call_build)\nFull Build: $(call_full_build)\nDisplay Scaling: $(call_display_scaling)\nWindows Uptime: $(call_windows_uptime)\nWSL Uptime: $uptime\nWSL Release: $release\nWSL Kernel: $kernel\nPackages Count: $packages";exit;;
esac
