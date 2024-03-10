# shellcheck shell=bash
lname=""
skip_validation_check=${WSLVIEW_SKIP_VALIDATION_CHECK:-1}

help_short="$0 [-ehsvurE]\n$0 [-E ENGINE] LINK/FILE"

function fileprotocoldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

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

function add_browser_export {
	# find all possible shell rc file and append export BROWSER="/usr/bin/wslview" at the end; if found existing export, comment it out
	# Define the shell rc files to search
	rc_files=(".bashrc" ".zshrc" ".kshrc" ".cshrc" ".tcshrc")

	# Loop over each file
	for rc_file in "${rc_files[@]}"; do
		# Check if the file exists
		if [ -f "$HOME/$rc_file" ]; then
			echo "Processing $rc_file..."

			# Comment out existing BROWSER export
			if grep -q "export BROWSER=" "$HOME/$rc_file"; then
				echo "Commenting out existing BROWSER export in $rc_file..."
				$SED -i 's/^export BROWSER=/#export BROWSER=/' "$HOME/$rc_file"
			fi

			# Append new BROWSER export
			echo "Appending new BROWSER export to $rc_file..."
			echo 'export BROWSER="/usr/bin/wslview"' >> "$HOME/$rc_file"
		fi
	done
}

function url_validator {
 content=$(curl --head --silent -g "$*" | head -n 1)
 if [ -n "$content" ]; then
 	return 0
 else
 	return 1
 fi
}


while [ "$1" != "" ]; do
	case "$1" in
		-s|--skip-validation-check) skip_validation_check=0; shift;;
		-r|--reg-as-browser) add_reg_alt;;
		-u|--unreg-as-browser) del_reg_alt;;
		-e|--export-as-browser) add_browser_export;;
		-h|--help) help "$0" "$help_short"; exit;;
		-v|--version) version; exit;;
		-E|--engine) shift; WSLVIEW_DEFAULT_ENGINE="$1"; shift;;
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
		# convert before set
		lname="$(fileprotocoldecode "$lname")"
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
	if [ "$skip_validation_check" -eq 0 ]; then
		debug_echo "Skipping validation check"
		is_valid_url=0
  	else
   		debug_echo "Validating whether if it is a link"
   		is_valid_url=$(url_validator "$lname")
	fi
	if [[ "$is_valid_url" -eq 0 ]] && [ -z "$properfile_full_path" ]; then
		debug_echo "It is a link"
		cmd="\"$lname\""
	elif [[ "$lname" =~ ^file:\/\/(\/)+[A-Za-z]\:.*$ ]] || [[ "$lname" =~ ^[A-Za-z]\:.*$ ]]; then
		debug_echo "It is not a link; received windows absolute path/file protocol windows absolute path"
		cmd="\"$lname\""
	else
		debug_echo "It is not a link"
		cmd="\"$(wslpath -w "${properfile_full_path:-$lname}" 2>/dev/null || echo "$lname")\""
	fi
	debug_echo "cmd: $cmd"
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
