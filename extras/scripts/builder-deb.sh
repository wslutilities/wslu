#!/usr/bin/env bash
BUILD_DIR=`mktemp --tmpdir --directory wslu-build-debian.XXXX`
BUILD_VER=`grep 'version=' ../../src/wslu | cut -d'=' -f 2 | xargs`
CURRENT_DIR=`pwd`

mkdir $BUILD_DIR/{DEBIAN/,usr/,usr/bin/}

touch $BUILD_DIR/DEBIAN/control

cat <<EOF >>$BUILD_DIR/DEBIAN/control
Package: wslu
Architecture: all
Maintainer: patrick330602 <wotingwu@live.com>
Depends: bc, wget, unzip, lsb-release
Recommends: git
Suggests: ppa-purge, build-essential
Priority: optional
Version: $BUILD_VER
Description: A collection of utilities for Windows 10 Linux Subsystem
 This is a collection of utilities for Windows 10 Linux Subsystem, such as enabling sound in WSL or creating your favorite linux app shortcuts on Windows 10 Desktop. Requires Windows 10 Creators Update and higher.
EOF

cp ../../src/wsl* $BUILD_DIR/usr/bin/

cd $BUILD_DIR
find . -type f ! -regex '.*.hg.*' ! -regex '.*?debian-binary.*' ! -regex '.*?DEBIAN.*' -printf '%P ' | xargs md5sum > DEBIAN/md5sums

find $BUILD_DIR -type d -exec chmod 0755 {} \;
find $BUILD_DIR/usr/bin -type f -exec chmod 0555 {} \;

cd $CURRENT_DIR/../../release/debian

sudo dpkg -b $BUILD_DIR/ wslu-${BUILD_VER}.deb

rm -rf $BUILD_DIR
