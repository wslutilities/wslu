version="37"

cname=""
iconpath=""
is_gui=0
is_interactive=0
customname=""
customenv=""

help_short="wslusc (--env [PATH]|--name [NAME]|--icon [ICO FILE]|--gui|--interactive|--help|--version) [COMMAND]"

while [ "$1" != "" ]; do
	case "$1" in
		-I|--interactive)is_interactive=1;shift;; 
		-i|--icon)shift;iconpath=$1;shift;;
		-n|--name)shift;customname=$1;shift;;
		-e|--env)shift;customenv=$1;shift;;
		-g|--gui)is_gui=1;shift;;
		-h|--help) help "$0" "$help_short"; exit;;
		-v|--version) echo "wslu v$wslu_version; wslusc v$version"; exit;;
		*) cname="$*";break;;
	esac
done

# interactive mode
if [[ $is_interactive -eq 1 ]]; then
	echo "${info} Welcome to wslu shortcut creator interactive mode."
	read -r -e -i "$cname" -p "${input_info} Command to execute: " input
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

if [[ "$cname" != "" ]]; then
	tpath=$(double_dash_p "$(wslvar -s TMP)") # Windows Temp, Win Double Sty.
	dpath=$(wslpath "$(wslvar -l Desktop)") # Windows Desktop, Win Sty.
	script_location="$(wslpath "$(wslvar -s USERPROFILE)")/wslu" # Windows wslu, Linux WSL Sty.
	localfile_path="/usr/share/wslu" # WSL wslu source file location, Linux Sty.
	script_location_win="$(double_dash_p "$(wslvar -s USERPROFILE)")\\wslu" #  Windows wslu, Win Double Sty.
	distro_location_win="$(double_dash_p "$(cat ~/.config/wslu/baseexec)")" # Distro Location, Win Double Sty.

	# change param according to the exec.
	distro_param="run"
	if [[ "$distro_location_win" == *wsl.exe* ]]; then
		distro_param="-e"
	fi

	# handling no name given case
	new_cname=$(basename "$(echo "$cname" | awk '{print $1}')")
	# handling name given case
	if [[ "$customname" != "" ]]; then
		new_cname=$customname
	fi

	# Check default icon and runHidden.vbs
	wslu_file_check "$script_location" "wsl.ico"
	wslu_file_check "$script_location" "runHidden.vbs"

	# handling icon
	if [[ "$iconpath" != "" ]]; then
		icon_filename="$(basename "$iconpath")"
		ext="${iconpath##*.}"

		if [[ ! -f $iconpath ]]; then
			iconpath="$(double_dash_p "$(wslvar -s USERPROFILE)")\\wslu\\wsl.ico"
			echo "${warn} Icon not found. Reset to default icon..."
		else
			echo "${info} You choose to use custom icon: $iconpath. Processing..."
			cp "$iconpath" "$script_location"
		
			if [[ "$ext" != "ico" ]]; then
				if [[ "$ext" == "svg" ]]; then
					echo "${info} Converting $ext icon to ico..."
					convert "$script_location/$icon_filename" -trim -background none -resize 256X256 -define 'icon:auto-resize=16,24,32,64,128,256'  "$script_location/${icon_filename%.$ext}.ico"
					rm "$script_location/$icon_filename"
					icon_filename="${icon_filename%.$ext}.ico"
				elif [[ "$ext" == "png" ]] || [[ "$ext" == "xpm" ]]; then
					echo "${info} Converting $ext icon to ico..."
					convert "$script_location/$icon_filename" -resize 256X256 "$script_location/${icon_filename%.$ext}.ico"
					rm "$script_location/$icon_filename"
					icon_filename="${icon_filename%.$ext}.ico"
				else
					echo "${error} wslusc only support creating shortcut using .png/.svg/.ico icon. Aborted."
					exit 22
				fi
			fi
			iconpath="$script_location_win\\$icon_filename"
		fi
	else
		iconpath="$(double_dash_p "$(wslvar -s USERPROFILE)")\\wslu\\wsl.ico"
	fi
	
	# handling custom vairable command
	if [[ "$customenv" != "" ]]; then
		echo "${info} the following custom variable/command will be applied: $customenv"
	fi

	if [[ "$is_gui" == "1" ]]; then
		winps_exec "Import-Module 'C:\\WINDOWS\\system32\\WindowsPowerShell\\v1.0\\Modules\\Microsoft.PowerShell.Utility\\Microsoft.PowerShell.Utility.psd1';\$s=(New-Object -COM WScript.Shell).CreateShortcut('$tpath\\$new_cname.lnk');\$s.TargetPath='C:\\Windows\\System32\\wscript.exe';\$s.Arguments='$script_location_win\\runHidden.vbs \"$distro_location_win\" $distro_param \"cd ~; export DISPLAY=:0; $customenv $cname\"';\$s.IconLocation='$iconpath';\$s.Save();"
	else
		winps_exec "Import-Module 'C:\\WINDOWS\\system32\\WindowsPowerShell\\v1.0\\Modules\\Microsoft.PowerShell.Utility\\Microsoft.PowerShell.Utility.psd1';\$s=(New-Object -COM WScript.Shell).CreateShortcut('$tpath\\$new_cname.lnk');\$s.TargetPath='\"$distro_location_win\"';\$s.Arguments='$distro_param \"cd ~; $customenv $cname\"';\$s.IconLocation='$iconpath';\$s.Save();"
	fi
	tpath="$(wslpath "$(wslvar -s TMP)")/$new_cname.lnk"
	mv "$tpath" "$dpath"
	echo "${info} Create shortcut ${new_cname}.lnk successful"
else
	echo "${error}No input, aborting"
	exit 21
fi
