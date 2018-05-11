#!/usr/bin/env bash
mkdir ../../release/debian-build/
mkdir ../../release/debian-build/DEBIAN/
mkdir ../../release/debian-build/usr/
mkdir ../../release/debian-build/usr/bin/

cat <<EOF >>../../release/debian-build/DEBIAN/control
Package: wslu
Architecture: all
Maintainer: patrick330602 <wotingwu@live.com>
Depends: git, build-essential, bc, ppa-purge, wget, unzip, lsb-release
Priority: optional
Version: 1.3
Description: A collection of utilities for Windows 10 Linux Subsystem
 This is a collection of utilities for Windows 10 Linux Subsystem, such as enabling sound in WSL or creating your favorite linux app shortcuts on Windows 10 Desktop. Requires Windows 10 Creators Update and higher.
EOF
BUILD_VER=`grep 'Version: ' ../../release/debian-build/DEBIAN/control | cut -d':' -f 2 | xargs`
cp ../../src/wsl* ../../release/debian-build/usr/bin/

cd ../../release/debian-build/
find . -type f ! -regex '.*.hg.*' ! -regex '.*?debian-binary.*' ! -regex '.*?DEBIAN.*' -printf '%P ' | xargs md5sum > DEBIAN/md5sums

BUILD_DIR=`mktemp --tmpdir --directory pkg-debian.XXXX`

cp -rp * $BUILD_DIR

find $BUILD_DIR -type d -exec chmod 0755 {} \;
find $BUILD_DIR/usr/bin -type f -exec chmod 0555 {} \;

cd ../debian

dpkg -b $BUILD_DIR/ wslu-${BUILD_VER}.deb

rm -rf $BUILD_DIR
rm -rf ../debian-build