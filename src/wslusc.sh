version="34"

cname=""
iconpath="$(double_dash_p "$(wslvar -s USERPROFILE)")\\wslu\\wsl.ico"
is_icon=0
is_gui=0
customname=""
customenv=""

help_short="wslusc (--env [PATH]|--name [NAME]|--icon [ICO FILE]|--gui|--help|--version) [COMMAND]"

while [ "$1" != "" ]; do
	case "$1" in
		-i|--icon)shift;is_icon=1;iconpath=$1;shift;;
		-n|--name)shift;customname=$1;shift;;
		-e|--env)shift;customenv=$1;shift;;
		-g|--gui)is_gui=1;shift;;
		-h|--help) help "$0" "$help_short"; exit;;
		-v|--version) echo "wslu v$wslu_version; wslusc v$version"; exit;;
		*) cname="$*";break;;
	esac
done
if [[ "$cname" != "" ]]; then
	tpath=$(double_dash_p "$(wslvar -s TMP)")
	dpath=$(wslpath "$(wslvar -l Desktop)")
	script_location="$(wslpath "$(wslvar -s USERPROFILE)")/wslu"
	localfile_path="/usr/share/wslu"
	script_location_win="$(double_dash_p "$(wslvar -s USERPROFILE)")\\wslu"
	
	new_cname=$(basename "$(echo "$cname" | awk '{print $1}')")
	if [[ "$customname" != "" ]]; then
		new_cname=$customname
	fi
	
	# Check default icon location
	if [[ ! -f $script_location/wsl.ico ]]; then
		echo "${warn} Default wslusc icon \"wsl.ico\" not found in Windows directory. Copying right now..."
		[[ -d $script_location ]] || mkdir "$script_location"
		if [[ -f $localfile_path/wsl.ico ]]; then
			cp "$localfile_path"/wsl.ico "$script_location"
			echo "${info} Default wslusc icon \"wsl.ico\" copied. Located at $script_location."
		else
			echo "${error} runHidden.vbs not found. Failed to copy."
			exit 30
		fi
	fi
	# Check presence of runHidden.vbs 
	if [[ ! -f $script_location/runHidden.vbs ]]; then
		echo "${warn} runHidden.vbs not found in Windows directory. Copying right now..."
		[[ -d $script_location ]] || mkdir "$script_location"
		if [[ -f $localfile_path/runHidden.vbs ]]; then
			cp "$localfile_path"/runHidden.vbs "$script_location"
			echo "${info} runHidden.vbs copied. Located at $script_location."
		else
			echo "${error} runHidden.vbs not found. Failed to copy."
			exit 30
		fi
	fi

	if [[ "$is_icon" == "1" ]]; then
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
					icon_filename="${icon_filename%.$ext}.ico"
				elif [[ "$ext" == "png" ]] || [[ "$ext" == "xpm" ]]; then
					echo "${info} Converting $ext icon to ico..."
					convert "$script_location/$icon_filename" -resize 256X256 "$script_location/${icon_filename%.$ext}.ico"
					icon_filename="${icon_filename%.$ext}.ico"
				else
					echo "${error} wslusc only support creating shortcut using .png/.svg/.ico icon. Aborted."
					exit 22
				fi
			fi
			iconpath="$script_location_win\\$icon_filename"
		fi
	fi
	
	if [[ "$customenv" != "" ]]; then
		echo "${info} the following custom variable/command will be applied: $customenv"
	fi

	if [[ "$is_gui" == "1" ]]; then
		winps_exec "Import-Module 'C:\\WINDOWS\\system32\\WindowsPowerShell\\v1.0\\Modules\\Microsoft.PowerShell.Utility\\Microsoft.PowerShell.Utility.psd1';\$s=(New-Object -COM WScript.Shell).CreateShortcut('$tpath\\$new_cname.lnk');\$s.TargetPath='C:\\Windows\\System32\\wscript.exe';\$s.Arguments='$script_location_win\\runHidden.vbs bash.exe -c \"cd ~; export DISPLAY=:0; $customenv $cname\"';\$s.IconLocation='$iconpath';\$s.Save();"
	else
		winps_exec "Import-Module 'C:\\WINDOWS\\system32\\WindowsPowerShell\\v1.0\\Modules\\Microsoft.PowerShell.Utility\\Microsoft.PowerShell.Utility.psd1';\$s=(New-Object -COM WScript.Shell).CreateShortcut('$tpath\\$new_cname.lnk');\$s.TargetPath='C:\\Windows\\System32\\bash.exe';\$s.Arguments='-c \"cd ~; $customenv $cname\"';\$s.IconLocation='$iconpath';\$s.Save();"
	fi
	tpath="$(wslpath "$(wslvar -s TMP)")/$new_cname.lnk"
	mv "$tpath" "$dpath"
	echo "${info} Create shortcut ${new_cname}.lnk successful"
else
	echo "${error}No input, aborting"
	exit 21
fi
