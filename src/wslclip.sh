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
    winps_exec "set-clipboard -value \"$content\""
else
    winps_exec "set-clipboard -value \"$PIPE\""
fi
