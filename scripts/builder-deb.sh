#!/usr/bin/env bash
BUILD_DIR=`mktemp --tmpdir --directory wslu-build-debian.XXXX`
BUILD_VER=`grep 'version=' ../src/wslu-header | cut -d'=' -f 2 | xargs`
DATE=`date +%Y%m%d%H%M%S`
CURRENT_DIR=`pwd`

# Creating folders
mkdir -p $BUILD_DIR/{DEBIAN/,usr/bin/,usr/share/wslu/,/usr/lib/mime/packages/}

# copy files to build folder
cp $CURRENT_DIR/../out/wsl* $BUILD_DIR/usr/bin/
cp $CURRENT_DIR/../src/etc/* $BUILD_DIR/usr/share/wslu/
cp $CURRENT_DIR/../src/mime/* $BUILD_DIR/usr/lib/mime/packages

# modifying the files
sed -i s/VERSIONPLACEHOLDER/$BUILD_VER/g $BUILD_DIR/DEBIAN/control
sed -i s/DATEPLACEHOLDER/$DATE/g $BUILD_DIR/DEBIAN/control
chmod 755 $BUILD_DIR/DEBIAN/{postinst,prerm}

# export md5 hashes
cd $BUILD_DIR
find . -type f ! -regex '.*.hg.*' ! -regex '.*?debian-binary.*' ! -regex '.*?DEBIAN.*' -printf '%P ' | xargs md5sum > DEBIAN/md5sums

# setting permissions
find $BUILD_DIR -type d -exec chmod 0755 {} \;
find $BUILD_DIR/usr/ -type f -exec chmod 0555 {} \;
find $BUILD_DIR/usr/lib/mime/packages/ -type f -exec chmod 644 {} \;

# build
[ -d $CURRENT_DIR/../target ] || mkdir $CURRENT_DIR/../target
cd $CURRENT_DIR/../target/
sudo dpkg -b $BUILD_DIR/ wslu-${BUILD_VER}.deb

# CLeanup everything
rm -rf $BUILD_DIR
cd $CURRENT_DIR
