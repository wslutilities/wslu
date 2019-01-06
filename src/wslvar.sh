version="01"

style=1
reg_path=0
set_path=""

help_short="wslvar (-r|-e) ...NAME...\nwslvar (-h|-v|-R|-E)"

function path_double_dash {
	new_path="$(echo $@ | sed -e 's|\\|\\\\|g')"
	echo $new_path
}

function call_reg {
	winps_exec "(Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders').'$@'" | cat
}

function call_env {
	winps_exec "Write-Output \$Env:$@" | cat
}

function cl_destoryer {

}