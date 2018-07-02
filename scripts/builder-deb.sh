#!/usr/bin/env bash
BUILD_DIR=`mktemp --tmpdir --directory wslu-build-debian.XXXX`
BUILD_VER=`grep 'version=' ../src/wslu-header | cut -d'=' -f 2 | xargs`
CURRENT_DIR=`pwd`

mkdir $BUILD_DIR/{DEBIAN/,usr/,usr/bin/,usr/share/,usr/share/wslu/,usr/lib,usr/lib/mime,/usr/lib/mime/packages/}

touch $BUILD_DIR/DEBIAN/postinst
touch $BUILD_DIR/DEBIAN/prerm
touch $BUILD_DIR/DEBIAN/changelog
touch $BUILD_DIR/DEBIAN/control

cat <<EOF >>$BUILD_DIR/DEBIAN/postinst
#!/usr/bin/env bash
update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/bin/wslview 100
update-alternatives --install /usr/bin/www-browser www-browser /usr/bin/wslview 100
EOF

cat <<EOF >>$BUILD_DIR/DEBIAN/prerm
#!/usr/bin/env bash
update-alternatives --remove x-www-browser /usr/bin/wslview
update-alternatives --remove www-browser /usr/bin/wslview
EOF

cat <<EOF >>$BUILD_DIR/DEBIAN/changelog
wslu ($BUILD_VER) stable; urgency=low

 * dynamic path conversion, remove unneeded parameter and code cleanup in wslupath;
 * add -NoProfile -Noninteractive switches to the invocation of powershell.exe in wslusc. 
 * absence of wslpkg; will be added back in future release.

-- Patrick Wu <wotingwu@live.com>  Sat, 16 Jun 2018 12:00:00 +0800

EOF

cat <<EOF >>$BUILD_DIR/DEBIAN/control
Package: wslu
Architecture: all
Maintainer: Patrick Wu <wotingwu@live.com>
Depends: bc, wget, unzip, lsb-release
Recommends: git
Suggests: build-essential
Priority: optional
Version: $BUILD_VER
Description: A collection of utilities for Windows 10 Linux Subsystem
 This is a collection of utilities for Windows 10 Linux Subsystem, such as enabling sound in WSL or creating your favorite linux app shortcuts on Windows 10 Desktop. Requires Windows 10 Creators Update and higher.
EOF

cp ../out/wsl* $BUILD_DIR/usr/bin/
cp ../src/etc/* $BUILD_DIR/usr/share/wslu/
cp ../src/mime/* $BUILD_DIR/usr/lib/mime/packages/

cd $BUILD_DIR
find . -type f ! -regex '.*.hg.*' ! -regex '.*?debian-binary.*' ! -regex '.*?DEBIAN.*' -printf '%P ' | xargs md5sum > DEBIAN/md5sums

find $BUILD_DIR -type d -exec chmod 0755 {} \;
find $BUILD_DIR/usr/ -type f -exec chmod 0555 {} \;
find $BUILD_DIR/usr/lib/mime/packages/ -type f -exec chmod 644 {} \;

mkdir $CURRENT_DIR/../target
cd $CURRENT_DIR/../target/

sudo dpkg -b $BUILD_DIR/ wslu-${BUILD_VER}.deb

rm -rf $BUILD_DIR
cd $CURRENT_DIR
