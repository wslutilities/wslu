#!/usr/bin/env bash
# wslusc - WSL shortcut creator
# Component of Windows 10 linux Subsystem Utility
# <https://github.com/patrick330602/wslu>

# Copyrleft 2018 Patrick Wu J M <wotingwu@live.com>

version="03"

cname=""
is_gui=0
. wslu --silent

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
	if [[ "$is_gui" == "1" ]]; then
		powershell.exe -NoProfile -NonInteractive -Command "\$s=(New-Object -COM WScript.Shell).CreateShortcut('$tpath\\$cname.lnk');\$s.TargetPath='C:\\Windows\\System32\\bash.exe';\$s.Arguments='-c \"cd ~ && DISPLAY=:0 $cname\"';\$s.Save();"
	else
		powershell.exe -NoProfile -NonInteractive -Command "\$s=(New-Object -COM WScript.Shell).CreateShortcut('$tpath\\$cname.lnk');\$s.TargetPath='C:\\Windows\\System32\\bash.exe';\$s.Arguments='-c \"cd ~ && $cname\"';\$s.Save();"
	fi
	tpath=`wslupath -T`
	mv $tpath/$cname.lnk $dpath
	echo "${info}Create shortcut ${cname}.lnk successful"
else
	echo "${error}No input, aborting"
	exit 21
fi
