# shellcheck shell=bash
cname=""
iconpath=""
is_gui=0
is_interactive=0
customname=""
customenv=""
base_converter_engine=${WSLUSC_BASE_CONVERTER_ENGINE:-"imagemagick"}

help_short="wslusc [-IsgN] [-d SHORTCUT_FILE] [-e PATH] [-n NAME] [-i FILE] COMMAND\nwslusc [-hv]"

PARSED_ARGUMENTS=$(getopt -a -n "${wslu_util_name##*/}" -o hvd:Ie:n:i:gNs --long help,version,shortcut-debug:,interactive,path:,name:,icon:,gui,native,smart-icon -- "$@")
#shellcheck disable=SC2181
[ "$?" != "0" ] && help "$wslu_util_name" "$help_short"

function sc_debug {
	debug_echo "sc_debug: called with $*"
	dp="$(double_dash_p "$(wslvar -l Desktop)")"
	winps_exec "Import-Module 'C:\\WINDOWS\\system32\\WindowsPowerShell\\v1.0\\Modules\\Microsoft.PowerShell.Utility\\Microsoft.PowerShell.Utility.psd1';\$s=(New-Object -COM WScript.Shell).CreateShortcut('$dp\\$*');\$s;"
}

debug_echo "Parsed: $PARSED_ARGUMENTS"
eval set -- "$PARSED_ARGUMENTS"
while :
do
	case "$1" in
		-d|--shortcut-debug) shift; sc_debug "$@"; exit;;
		-I|--interactive) is_interactive=1;shift;; 
		-i|--icon) shift; iconpath=$1;shift;;
		-s|--smart-icon) shift; WSLUSC_SMART_ICON_DETECTION="true";shift;;
		-n|--name) shift;customname=$1;shift;;
		-e|--env) shift;customenv=$1;shift;;
		-g|--gui) is_gui=1;shift;;
		-N|--native) WSLUSC_GUITYPE="native";shift;;
		-h|--help) help "$0" "$help_short"; exit;;
		-v|--version) version; exit;;
		--) shift; cname_header="$1"; shift; cname="$*"; break;;
	esac
done
debug_echo "cname_header: $cname_header cname: $cname"
# interactive mode
if [[ $is_interactive -eq 1 ]]; then
	echo "${info} Welcome to wslu shortcut creator interactive mode."
	read -r -e -i "$cname_header" -p "${input_info} Command (Without Parameter): " input
	cname_header="${input:-$cname_header}"
	read -r -e -i "$cname" -p "${input_info} Command param: " input
	cname="${input:-$cname}"
	read -r -e -i "$customname" -p "${input_info} Shortcut name [optional, ENTER for default]: " input
	customname="${input:-$customname}"
	read -r -e -i "$is_gui" -p "${input_info} Is it a GUI application? [if yes, input 1; if no, input 0]: " input
	is_gui=$(( ${input:-$is_gui} + 0 ))
	read -r -e -i "$customenv" -p "${input_info} Pre-executed command [optional, ENTER for default]: " input
	customenv="${input:-$customenv}"
	read -r -e -i "$iconpath" -p "${input_info} Custom icon Linux path (support ico/png/xpm/svg) [optional, ENTER for default]: " input
	iconpath="${input:-$iconpath}"
fi

# supported gui check
if [ "$(wslu_get_build)" -lt 21332 ] && [[ "$gui_type" == "NATIVE" ]]; then
	error_echo "Your Windows 10 version do not support Native GUI, You need at least build 21332. Aborted" 35
fi

