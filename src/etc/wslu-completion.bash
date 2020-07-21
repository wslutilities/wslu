#!/bin/bash
# wslu-completion.bash - bash autocomplete for wslu
# Component of Windows 10 linux Subsystem Utility
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

_wslfetch_cmd()
{
    # using the top answer from this post with some modifications: 
    # https://stackoverflow.com/questions/41480241/is-it-possible-to-display-some-help-message-when-showing-autocomplete-candidates
    local cmd=$1 cur=$2 pre=$3
    local -a options=( \
                       '' --verbose \
                       -h --help \
                       -v --version \
                       -s --splash \
                       -l --line \
                       -c --colorbar \
                     )
    local -a options2=()
    local i short long

    for ((i = 0; i < ${#options[@]}; i += 2)); do
        short=${options[i]}
        long=${options[i+1]}
        if [[ -z $short || -z $long ]]; then
            options2+=( $short$long )
        else
            options2+=( $short,$long )
        fi
    done

    if [[ $cur == --* ]]; then
        COMPREPLY=( $( compgen -W "${options[*]}" -- "$cur" ) )
    else
        COMPREPLY=( $( compgen -W "${options2[*]}" -- "$cur" ) )
    fi
}

complete -F _wslfetch_cmd  -o bashdefault -o default wslfetch