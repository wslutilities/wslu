#!/usr/bin/env bash
BUILD_VER=`grep 'Version: ' ../../build/debian-build/DEBIAN/control | cut -d':' -f 2 | xargs`
cp ../../src/wsl* ../../build/debian-build/usr/bin/
cd ../../build/debian-build/
find . -type f ! -regex '.*.hg.*' ! -regex '.*?debian-binary.*' ! -regex '.*?DEBIAN.*' -printf '%P ' | xargs md5sum > DEBIAN/md5sums

BUILD_DIR=`mktemp --tmpdir --directory pkg-debian.XXXX`

cp -rp * $BUILD_DIR

find $BUILD_DIR -type d -exec chmod 0755 {} \;
find $BUILD_DIR/usr/bin -type f -exec chmod 0555 {} \;

cd ../debian-release

dpkg -b $BUILD_DIR/ wslu-${BUILD_VER}.deb

rm -rf $BUILD_DIR