if [[ "$cname_header" != "" ]]; then
	up_path="$(wslvar -s USERPROFILE)"
	tpath=$(double_dash_p "$(wslvar -s TMP)") # Windows Temp, Win Double Sty.
	tpath="${tpath:-$(double_dash_p "$(wslvar -s TEMP)")}" # sometimes TMP is not set for some reason
	dpath=$(wslpath "$(wslvar -l Desktop)") # Windows Desktop, WSL Sty.
	script_location="$(wslpath "$up_path")/wslu" # Windows wslu, Linux WSL Sty.
	script_location_win="$(double_dash_p "$up_path")\\wslu" #  Windows wslu, Win Double Sty.
	distro_location_win="$(double_dash_p "$(cat "${wslu_state_dir}"/baseexec)")" # Distro Location, Win Double Sty.

	# change param according to the exec.
	distro_param="run"

	if [[ "$distro_location_win" == *wsl\.exe* ]]; then
		if [ "$(wslu_get_build)" -ge "$BN_MAY_NINETEEN" ]; then
			distro_param="-d $WSL_DISTRO_NAME -e"
		else
			distro_param="-e"
		fi
	fi
 
	# handling the execuable part, a.k.a., cname_header
	# always absolute path
	tmp_cname_header="$(readlink -f "$cname_header")"
	if [ ! -f "$tmp_cname_header" ]; then
		cname_header="$(command -v "$cname_header")"
	else
		cname_header="$tmp_cname_header"
	fi
	unset tmp_cname_header

	[ -z "$cname_header" ] && error_echo "Bad or invalid input; Aborting" 30

	# handling no name given case
	new_cname="${cname_header##*/}"
	# handling name given case
	if [[ "$customname" != "" ]]; then
		new_cname=$customname
	fi

	# construct full command
	#shellcheck disable=SC2001
	cname="\"$(echo "$cname_header" | sed "s| |\\\\ |g") $cname\""

	# Check default icon and runHidden.vbs
	wslu_file_check "$script_location" "wsl.ico"
	wslu_file_check "$script_location" "wsl-term.ico"
	wslu_file_check "$script_location" "wsl-gui.ico"
	wslu_file_check "$script_location" "runHidden.vbs"

	# handling icon
	if [[ "$iconpath" != "" ]] || [[ "$WSLUSC_SMART_ICON_DETECTION" == "true" ]]; then
		#handling smart icon first; always first 
		if [[ "$WSLUSC_SMART_ICON_DETECTION" == "true" ]]; then
			if wslpy_check; then
				tmp_fcname="${cname_header##*/}"
				iconpath="$(python3 -c "import wslpy.__internal__; print(wslpy.__internal__.find_icon(\"$tmp_fcname\"))")"
				echo "${info} Icon Detector found icon $tmp_fcname at: $iconpath"
			else
				echo "${warn} Icon Detector cannot find icon."
			fi
		fi

		# normal detection section
		icon_filename="${iconpath##*/}"
		ext="${iconpath##*.}"

		if [[ ! -f $iconpath ]]; then
			iconpath="$(double_dash_p "$up_path")\\wslu\\wsl.ico"
			echo "${warn} Icon not found. Reset to default icon..."
		else
			echo "${info} You choose to use custom icon: $iconpath. Processing..."
			cp "$iconpath" "$script_location"
		
			if [[ "$ext" != "ico" ]]; then
				if [[ "${base_converter_engine}" = "ffmpeg" ]] && ! type ffmpeg > /dev/null; then
					echo "The 'ffmpeg' command is needed for converting the icon with 'ffmpeg' Engine."
					if [ -x /usr/lib/command-not-found ]; then
						echo " It can be installed with:" >&2
						echo "" >&2
						/usr/lib/command-not-found ffmpeg 2>&1 | grep -E -v '(not found|^$)' >&2
					else
						echo "It can usally be installed in your package manager as 'ffmpeg'."
					fi
					exit 22
				elif ! type convert > /dev/null; then
					echo "The 'convert' command is needed for converting the icon with 'imagemagick' Engine."
					if [ -x /usr/lib/command-not-found ]; then
						echo " It can be installed with:" >&2
						echo "" >&2
						/usr/lib/command-not-found convert 2>&1 | grep -E -v '(not found|^$)' >&2
					else
						echo "It can usally be found in the imagemagick package, please install it."
					fi
					exit 22
				fi
				if [[ "${base_converter_engine}" = "ffmpeg" ]]; then
					if [[ "$ext" == "svg" ]]; then
						echo "${info} Converting $ext icon to ico..."
						echo "${warn} ffmpeg is not designed for converting svg to ico, the result may not be satisfactory."
						if ffmpeg -encoders | grep svg > /dev/null; then
							ffmpeg -hide_banner -loglevel panic -i "$script_location/$icon_filename" -width 256 -height 256 -keep_ar false -vf scale=256:256 "$script_location/${icon_filename%."$ext"}.ico"
						else
							error_echo "${warn} ffmpeg is not compiled with svg support, please compile it with svg support. Aborted." 22
						fi
						rm "$script_location/$icon_filename"
						icon_filename="${icon_filename%."$ext"}.ico"
					elif [[ "$ext" == "png" ]] || [[ "$ext" == "xpm" ]]; then
						echo "${info} Converting $ext icon to ico..."
						ffmpeg -hide_banner -loglevel panic -i "$script_location/$icon_filename" -vf scale=256:256 "$script_location/${icon_filename%."$ext"}.ico"
						rm "$script_location/$icon_filename"
						icon_filename="${icon_filename%."$ext"}.ico"
					else
						error_echo "wslusc only support creating shortcut using .png/.svg/.ico icon with ffmpeg engine. Aborted." 22
					fi
				else
					if [[ "$ext" == "svg" ]]; then
						echo "${info} Converting $ext icon to ico..."
						convert "$script_location/$icon_filename" -trim -background none -resize 256X256 -define 'icon:auto-resize=16,24,32,64,128,256'  "$script_location/${icon_filename%."$ext"}.ico"
						rm "$script_location/$icon_filename"
						icon_filename="${icon_filename%."$ext"}.ico"
					elif [[ "$ext" == "png" ]] || [[ "$ext" == "xpm" ]]; then
						echo "${info} Converting $ext icon to ico..."
						convert "$script_location/$icon_filename" -resize 256X256 "$script_location/${icon_filename%."$ext"}.ico"
						rm "$script_location/$icon_filename"
						icon_filename="${icon_filename%."$ext"}.ico"
					else
						error_echo "wslusc only support creating shortcut using .png/.svg/.xpm/.ico icon with imagemagick engine. Aborted." 22
					fi
				fi
			fi
			iconpath="$script_location_win\\$icon_filename"
		fi
	else
		if [[ "$is_gui" == "1" ]]; then
			iconpath="$(double_dash_p "$up_path")\\wslu\\wsl-gui.ico"
		else
			iconpath="$(double_dash_p "$up_path")\\wslu\\wsl-term.ico"
		fi
	fi
	
	# handling custom vairable command
	if [[ "$customenv" != "" ]]; then
		echo "${info} the following custom variable/command will be applied: $customenv"
	fi

	if [[ "$is_gui" == "1" ]]; then
		if [[ "$WSLUSC_GUITYPE" == "legacy" ]]; then
			winps_exec "Import-Module 'C:\\WINDOWS\\system32\\WindowsPowerShell\\v1.0\\Modules\\Microsoft.PowerShell.Utility\\Microsoft.PowerShell.Utility.psd1';\$s=(New-Object -COM WScript.Shell).CreateShortcut('$tpath\\$new_cname.lnk');\$s.TargetPath='C:\\Windows\\System32\\wscript.exe';\$s.Arguments='$script_location_win\\runHidden.vbs $distro_location_win $distro_param $customenv /usr/share/wslu/wslusc-helper.sh $cname';\$s.IconLocation='$iconpath';\$s.Save();"
		elif [[ "$WSLUSC_GUITYPE" == "native" ]]; then
					winps_exec "Import-Module 'C:\\WINDOWS\\system32\\WindowsPowerShell\\v1.0\\Modules\\Microsoft.PowerShell.Utility\\Microsoft.PowerShell.Utility.psd1';\$s=(New-Object -COM WScript.Shell).CreateShortcut('$tpath\\$new_cname.lnk');\$s.TargetPath='C:\\Windows\\System32\\wslg.exe';\$s.Arguments='~ -d $WSL_DISTRO_NAME $customenv $cname';\$s.IconLocation='$iconpath';\$s.Save();"
		else
			error_echo "bad GUI type, aborting" 22
		fi
	else
		winps_exec "Import-Module 'C:\\WINDOWS\\system32\\WindowsPowerShell\\v1.0\\Modules\\Microsoft.PowerShell.Utility\\Microsoft.PowerShell.Utility.psd1';\$s=(New-Object -COM WScript.Shell).CreateShortcut('$tpath\\$new_cname.lnk');\$s.TargetPath='$distro_location_win';\$s.Arguments='$distro_param $customenv bash -l -c $cname';\$s.IconLocation='$iconpath';\$s.Save();"
	fi
	tpath="$(wslpath "$tpath")/$new_cname.lnk"
	mv "$tpath" "$dpath"
	echo "${info} Create shortcut ${new_cname}.lnk successful"
else
	error_echo "No input, aborting" 21
fi
