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

while read line; do
    winps_exec "set-clipboard -append -value $content"
done < "${cfile:-/dev/stdin}"

if [[ "$content" != "" ]]; then
    rm "$cfile"
fi
