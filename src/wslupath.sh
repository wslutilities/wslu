# shellcheck shell=bash
##########   CAUTION   ###########
## wslupath is a legacy cli for backward compatbility.
## Use it unless it is necessary.

style=1
reg_path=0
set_path=""

help_short="wslupath [-dOr] [-D|-A|-T|-S|-W|-s|-su|-H|-P|...NAME...]\nwslupath [-h|-v|-R]"

function path_double_dash {
	new_path="${*//\\/\\\\}"
	echo "$new_path"
}

function general_converter {
	target="$*"

	if [[ $target =~ ^[A-Z]:(\\[^:\\]+)*(\\)?$ ]]; then
		p=$(wslpath -u "${target}")
	elif [[ $target =~ ^$(interop_prefix)[A-Za-z](/[^/]+)*(/)?$ ]]; then
		p=$(wslpath -w "${target}")
	else
		echo "${error} No proper path form detected: ""$*""."
		exit 20
	fi
	echo "$p"
}

function style_path {
	case $style in
		1) p="$(general_converter "$@")";;
		2) p="$*";;
		3) p="$(path_double_dash "$@")";;
	esac
	echo "$p"
}

if [[ $# -eq 0 ]]; then
	echo -e "$help_short"
	exit 20
else
	for args; do
		case $args in
			#styles
			-r|--reg-data) reg_path=1;;
			-O|--original) style=2;;
			-d|--doubledash-dir) style=3;;
			## system location

			-D|--desktop)
			set_path="$(style_path "$(wslvar -l 'Desktop')")"
			break;;
			-A|--appdata)
			set_path="$(style_path "$(wslvar -s APPDATA)")"
			break;;
			-T|--temp)
			set_path="$(style_path "$(wslvar -s TMP)")"
			break;;
			-S|--sysdir)
			set_path="$(style_path "$(wslvar -s windir)"\\System32)"
			break;;
			-W|--windir)
			set_path="$(style_path "$(wslvar -s windir)")"
			break;;
			-s|--start-menu)
			set_path="$(style_path "$(wslvar -l 'Start Menu')")"
			break;;
			-su|--startup)
			set_path="$(style_path "$(wslvar -l 'Startup')")"
			break;;
			-H|--home)
			set_path="$(style_path "$(wslvar HOMEDRIVE)""$(wslvar HOMEPATH)")"
			break;;
			-P|--program-files)
			set_path="$(style_path "$(wslvar -s ProgramFiles)")"
			break;;
			-h|--help) help "$0" "$help_short"; exit;;
			-v|--version) version; exit;;
			-R|--avail-reg) echo "Available registery input:"
			wslvar -L
			exit;;
			*)
			if [[ "$reg_path" == "1" ]]; then
				set_path="$(style_path "$(wslvar -l "$args")")"
			else
				set_path="$(style_path "$args")"
			fi
			break;;
		esac
	done
fi

if [[ "$set_path" == "" ]]; then
	echo "${error}No path input. Aborted."
	exit 21
else
	echo "$set_path"
fi
