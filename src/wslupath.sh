version="08"

style=1
reg_path=0
set_path=""

help_short="wslupath (-dOr) [-D|-A|-T|-S|-W|-s|-su|-H|-P|...NAME...]\nwslupath (-h|-v|-R)"

function path_double_dash {
	new_path="$(echo $@ | sed -e 's|\\|\\\\|g')"
	echo $new_path
}

function path_win {
	# TODO: Change this function to convert linux path to Windows path
	new_path="$(echo $@ | sed -e 's|/|\\|g' -e 's|^\\mnt\\\([A-Za-z]\)\\|\L\1\E:\\|')"
	echo $new_path
}

function path_linux {
	new_path="$(echo $@ | sed -e 's|\\|/|g' -e 's|^\([A-Za-z]\)\:/\(.*\)|/mnt/\L\1\E/\2|')"
	echo $new_path
}

function path_converter {
	new_path=`cmd.exe /c "echo $@" 2>&1 | tr -d "\r"`
	echo $new_path
}

function reg_path_converter {
	winps_exec "(Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders').'$@'" | cat
}

function general_converter {
	target="$@"
	if [[ $target =~ ^[A-Z]:(\\[^:\\]+)*(\\)?$ ]]; then
		p="$(path_linux $@)"
	elif [[ $target =~ ^/mnt/[A-Za-z](/[^/]+)*(/)?$ ]]; then
		p="$(path_win $@)"
	else
		echo "${error} No proper path form detected: $@."
		exit 20
	fi
	echo $p
}

function style_path {
	case $style in
		1)p="$(general_converter $@)";;
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
			-O|--original)style=2;;
			-d|--doubledash-dir)style=3;;
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
			-v|--version)echo "wslu v$wslu_version; wslupath v$version"; exit;;
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
