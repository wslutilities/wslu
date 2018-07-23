version="07"

cname=""
iconpath=""
is_icon=0
is_gui=0

help_short="wslusc (-i|-g|-h|-v) ..NAME..."

for args; do
	case $1 in
		-i|--icon)shift;is_icon=1;iconpath=$1;shift;;
		-g|--gui)is_gui=1;shift;;
		-h|--help) help $0 "$help_short"; exit;;
		-v|--version) echo "wslupath v$wslu_version.$version"; exit;;
		*) cname=$1;;
	esac
done
if [[ "$cname" != "" ]]; then
	tpath=`wslupath -d -T`
	dpath=`wslupath -D`
	new_cname=`basename $cname`
	if [[ "$is_gui" == "1" ]]; then
		script_location="`wslupath -H`/wslu"
		script_location_win="`wslupath -d -H`\\wslu"
		if [[ ! -f $script_location/runHidden.vbs ]]; then
			echo "${info} runHidden.vbs not found in Windows directory. Copying right now..."
			[[ -d $script_location ]] || mkdir $script_location
			if [[ -f /usr/share/wslu/runHidden.vbs ]]; then
				cp /usr/share/wslu/runHidden.vbs $script_location
				echo "${info} runHidden.vbs copied. Located at $script_location."
			else
				echo "${error} runHidden.vbs not found. Failed to copy."
				exit 30
			fi
		fi
		powershell.exe -NoProfile -NonInteractive -Command "\$s=(New-Object -COM WScript.Shell).CreateShortcut('$tpath\\$new_cname.lnk');\$s.TargetPath='C:\\Windows\\System32\\wscript.exe';\$s.Arguments='$script_location_win\\runHidden.vbs bash.exe -c \"cd ~ && DISPLAY=:0 $cname\"';\$s.Save();"
	else
		powershell.exe -NoProfile -NonInteractive -Command "\$s=(New-Object -COM WScript.Shell).CreateShortcut('$tpath\\$new_cname.lnk');\$s.TargetPath='C:\\Windows\\System32\\bash.exe';\$s.Arguments='-c \"cd ~ && $cname\"';\$s.Save();"
	fi
	tpath=`wslupath -T`
	mv $tpath/$new_cname.lnk $dpath
	echo "${info} Create shortcut ${new_cname}.lnk successful"
else
	echo "${error}No input, aborting"
	exit 21
fi
