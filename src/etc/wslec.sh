#!/bin/bash
#
# wslec.sh
# WSL Environment Control
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


# set DISPLAY if there is an X11 server running
tmpdpy=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}')
if command -v xvinfo > /dev/null && env DISPLAY=$tmpdpy:0.0 xvinfo > /dev/null 2>&1; then
    export DISPLAY=$tmpdpy:0.0
    export LIBGL_ALWAYS_INDIRECT=1
    export GDK_SCALE=$(wslsys -S -s)
    export QT_SCALE_FACTOR=$(wslsys -S -s)
    export GDK_DPI_SCALE=1
elif command -v xvinfo > /dev/null && env DISPLAY=:0 xvinfo > /dev/null 2>&1; then
    export DISPLAY=:0
    export LIBGL_ALWAYS_INDIRECT=1
    export NO_AT_BRIDGE=1
    export GDK_SCALE=$(wslsys -S -s)
    export QT_SCALE_FACTOR=$(wslsys -S -s)
    export GDK_DPI_SCALE=1
fi

# set up audio if pulse server is reachable only via tcp
if command -v pactl > /dev/null \
        && (! pactl info > /dev/null 2>&1 || pactl info | grep -q 'Default Sink: auto_null' ) \
        && env PULSE_SERVER=tcp:localhost pactl info > /dev/null 2>&1; then
    export PULSE_SERVER=tcp:localhost
fi

# setup gpg because why not
if command -v gpg > /dev/null; then
    export GPG_TTY=$(tty)
fi