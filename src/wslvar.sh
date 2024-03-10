# shellcheck shell=bash
var_type=${WSLVAR_DEFAULT_VARTYPE:-1}

help_short="wslvar [-sl] NAME\nwslvar [-hvSL]"

function call_shell {
	winps_exec "(Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders').'$*'" | cat
}

function view_shell {
	winps_exec "Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders'"| tail -n +3 | head -n -10
}

function call_sys {
	winps_exec "Write-Output \${Env:$*}" | cat
}

function view_sys {
	winps_exec "Get-ChildItem env:" | tail -n +2 | head -n -2
}

function cl_destoryer {
	echo "$@" | tr -d "\r"
}

function caller {
	if [ "$*" != "" ]; then
		case $var_type in
			1) p="$(cl_destoryer "$(call_sys "$@")")";;
			2) p="$(cl_destoryer "$(call_shell "$@")")";;
			*) error_echo "Invalid variable type. Aborted." 22;;
		esac
		echo "$p"
	else
		error_echo "No Input. Aborted." 21
	fi
}

while [ "$1" != "" ]; do
	case "$1" in
		-s|--sys) var_type=1; shift;;
		-l|--shell) var_type=2; shift;;
		-S|--getsys) view_sys; exit;;
		-L|--getshell) view_shell; exit;;
		-h|--help) help "$0" "$help_short"; exit;;
		-v|--version) version; exit;;
		*) caller "$@"; exit;;
	esac
done

error_echo "No Input. Aborted." 21

