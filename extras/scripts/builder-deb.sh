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

BUILD_DIR="$(mktemp --tmpdir --directory wslu-build-debian.XXXX)"
BUILD_VER="$(grep 'version=' ../../src/wslu-header | cut -d'=' -f 2 | xargs)"
BUILD_RELEASE="2"
EXTRA="~$(date +%Y%m%d%H%M%S)"
CURRENT_DIR="$(pwd)"


# nightly build handler
if [[ "$1" != "--nightly" ]]; then
    EXTRA=""
fi

# Creating folders
mkdir -p "$BUILD_DIR"/{DEBIAN/,usr/bin/,usr/share/wslu/,usr/share/man/man1,usr/lib/mime/packages/}

# copy files to build folder
cp "$CURRENT_DIR"/../../docs/* "$BUILD_DIR"/usr/share/man/man1/
cp "$CURRENT_DIR"/../../out/wsl* "$BUILD_DIR"/usr/bin/
cp "$CURRENT_DIR"/../../src/etc/* "$BUILD_DIR"/usr/share/wslu/
cp "$CURRENT_DIR"/../build/debian/* "$BUILD_DIR"/DEBIAN

# modifying the files
sed -i s/BUILDVER/"$BUILD_RELEASE"/g "$BUILD_DIR"/DEBIAN/control
sed -i s/VERSIONPLACEHOLDER/"$BUILD_VER"/g "$BUILD_DIR"/DEBIAN/control
sed -i s/NIGHTLYBUILDPLACEHOLDER/"$EXTRA"/g "$BUILD_DIR"/DEBIAN/control
chmod 755 "$BUILD_DIR"/DEBIAN/{postinst,prerm}

# export md5 hashes
cd "$BUILD_DIR" || exit 1
find . -type f ! -regex '.*.hg.*' ! -regex '.*?debian-binary.*' ! -regex '.*?DEBIAN.*' -printf '%P ' | xargs md5sum > DEBIAN/md5sums

# setting permissions
find "$BUILD_DIR" -type d -exec chmod 0755 {} \;
find "$BUILD_DIR"/usr/ -type f -exec chmod 0555 {} \;

# build
[[ -d "$CURRENT_DIR"/../../target ]] || mkdir "$CURRENT_DIR"/../../target
cd "$CURRENT_DIR"/../../target/ || exit 1
sudo dpkg -b "$BUILD_DIR"/ wslu-"${BUILD_VER}".deb

# Cleanup everything
rm -rf "$BUILD_DIR"
cd "$CURRENT_DIR" || exit 1
