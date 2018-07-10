#!/usr/bin/env bash
BUILD_DIR=`mktemp --tmpdir --directory wslu-build-debian.XXXX`
BUILD_VER=`grep 'version=' ../src/wslu-header | cut -d'=' -f 2 | xargs`
CURRENT_DIR=`pwd`

mkdir $BUILD_DIR/{DEBIAN/,usr/,usr/bin/,usr/share/,usr/share/wslu/,usr/lib,usr/lib/mime,/usr/lib/mime/packages/}

touch $BUILD_DIR/DEBIAN/{postinst,prerm,changelog,control}

chmod 755 $BUILD_DIR/DEBIAN/{postinst,prerm}

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
wslu ($BUILD_VER-2) stable; urgency=low

 * wslpkg will not be included anymore;
 * fixed a bug in wslupath which produce cmd.exe no longer print proper path address;
 * wslview is now part of wslu;
 * huge change on building structure;
 * fixes a bug in wslusc (closes #11).

-- Patrick Wu <wotingwu@live.com>  Tue, 10 Jul 2018 12:00:00 +0800

EOF

cat <<EOF >>$BUILD_DIR/DEBIAN/control
Package: wslu
Architecture: all
Maintainer: Patrick Wu <wotingwu@live.com>
Depends: bc, wget, unzip, lsb-release
Recommends: git
Suggests: build-essential
Priority: optional
Version: $BUILD_VER-2
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

[ -d $CURRENT_DIR/../target ] || mkdir $CURRENT_DIR/../target
cd $CURRENT_DIR/../target/

sudo dpkg -b $BUILD_DIR/ wslu-${BUILD_VER}.deb

rm -rf $BUILD_DIR
cd $CURRENT_DIR
