# shellcheck shell=bash
version="2"

content=""

help_short="$0 [-hvg]\n$0 CONTENT"

function get_clipboard {
    winps_exec "get-clipboard"
}

for args; do
	case $args in
		-h|--help) help "$0" "$help_short"; exit;;
		-v|--version) echo "wslu v$wslu_version; wslview v$version"; exit;;
        -g|--get) get_clipboard; exit;;
		*) content="${@}";;
	esac
done

if [[ "$content" != "" ]]; then
    cfile=$(mktemp /tmp/wslclip.XXXXXX)
    echo "$content" > "$cfile"

fi

cfile=${cfile:--}

while IFS= read -r line; do
    winps_exec "set-clipboard -append -value \"$line\""
done < <(cat -- "$cfile")

if [[ "$content" != "" ]]; then
    rm "$cfile"
fi
