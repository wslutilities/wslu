#!/usr/bin/env bash
BUILD_DIR=`mktemp --tmpdir --directory wslu-build-debian.XXXX`
BUILD_VER=`grep 'version=' ../src/wslu-header | cut -d'=' -f 2 | xargs`
DATE=`date +%Y%m%d%H%M%S`
CURRENT_DIR=`pwd`

# Creating folders
mkdir -p $BUILD_DIR/wslu-$BUILD_VER/{debian,debian/source,src,src/etc,src/mime}

# Build wslu
cd $CURRENT_DIR/../
make

# copy files to build folder
cp out/* $BUILD_DIR/wslu-$BUILD_VER/src/
cp src/etc/* $BUILD_DIR/wslu-$BUILD_VER/src/etc/
cp src/mime/* $BUILD_DIR/wslu-$BUILD_VER/src/mime/
cp extras/debian/* $BUILD_DIR/wslu-$BUILD_VER/debian

# modifying the files
sed -i s/VERSIONPLACEHOLDER/$BUILD_VER/g $BUILD_DIR/wslu-$BUILD_VER/debian/control
sed -i s/DATEPLACEHOLDER/$DATE/g $BUILD_DIR/wslu-$BUILD_VER/debian/control
chmod 755 $BUILD_DIR/wslu-$BUILD_VER/debian/{postinst,prerm,rules}

# Build packages
cd $BUILD_DIR/wslu-$BUILD_VER/
dpkg-buildpackage -rsudo -us -uc

# Move built packages
[ -d $CURRENT_DIR/../target/debian ] || mkdir -p $CURRENT_DIR/../target/debian
cd $CURRENT_DIR/../target/debian
cp -r $BUILD_DIR/*.dsc .
cp -r $BUILD_DIR/*.deb .
cp -r $BUILD_DIR/*.tar.gz .
cp -r $BUILD_DIR/*.buildinfo .
cp -r $BUILD_DIR/*.changes .

# CLeanup everything
rm -rf $BUILD_DIR
cd $CURRENT_DIR
