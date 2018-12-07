#!/usr/bin/env bash
git clone https://github.com/wslutilities/wslu.wiki.git

OUTPATH="../../gendocs"
SOURCES=(wslfetch wslsys wslupath wslusc wslview)
BUILD_TIME="$(date +%Y-%m-%d)"

[ -d $OUTPATH ] || mkdir $OUTPATH
for file in "${SOURCES[@]}"; do
    NAME_CAP="$(echo $file | tr '[:lower:]' '[:upper:]')"

    ronn --manual=$NAME_CAP --organization="Patrick Wu" --date=$BUILD_TIME wslu.wiki/${file}.md
    rm wslu.wiki/${file}.html

    mv wslu.wiki/${file} wslu.wiki/${file}.1
    sed -i "s|.TH \"$NAME_CAP\" \"\"|.TH \"$NAME_CAP\" \"1\"|" wslu.wiki/${file}.1
    sed -i 's|.SH "NAME"||' wslu.wiki/${file}.1
    sed -i 's|\\fBwslfetch\\fR||' wslu.wiki/${file}.1
    sed -i 's|Manpage Name|NAME|' wslu.wiki/${file}.1
    mv wslu.wiki/${file}.1 $OUTPATH
done
rm -rf wslu.wiki