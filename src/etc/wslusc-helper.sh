#!/bin/bash
#
# wslusc-helper.sh
# WSL Environment Control for WSL Shortcut Generator
# <https://github.com/wslutilities/wslu>
# Copyright (C) 2019 Patrick Wu
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

function interop_prefix {

	win_location="/mnt/"
	if [ -f /etc/wsl.conf ]; then
		tmp="$(awk -F '=' '/root/ {print $2}' /etc/wsl.conf | awk '{$1=$1;print}')"
		[ "$tmp" == "" ] || win_location="$tmp"
		unset tmp
	fi
	echo "$win_location"

	unset win_location
}

function sysdrive_prefix {
	win_location="$(interop_prefix)"
	hard_reset=0
	for pt in $(ls "$win_location"); do
		if [ $(echo "$pt" | wc -l) -eq 1 ]; then
			if [ -d "$win_location$pt/Windows/System32" ]; then
				hard_reset=1
				win_location="$pt"
				break
			fi
		fi 
	done

	if [ $hard_reset -eq 0 ]; then
		win_location="c"
	fi

	echo "$win_location"

	unset win_location
	unset hard_reset
}

if [[ -n $WSL_INTEROP ]]; then
  # enable external x display for WSL 2

  
  if ( command -v ipconfig.exe &>/dev/null ); then
    ipconfig_exec=$(command -v ipconfig.exe)
  else
    ipconfig_exec="$(interop_prefix)$(sysdrive_prefix)/Windows/System32/ipconfig.exe"
  fi

  if ( eval "$ipconfig_exec" | grep -n -m 1 "Default Gateway.*: [0-9a-z]" | cut -d : -f 1 ) >/dev/null; then
    set +H
    wsl2_d_tmp="$(eval "$ipconfig_exec" | grep -n -m 1 "Default Gateway.*: [0-9a-z]" | cut -d : -f 1)"
    wsl2_d_tmp="$(eval "$ipconfig_exec" | sed $(( wsl2_d_tmp - 4 ))','$(( wsl2_d_tmp + 0 ))'!d' | grep IPv4 | cut -d : -f 2 | sed -e "s|\s||g" -e "s|\r||g")"
    set -H
    export DISPLAY=${wsl2_d_tmp}:0.0
  else
    wsl2_d_tmp="$(grep nameserver /etc/resolv.conf | awk '{print $2}')"
    export DISPLAY=${wsl2_d_tmp}:0
  fi

  unset wsl2_d_tmp
  unset ipconfig_exec
else
    export DISPLAY=:0
fi

win_sys_scaling=$(wslsys -S -s)
export GDK_SCALE=$win_sys_scaling
export QT_SCALE_FACTOR=$win_sys_scaling
export GDK_DPI_SCALE=1

cd ~ || exit
bash -l -c "$*"