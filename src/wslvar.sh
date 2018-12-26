version="01"

style=1
reg_path=0
set_path=""

help_short="wslvar (-w) [-D|-A|-T|-S|-W|-s|-su|-H|-P|...NAME...]\nwslvar (-h|-v|-R)"

function path_double_dash
{
	new_path="$(echo $@ | sed -e 's|\\|\\\\|g')"
	echo $new_path
}

function reg_path_converter
{
	winps_exec "(Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders').'$@'" | cat
}

function style_path
{
	case $style in
		1)p="$(wslpath $@)";;
		2)p="$@";;
		3)p="$(path_double_dash $@)";;
	esac
	echo $p
}

if [[ $# -eq 0 ]]; then
	echo -e "$help_short"
	exit 20
else
	for args; do
		case $args in
			#styles
			-r|--reg-data)reg_path=1;;
            -w|--windows)style=2;;
            -d|--double-dash)style=3;;
			## system location

			-D|--desktop)
			set_path="$(style_path $(path_converter $(reg_path_converter 'Desktop')))"
			break;;
			-A|--appdata)
			set_path="$(style_path $(path_converter '%APPDATA%'))"
			break;;
			-T|--temp)
			set_path="$(style_path $(path_converter '%TMP%'))"
			break;;
			-S|--sysdir)
			set_path="$(style_path $(path_converter 'C:\Windows\System32'))"
			break;;
			-W|--windir)
			set_path="$(style_path $(path_converter 'C:\Windows'))"
			break;;
			-s|--start-menu)
			set_path="$(style_path $(path_converter $(reg_path_converter 'Start Menu')))"
			break;;
			-su|--startup)
			set_path="$(style_path $(path_converter $(reg_path_converter 'Startup')))"
			break;;
			-H|--home)
			set_path="$(style_path $(path_converter '%HOMEDRIVE%%HOMEPATH%'))"
			break;;
			-P|--program-files)
			set_path="$(style_path $(path_converter '%ProgramFiles%'))"
			break;;
			-h|--help) help $0 "$help_short"; exit;;
			-v|--version) echo "wslpath v$wslu_version.$version"; exit;;
			-R|--avail-reg) echo "Available registery input:"
			winps_exec "Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders'"| tail -n +3 | head -n -10
			exit;;
			*)
			if [[ "$reg_path" == "1" ]]; then
				set_path="$(style_path $(path_converter $(reg_path_converter $args)))"
			else
				set_path="$(style_path $args)"
			fi				
			break;;
		esac
	done
fi
if [[ "$set_path" == "" ]]; then
	echo "${error}No path input. Aborted."
	exit 21
else
	echo $set_path
fi
