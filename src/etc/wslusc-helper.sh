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

if [[ -n $WSL_INTEROP ]]; then
  # enable external x display for WSL 2
  wsl2_d_tmp="$(grep nameserver /etc/resolv.conf | awk '{print $2}')"
  export DISPLAY=${wsl2_d_tmp}:0

  unset wsl2_d_tmp
else
  export DISPLAY=:0
fi

win_sys_scaling=$(wslsys -S -s)
export GDK_SCALE=$win_sys_scaling
export QT_SCALE_FACTOR=$win_sys_scaling
export GDK_DPI_SCALE=1

[ "$1" = "--no-cmd-mode" ] && exit 0
cd ~ || exit
bash -l -c "$*"