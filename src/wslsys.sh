# shellcheck shell=bash
version="34"

help_short="wslsys [-VIbBFUWRKPSlt] [-s]\nwslsys [-hv]"

## Windows 10 information
function call_branch() {
	branch=$("$(interop_prefix)$(sysdrive_prefix)"/Windows/System32/reg.exe query "HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion" /v BuildBranch | tail -n 2 | head -n 1 | sed -e 's|\r||g')
	echo "${branch##* }"
}

function call_build() {
	build=$("$(interop_prefix)$(sysdrive_prefix)"/Windows/System32/reg.exe query "HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion" /v CurrentBuild | tail -n 2 | head -n 1 | sed -e 's|\r||g')
	echo "${build##* }"
}

function call_full_build() {
	full_build=$("$(interop_prefix)$(sysdrive_prefix)"/Windows/System32/reg.exe query "HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion" /v BuildLabEx | tail -n 2 | head -n 1 | sed -e 's|\r||g')
	echo "${full_build##* }"
}

function call_install_date() {
	installdate=$("$(interop_prefix)$(sysdrive_prefix)"/Windows/System32/reg.exe query "HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion" /v InstallDate | tail -n 2 | head -n 1 | sed -e 's|\r||g')
	echo "${installdate##* }"
}

function call_theme() {
	win_theme=$("$(interop_prefix)$(sysdrive_prefix)"/Windows/System32/reg.exe query "HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize" /v AppsUseLightTheme | tail -n 2 | head -n 1 | sed -e 's|\r||g')
	win_theme=${win_theme##* }
	if [ "$win_theme" != "0x1" ]; then
		echo "dark"
	else
		echo "light"
	fi
}

function call_display_scaling() {
	up_path="$(wslvar -s USERPROFILE)"
	wslu_file_check "$(wslpath "$up_path")/wslu" "get_dpi.ps1" "?!S"
	display_scaling="$(winps_exec "$(double_dash_p "$up_path")\\wslu\\get_dpi.ps1" | sed -e 's|\r||g')"
	bc -l <<< "$(printf "%d\n" "$display_scaling")/100" | sed -e "s/\.0//g" -e "s/0*$//g"
}

function call_windows_uptime() {
	win_uptime=$(winps_exec "((get-date) - (gcim Win32_OperatingSystem).LastBootUpTime).TotalSeconds" | sed -e 's|\r||g')
	win_uptime=${win_uptime//.*}
	w_days=$((win_uptime/86400))
	w_hours=$((win_uptime/3600%24))
	w_minutes=$((win_uptime/60%60))
	echo "${w_days}d ${w_hours}h ${w_minutes}m"
}

function get_windows_locale() {
	win_uptime=$(winps_exec "(Get-Culture).Name" | sed -e 's|\r||g' -e 's|-|_|g')
	echo "$win_uptime"
}

## WSL information

function get_wsl_version() {
	wslutmpbuild="$(( $(call_build) + 0 ))"
	if [ $wslutmpbuild -ge $BN_MAY_NINETEEN ]; then
		# The environment variable only available in 19H1 or later.
		wslu_distro_regpath=$("$(interop_prefix)$(sysdrive_prefix)"/Windows/System32/reg.exe query "HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Lxss" /s /f DistributionName 2>&1 | sed -e 's|\r||g' | grep -B1 -e "$WSL_DISTRO_NAME$" | head -n1 )
		if "$(interop_prefix)$(sysdrive_prefix)"/Windows/System32/reg.exe query "$wslu_distro_regpath" /v Flags &>/dev/null; then
			wslu_distro_version=$("$(interop_prefix)$(sysdrive_prefix)"/Windows/System32/reg.exe query "$wslu_distro_regpath" /v Flags | tail -n 2 | head -n 1 | sed -e 's|\r||g')
			wslu_distro_version=${wslu_distro_version##* }
			wslu_distro_version_processed=$(expr $(printf "%d\n" "0xf") / 8)
			if [ "$wslu_distro_version_processed" == "1" ]; then
				echo "2"
			elif [ "$wslu_distro_version_processed" == "0" ]; then
				echo "1"
			fi
		else
			echo "1"
		fi
	else
		echo "1"
	fi
}

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
		-V|--wsl--version) printer "WSL version" "$(get_wsl_version)" "$2";exit;;
		-I|--sys-installdate) printer "Release Install Date" "$(call_install_date)" "$2";exit;;
		-b|--branch) printer "Branch" "$(call_branch)" "$2";exit;;
		-B|--build) printer "Build" "$(call_build)" "$2";exit;;
		-F|--full-build) printer "Full Build" "$(call_full_build)" "$2";exit;;
		-U|--uptime) printer "WSL Uptime" "$uptime" "$2";exit;;
		-W|--win-uptime) printer "Windows Uptime" "$(call_windows_uptime)" "$2";exit;;
		-R|--release) printer "WSL Release" "$release" "$2";exit;;
		-K|--kernel) printer "WSL Kernel" "$kernel" "$2";exit;;
		-P|--package) printer "Packages Count" "$packages" "$2";exit;;
		-S|--display-scaling) printer "Display Scaling" "$(call_display_scaling)" "$2";exit;;
		-l|--locale) printer "Locale" "$(get_windows_locale)" "$2";exit;;
		-t|--win-theme) printer "Windows Theme" "$(call_theme)" "$2"; exit;;
		*) echo -e "WSL Version: $(get_wsl_version)\nLocale: $(get_windows_locale)\nRelease Install Date: $(date -d @"$(printf "%d" "$(call_install_date)")")\nBranch: $(call_branch)\nBuild: $(call_build)\nFull Build: $(call_full_build)\nDisplay Scaling: $(call_display_scaling)\nWindows Theme: $(call_theme)\nWindows Uptime: $(call_windows_uptime)\nWSL Uptime: $uptime\nWSL Release: $release\nWSL Kernel: $kernel\nPackages Count: $packages";exit;;
esac
