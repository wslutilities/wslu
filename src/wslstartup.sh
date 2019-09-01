version="01"

help_short="wslstartup [OPTIONS} ..."

while [ "$1" != "" ]; do
	case "$1" in
		
		--gui-scaling) echo " export GDK_SCALE=$(wslsys -S -s); export QT_SCALE_FACTOR=$(wslsys -S -s); export GDK_DPI_SCALE=$(bc -l <<< "1/$(wslsys -S -s)" | sed -e "s|\.0||g" -e "s|0||g");";shift;;
		--gui-wsl1) echo " export DISPLAY=:0; export LIBGL_ALWAYS_INDIRECT=1; NO_AT_BRIDGE=1;";shift;;
		--gui-wsl2) echo " export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0; export LIBGL_ALWAYS_INDIRECT=1; NO_AT_BRIDGE=1;";shift;;
		--gpg) echo "export GPG_TTY=$(tty);";shift;;
		-h|--help) help "$0" "$help_short"; exit;;
		-v|--version) echo "wslu v$wslu_version; wslusc v$version"; exit;;
		*) break;;
	esac
done