# shellcheck shell=bash
version="40"

help_short="wslsys [-VIbBFUWRKPSlt] [-s]\nwslsys [-hv] [-n NAME]"

## Windows 10 information
function get_branch() {
	branch=$("$(interop_prefix)$(sysdrive_prefix)"/Windows/System32/reg.exe query "HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion" /v BuildBranch | tail -n 2 | head -n 1 | sed -e 's|\r||g')
	echo "${branch##* }"
}

function get_build() {
	build=$("$(interop_prefix)$(sysdrive_prefix)"/Windows/System32/reg.exe query "HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion" /v CurrentBuild | tail -n 2 | head -n 1 | sed -e 's|\r||g')
	echo "${build##* }"
}

function get_full_build() {
	full_build=$("$(interop_prefix)$(sysdrive_prefix)"/Windows/System32/reg.exe query "HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion" /v BuildLabEx | tail -n 2 | head -n 1 | sed -e 's|\r||g')
	echo "${full_build##* }"
}

function get_install_date() {
	installdate=$("$(interop_prefix)$(sysdrive_prefix)"/Windows/System32/reg.exe query "HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion" /v InstallDate | tail -n 2 | head -n 1 | sed -e 's|\r||g')
	echo "${installdate##* }"
}

function get_theme() {
	win_theme=$("$(interop_prefix)$(sysdrive_prefix)"/Windows/System32/reg.exe query "HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize" /v AppsUseLightTheme | tail -n 2 | head -n 1 | sed -e 's|\r||g')
	win_theme=${win_theme##* }
	if [ "$win_theme" != "0x1" ]; then
		echo "dark"
	else
		echo "light"
	fi
}

function get_display_scaling() {
	up_path="$(wslvar -s USERPROFILE)"
	wslu_file_check "$(wslpath "$up_path")/wslu" "get_dpi.ps1" "?!S"
	display_scaling="$(winps_exec "$(double_dash_p "$up_path")\\wslu\\get_dpi.ps1" | sed -e 's|\r||g')"
	bc -l <<< "$(printf "%d\n" "$display_scaling")/100" | sed -e "s/\.0//g" -e "s/0*$//g"
}

function get_windows_uptime() {
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
	wslutmpbuild="$(( $(get_build) + 0 ))"
	if [ $wslutmpbuild -ge $BN_MAY_NINETEEN ]; then
		# The environment variable only available in 19H1 or later.
		wslu_distro_regpath=$("$(interop_prefix)$(sysdrive_prefix)"/Windows/System32/reg.exe query "HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Lxss" /s /f DistributionName 2>&1 | grep -B1 -e "$WSL_DISTRO_NAME" | head -n1 | sed -e 's|\r||g')
		if "$(interop_prefix)$(sysdrive_prefix)"/Windows/System32/reg.exe query "$wslu_distro_regpath" /v Version &>/dev/null; then
			wslu_distro_version=$("$(interop_prefix)$(sysdrive_prefix)"/Windows/System32/reg.exe query "$wslu_distro_regpath" /v Version | tail -n 2 | head -n 1 | sed -e 's|\r||g')
			wslu_distro_version=${wslu_distro_version##* }
			if [ "$wslu_distro_version" != "0x2" ]; then
				echo "1"
			else
				echo "2"
			fi
		else
			echo "1"
		fi
	else
		echo "1"
	fi
}

function get_wsl_release() {
	release="$(grep "PRETTY_NAME=" /etc/os-release | sed -e 's/PRETTY_NAME=//g' -e 's/"//g')"
	##  old version of fedora remix specific information
	if [ "$distro" == "oldfedora" ]; then
		release="Fedora Remix $(grep -e "^VERSION=" /etc/os-release | sed -e 's/\"//g' | sed -e 's/VERSION=//g')"
	fi
	echo "$release"
}

function get_wsl_kernel() {
	echo "$(</proc/sys/kernel/ostype) $(</proc/sys/kernel/osrelease)"
}

function get_wsl_uptime() {
	uptime=$(</proc/uptime)
	uptime=${uptime//.*}
	days=$((uptime/86400))
	hours=$((uptime/3600%24))
	minutes=$((uptime/60%60))
	echo "${days}d ${hours}h ${minutes}m"
}

function get_wsl_packages() {
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
	echo "$packages"
}

## Simple printer defined for fetching information
function printer() {
	if [[ -n "$WSLSYS_WSLFETCH_COLOR" ]]; then
		echo "$WSLSYS_WSLFETCH_COLOR$1${reset}: $2"
	elif [[ -z "$WSLSYS_WSLFETCH_SHORTFORM" ]]; then
		echo "$1: $2"
	else
		echo "$2"
	fi
}

# function to find the value using the param/number/option passed
function dict_finder() {
	# this function should only have two input: the content ($1) and the shortform param ($2).
	# the dict looks like this:
	## num|short_param|long_param|option)
	##	printer "readable name" "value" "$2"
	##	return;;
	# num is used for empty input for iteration only
	# param are for parameter passing
	# option are for --wslfetch and --name
	local WSLSYS_WSLFETCH_SHORTFORM="$2"
	case $1 in
		1|-I|--sys-installdate|windows-install-date) 
			printer "Release Install Date" "$(get_install_date)"
			return;;
		2|-b|--branch|windows-rel-branch)
			printer "Branch" "$(get_branch)"
			return;;
		3|-B|--build|windows-build)
			printer "Build" "$(get_build)"
			return;;
		4|-F|--full-build|windows-full-build)
			printer "Full Build" "$(get_full_build)"
			return;;
		5|-S|--display-scaling|display-scaling)
			printer "Display Scaling" "$(get_display_scaling)"
			return;;
		6|-l|--locale|windows-locale)
			printer "Locale" "$(get_windows_locale)"
			return;;
		7|-t|--win-theme|windows-theme)
			printer "Windows Theme" "$(get_theme)"
			return;;
		8|-W|--win-uptime|windows-uptime)
			printer "Windows Uptime" "$(get_windows_uptime)"
			return;;
		9|-V|--wsl-version|wsl-version) 
			printer "WSL version" "$(get_wsl_version)"
			return;;
		10|-U|--uptime|wsl-uptime)
			printer "WSL Uptime" "$(get_wsl_uptime)"
			return;;
		11|-R|--release|wsl-release)
			printer "WSL Release" "$(get_wsl_release)"
			return;;
		12|-K|--kernel|wsl-kernel)
			printer "WSL Kernel" "$(get_wsl_kernel)"
			return;;
		13|-P|--package|wsl-package-count)
			printer "Packages" "$(get_wsl_packages)"
			return;;
		*) return 1;;
	esac
}

# main handler for wslsys
function wslsys_main() {
	# If input is empty, print everything available
	if [[ "$@" == "" ]]; then
		for i in {1..13}; do
			dict_finder $i
		done
		exit
	fi
	# If input start with --wslfetch, doing wslfetch specific print, not intend to use externally
	if [[ "$1" == "--wslfetch" ]]; then
		dict_finder "wsl-version" "-s"
		IFS=',' read -r -a fetch_array <<< "$2"
		for i in "${fetch_array[@]}"; do
			[[ "$i" == "wsl-version" ]] || WSLSYS_WSLFETCH_COLOR="$3" dict_finder $i
		done
		exit
	fi
	# If input start with --name, shift and use input instead
	if [[ "$1" == "--name" ]] || [[ "$1" == "-n" ]]; then
		shift
	fi
	# pass the param(or value) to dict_finder(), check return, if return -1, print error
	if ! dict_finder "$1" "$2"; then
		echo "${error} Invalid input."
		exit 22
	fi
}

# pre-handler
case $1 in
		-h|--help) help "$0" "$help_short"; exit;;
		-v|--version) echo "wslu v$wslu_version; wslsys v$version"; exit;;
		*) wslsys_main $@; exit;;
esac
