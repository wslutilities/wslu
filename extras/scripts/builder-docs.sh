#!/bin/bash
#
# builder-deb.sh
# scripts of wslu
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

# get documentation from online
git clone https://github.com/wslutilities/wslu.wiki.git

OUTPATH="../../docs"
SOURCES=(wslfetch wslsys wslupath wslusc wslview wslvar)
BUILD_TIME="$(date +%Y-%m-%d)"

[[ -d "$OUTPATH" ]] || mkdir "$OUTPATH"

for file in "${SOURCES[@]}"; do
    NAME_CAP="$(echo "$file" | tr '[:lower:]' '[:upper:]')"
    
    # rename the filename
    mv wslu.wiki/"$file".md wslu.wiki/"$file"
    
    # generate base files using ronn
    ronn --manual="$NAME_CAP" --organization="Patrick Wu" --date="$BUILD_TIME" wslu.wiki/"$file"

    # cleanup folder for file modification
    rm wslu.wiki/"$file".html
    mv wslu.wiki/"$file" wslu.wiki/"$file".1

    # Manpage Modification
    sed -i "s|.TH \"$NAME_CAP\" \"\"|.TH \"$NAME_CAP\" \"1\"|" wslu.wiki/"$file".1
    sed -i 's|.SH "NAME"||' wslu.wiki/"$file".1
    sed -i 's|\\fBwslfetch\\fR||' wslu.wiki/"$file".1
    sed -i 's|Manpage Name|NAME|' wslu.wiki/"$file".1

    # gzip file and move to the destination
    gzip wslu.wiki/"$file".1
    mv wslu.wiki/"$file".1.gz "$OUTPATH"
done

# cleanup temp files
rm -rf wslu.wiki
