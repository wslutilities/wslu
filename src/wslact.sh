# shellcheck shell=bash
version="03"

help_short="wslact [flags] [command] ..."

function time_sync {
	local help_short="wslact time-sync (-h)"

	while [ "$1" != "" ]; do
		case "$1" in
			-h|--help) help "wslact" "$help_short"; exit;;
			*) shift;;
		esac
	done

	if [ "$EUID" -ne 0 ]
		then echo "${error} \`wslact time-sync\` requires you to run as root. Aborted."
		exit 1
	fi

	echo "${info} Before Sync: $(date +"%d %b %Y %T %Z")"
	if date -s "$(winps_exec "Get-Date -UFormat \"%d %b %Y %T %Z\"" | tr -d "\r")" >/dev/null; then
		echo "${info} After Sync: $(date +"%d %b %Y %T %Z")"
		echo "${info} Manual Time Sync Complete."
	else
		echo "${error} Time Sync failed."
		exit 1
	fi
}

while [ "$1" != "" ]; do
	case "$1" in
		ts|time-sync) time_sync "$@"; exit;;
		-h|--help) help "$0" "$help_short"; exit;;
		-v|--version) echo "wslu v$wslu_version; wslact v$version"; exit;;
		*) echo "${error} Invalid Input. Aborted."; exit 22;;
	esac
done