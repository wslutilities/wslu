# shellcheck shell=bash
lname=""

help_short="$0 [-hvur]\n$0 [-E ENGINE] LINK/FILE"

function del_reg_alt {
	if [ "$distro" == "archlinux" ] || [ "$distro" == "alpine" ]; then
		error_echo "Unsupported action for this distro. Aborted." 34
		exit 34
	else
		sudo update-alternatives --remove x-www-browser "$(readlink -f "$0")"
		sudo update-alternatives --remove www-browser "$(readlink -f "$0")"
		exit
	fi
}

function add_reg_alt {
	if [ "$distro" == "archlinux" ] || [ "$distro" == "alpine" ]; then
		error_echo "Unsupported action for this distro. Aborted." 34
	else
		sudo update-alternatives --install "$wslu_prefix"/bin/x-www-browser x-www-browser "$(readlink -f "$0")" 1
		sudo update-alternatives --install "$wslu_prefix"/bin/www-browser www-browser "$(readlink -f "$0")" 1
		exit
	fi
}

WSLVIEW_DEFAULT_ENGINE="powershell"

while [ "$1" != "" ]; do
	case "$1" in
		-r|--reg-as-browser) add_reg_alt;;
		-u|--unreg-as-browser) del_reg_alt;;
		-h|--help) help "$0" "$help_short"; exit;;
		-v|--version) version; exit;;
		-E|--engine) WSLVIEW_DEFAULT_ENGINE="$2"; shift; shift;;
		*) lname="$*";break;;
	esac
done

debug_echo "lname: $lname"
debug_echo "WSLVIEW_DEFAULT_ENGINE: $WSLVIEW_DEFAULT_ENGINE"

if [[ "$lname" != "" ]]; then
	wslutmpbuild=$(wslu_get_build)
	# file:/// protocol used in linux
	if [[ "$lname" =~ ^file:\/\/.*$ ]] && [[ ! "$lname" =~ ^file:\/\/(\/)+[A-Za-z]\:.*$ ]]; then
		debug_echo "Received file:/// protocol used in linux"
		[ "$wslutmpbuild" -ge "$BN_MAY_NINETEEN" ] || error_echo "This protocol is not supported before version 1903." 34
		properfile_full_path="$(readlink -f "${lname//file:\/\//}")"
	# Linux absolute path
	elif [[ "$lname" =~ ^(/[^/]+)*(/)?$ ]]; then
		debug_echo "Received linux absolute path"
		[ "$wslutmpbuild" -ge "$BN_MAY_NINETEEN" ] || error_echo "This protocol is not supported before version 1903." 34
		properfile_full_path="$(readlink -f "${lname}")"
	# Linux relative path
	elif [[ -d "$(readlink -f "$lname")" ]] || [[ -f "$(readlink -f "$lname")" ]]; then
		debug_echo "Received linux relative path"
		[ "$wslutmpbuild" -ge "$BN_MAY_NINETEEN" ] || error_echo "This protocol is not supported before version 1903." 34
		properfile_full_path="$(readlink -f "${lname}")"
	fi
	debug_echo "properfile_full_path: $properfile_full_path"
	cmd="\"$(wslpath -w "${properfile_full_path:-$lname}" 2>/dev/null || echo "$lname")\""
	if [[ "$WSLVIEW_DEFAULT_ENGINE" == "powershell" ]]; then
		winps_exec Start "${cmd}"
	elif [[ "$WSLVIEW_DEFAULT_ENGINE" == "cmd" ]]; then
		cmd_exec start "${cmd}"
	elif [[ "$WSLVIEW_DEFAULT_ENGINE" == "cmd_explorer" ]]; then
		cmd_exec explorer.exe "${cmd}"
	fi
else
	error_echo "No input, aborting" 21
fi
