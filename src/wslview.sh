version="06"

lname=""

help_short="wslview (--register|--unregister|--help|--version) [LINK]"

function del_reg_alt {
	if [ "$distro" == "archlinux" ] || [ "$distro" == "alpine" ]; then
		echo "${error}Unsupported action for this distro. Aborted. "
		exit 34
	else
		sudo update-alternatives --remove x-www-browser /usr/bin/wslview
		sudo update-alternatives --remove www-browser /usr/bin/wslview
		exit
	fi
}

function add_reg_alt {
	if [ "$distro" == "archlinux" ] || [ "$distro" == "alpine" ]; then
		echo "${error}Unsupported action for this distro. Aborted. "
		exit 34
	else
		sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/bin/wslview 1
		sudo update-alternatives --install /usr/bin/www-browser www-browser /usr/bin/wslview 1
		exit
	fi
}

for args; do
	case $args in
		-r|--register) add_reg_alt;;
		-u|--unregister) del_reg_alt;;
		-h|--help) help "$0" "$help_short"; exit;;
		-v|--version) echo "wslu v$wslu_version; wslview v$version"; exit;;
		*) lname="$lname$args";;
	esac
done

if [[ "$lname" != "" ]]; then
	if [[ "$lname" =~  file:///* ]]; then
		if [[ "$WSL_DISTRO_NAME" != "" ]]; then
			echo "do something"
		else
			echo "${error} This protocol is not supported before version 1903."
			exit 34
		fi
	else
		winps_exec Start "\"$lname\""
	fi
else
	echo "${error}No input, aborting"
	exit 21
fi
