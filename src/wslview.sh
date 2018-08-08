version="02"

lname=""

help_short="wslview (-h|-v) ..LINK..."

for args; do
	case $args in
		-h|--help) help $0 "$help_short"; exit;;
		-v|--version) echo "wslview v$wslu_version.$version"; exit;;
		*) lname="$lname$args";;
	esac
done

if [[ "$lname" != "" ]]; then
	explorer.exe "$lname"
else
	echo "${error}No input, aborting"
	exit 21
fi
