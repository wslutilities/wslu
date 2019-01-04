version="03"

lname=""

help_short="wslview (-u|-r|-h|-v) ...LINK..."

for args; do
	case $args in
		-r|--register) 
		sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/bin/wslview 1
		sudo update-alternatives --install /usr/bin/www-browser www-browser /usr/bin/wslview 1
		exit;;
		-u|--unregister)
		sudo update-alternatives --remove x-www-browser /usr/bin/wslview
		sudo update-alternatives --remove www-browser /usr/bin/wslview
		exit;;
		-h|--help) help $0 "$help_short"; exit;;
		-v|--version) echo "wslview v$wslu_version.$version"; exit;;
		*) lname="$lname$args";;
	esac
done

if [[ "$lname" != "" ]]; then
	winps_exec Start "$lname"
else
	echo "${error}No input, aborting"
	exit 21
fi
