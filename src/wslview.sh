version="01"

lname=""

help_short="wslview (-h|-v) ..LINK..."

for args; do
	case $args in
		-i|--init)sudo update-alternatives --install /usr/bin/www-browser www-browser /usr/bin/wslview 100; exit;;
		-s|--set)sudo update-alternatives --set www-browser /usr/bin/wslview; exit;;
		-r|--remove) sudo update-alternatives --remove www-browser /usr/bin/wslview; exit;;
		-h|--help) help $0 "$help_short"; exit;;
		-v|--version) echo "wslview v$wslu_version.$version"; exit;;
		*) lname=$args;;
	esac
done

if [[ "$lname" != "" ]]; then
	explorer.exe "$lname"
else
	echo "${error}No input, aborting"
	exit 21
fi
