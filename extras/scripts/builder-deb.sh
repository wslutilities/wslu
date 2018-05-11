#!/usr/bin/env bash
BUILD_DIR=`mktemp --tmpdir --directory pkg-debian.XXXX`
CURRENT_DIR=`pwd`

mkdir $BUILD_DIR/DEBIAN/
mkdir $BUILD_DIR/usr/
mkdir $BUILD_DIR/usr/bin/

cat <<EOF >>$BUILD_DIR/DEBIAN/control
Package: wslu
Architecture: all
Maintainer: patrick330602 <wotingwu@live.com>
Depends: git, build-essential, bc, ppa-purge, wget, unzip, lsb-release
Priority: optional
Version: 1.3
Description: A collection of utilities for Windows 10 Linux Subsystem
 This is a collection of utilities for Windows 10 Linux Subsystem, such as enabling sound in WSL or creating your favorite linux app shortcuts on Windows 10 Desktop. Requires Windows 10 Creators Update and higher.
EOF
BUILD_VER=`grep 'Version: ' $BUILD_DIR/DEBIAN/control | cut -d':' -f 2 | xargs`
cp ../../src/wsl* $BUILD_DIR/usr/bin/

cd $BUILD_DIR
find . -type f ! -regex '.*.hg.*' ! -regex '.*?debian-binary.*' ! -regex '.*?DEBIAN.*' -printf '%P ' | xargs md5sum > DEBIAN/md5sums

find $BUILD_DIR -type d -exec chmod 0755 {} \;
find $BUILD_DIR/usr/bin -type f -exec chmod 0555 {} \;

cd $CURRENT_DIR/../../release/debian

dpkg -b $BUILD_DIR/ wslu-${BUILD_VER}.deb

rm -rf $BUILD_DIR
