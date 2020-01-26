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

SOURCEPATH="../../docs"
OUTPATH="../../out-docs"
BUILD_TIME="$"

[[ -d "$OUTPATH" ]] || mkdir "$OUTPATH"

for file in "$(ls $SOURCEPATH)"; do
    cp "$SOURCEPATH/$file" "$OUTPATH"
    # Manpage Modification
    sed -i "s|DATEPLACEHOLDER|"$$()""|" "$OUTPATH/$file"
    sed -i 's|.SH "NAME"||' wslu.wiki/"$file".1
    sed -i 's|\\fBwslfetch\\fR||' wslu.wiki/"$file".1
    sed -i 's|Manpage Name|NAME|' wslu.wiki/"$file".1

    # gzip file and mremove the temp file
    gzip "$OUTPATH/$file"
    rm "$OUTPATH/$file"
done

# cleanup temp files
rm -rf wslu.wiki
