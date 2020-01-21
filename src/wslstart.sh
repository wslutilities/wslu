version="01"

lname=""

help_short="wslstart (--help|--version) [LINK]"

for args; do
	case $args in
		-h|--help) help "$0" "$help_short"; exit;;
		-v|--version) echo "wslu v$wslu_version; wslview v$version"; exit;;
		*) lname="$lname$args";;
	esac
done

if [[ "$lname" != "" ]]; then
	winps_exec Start "\"$lname\""
else
	echo "${error}No input, aborting"
	exit 21
fi
