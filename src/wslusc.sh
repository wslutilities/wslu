version="04"

cname=""
is_gui=0

help_short="wslusc (-g|-h|-v) ..NAME..."

for args; do
	case $args in
		-g|--gui)is_gui=1;;
		-h|--help) help $0 "$help_short"; exit;;
		-v|--version) echo "wslupath v$wslu_version.$version"; exit;;
		*) cname=$args;;
	esac
done
if [[ "$cname" != "" ]]; then
	tpath=`wslupath -d -T`
	dpath=`wslupath -D`
	new_cname=`basename $cname`
	if [[ "$is_gui" == "1" ]]; then
		script_location="`wslupath -H`/wslu/runHidden.vbs"
		if [[ -f $script_location ]]; then
			mkdir `wslupath -H`/wslu/
			if [[ -f /usr/share/wslu/runHidden.vbs ]]; then
				cp /usr/share/wslu/runHidden.vbs $script_location
			else
				echo "${error} runHidden.vbs not found. Failed to copy."
				exit 30
			fi
		fi
		powershell.exe -NoProfile -NonInteractive -Command "\$s=(New-Object -COM WScript.Shell).CreateShortcut('$tpath\\$new_cname.lnk');\$s.TargetPath='C:\\Windows\\System32\\bash.exe';\$s.Arguments='-c \"cd ~ && DISPLAY=:0 $cname\"';\$s.Save();"
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
