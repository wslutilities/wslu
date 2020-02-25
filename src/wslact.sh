# shellcheck shell=bash
version="02"

help_short="wslact [flags] [command] ..."

function time_sync {
	if [ "$EUID" -ne 0 ]
		then echo "${error} \`wslact time-sync\` requires you to run as root. Aborted."
		exit 1
	fi
	while [ "$1" != "" ]; do
		case "$1" in
			-h|--help) help "wslact" "$help_short"; exit;;
			*) shift;;
		esac
	done
	echo "${info} Before Sync: $(date +"%d %b %Y %T %Z")"
	if date -s "$(winps_exec "Get-Date -UFormat \"%d %b %Y %T %Z\"" | tr -d "\r")" >/dev/null; then
		echo "${info} After Sync: $(date +"%d %b %Y %T %Z")"
		echo "${info} Manual Time Sync Complete."
	else
		echo "${error} Time Sync failed."
		exit 1
	fi
}

function smart_mount {
	if [ "$EUID" -ne 0 ]
		then echo "${error} \`wslact smart-mount\` requires you to run as root. Aborted."
		exit 1
	fi
	while [ "$1" != "" ]; do
		case "$1" in
			-h|--help) help "wslact" "$help_short"; exit;;
			*) shift;;
		esac
	done
	drive_list="$("$(interop_prefix)/$(sysdrive_prefix)"/WINDOWS/system32/fsutil.exe fsinfo drives | tail -1 | tr '[:upper:]' '[:lower:]' | tr -d ':\\' | sed -e 's/drives //g' -e 's|'$(sysdrive_prefix)' ||g' -e 's|\r||g' -e 's| $||g' -e 's| |\n|g')"
	mount_s=0
	mount_f=0
	mount_j=0
	for drive in $drive_list; do
		[[ -d "/mnt/$drive" ]] || mkdir -p "/mnt/$drive"
		if [[ -n $(find "/mnt/$drive" -maxdepth 0 -type d -empty) ]]; then
			echo "${info} Mounting $drive drive to /mnt/$drive..."
			if mount -t drvfs ${drive}: "/mnt/$drive"; then
				echo "${info} Mounted $drive drive to /mnt/$drive."
				mount_s=mount_s+1
			else
				echo "${error} Failed to mount $drive drive. Skipped."
				mount_f=mount_f+1
			fi
		else
			echo "${warn} Already mounted $drive drive at /mnt/$drive. Skipped."
			mount_j=mount_j+1
		fi
	done
	echo "${info} Smart mounting completed. $mount_s drive(s) succeed. $mount_f drive(s) failed. $mount_j drive(s) skipped."
}

while [ "$1" != "" ]; do
	case "$1" in
		sm|smart-mount) smart_mount "$@"; exit;;
		ts|time-sync) time_sync "$@"; exit;;
		-h|--help) help "$0" "$help_short"; exit;;
		-v|--version) echo "wslu v$wslu_version; wslact v$version"; exit;;
		*) echo "${error} Invalid Input. Aborted."; exit 22;;
	esac
done