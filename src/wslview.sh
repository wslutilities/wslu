# shellcheck shell=bash
version="06"

lname=""

help_short="$0 [-hvur]\n$0 LINK/FILE"

function del_reg_alt {
	if [ "$distro" == "archlinux" ] || [ "$distro" == "alpine" ]; then
		echo "${error} Unsupported action for this distro. Aborted. "
		exit 34
	else
		sudo update-alternatives --remove x-www-browser "$(readlink -f "$0")"
		sudo update-alternatives --remove www-browser "$(readlink -f "$0")"
		exit
	fi
}

function add_reg_alt {
	if [ "$distro" == "archlinux" ] || [ "$distro" == "alpine" ]; then
		echo "${error} Unsupported action for this distro. Aborted. "
		exit 34
	else
		sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser "$(readlink -f "$0")" 1
		sudo update-alternatives --install /usr/bin/www-browser www-browser "$(readlink -f "$0")" 1
		exit
	fi
}

for args; do
	case $args in
		-r|--reg-as-browser) add_reg_alt;;
		-u|--unreg-as-browser) del_reg_alt;;
		-h|--help) help "$0" "$help_short"; exit;;
		-v|--version) echo "wslu v$wslu_version; wslview v$version"; exit;;
		*) lname="$lname$args";;
	esac
done

if [[ "$lname" != "" ]]; then
	wslutmpbuild=$("$(interop_prefix)$(sysdrive_prefix)"/Windows/System32/reg.exe query "HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion" /v CurrentBuild | tail -n 2 | head -n 1 | sed -e 's|\r||g')
	wslutmpbuild=${wslutmpbuild##* }
	wslutmpbuild="$(( wslutmpbuild + 0 ))"
	# file:/// protocol used in linux
	if [[ "$lname" =~ ^file:\/\/\/[^:alpha:][^:][^/]* ]]; then
		if [ $wslutmpbuild -ge "$BN_MAY_NINETEEN" ]; then
			properfile_full_path="$(readlink -f "${lname//file:\/\//}")"
			converted_file_path="\\\\wsl\$\\$WSL_DISTRO_NAME${properfile_full_path//\//\\}"
			winps_exec Start "\"$converted_file_path\""
		else
			echo "${error} This protocol is not supported before version 1903."
			exit 34
		fi
	elif [[ $lname =~ ^(/[^/]+)*(/)?$ ]]; then
		if [ $wslutmpbuild -ge "$BN_MAY_NINETEEN" ]; then
			properfile_full_path="$(readlink -f "${lname}")"
			converted_file_path="\\\\wsl\$\\$WSL_DISTRO_NAME${properfile_full_path//\//\\}"
			winps_exec Start "\"$converted_file_path\""
		else
			echo "${error} This protocol is not supported before version 1903."
			exit 34
		fi
	else
		winps_exec Start "\"$lname\""
	fi
else
	echo "${error} No input, aborting"
	exit 21
fi
