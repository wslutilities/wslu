# shellcheck shell=bash
version="1"

content=$(</dev/stdin)

help_short="$0 [-hvg]\n$0 CONTENT"

function get-clipboard {
    winps_exec "get-clipboard"
}

for args; do
	case $args in
		-h|--help) help "$0" "$help_short"; exit;;
		-v|--version) echo "wslu v$wslu_version; wslview v$version"; exit;;
        -g|--get) get-clipboard; exit;;
		*) content="$@";;
	esac
done

winps_exec "set-clipboard $content"