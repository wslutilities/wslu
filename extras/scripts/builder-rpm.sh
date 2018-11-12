#!/usr/bin/env bash
BUILD_VER=`grep 'version=' ../../src/wslu-header | cut -d'=' -f 2 | xargs`
CURRENT_DIR=`pwd`

# Creating folders
mkdir -p ~/rpm_wslu/{BUILD/,RPMS/,SOURCES/,SPECS/,SRPMS/}
mkdir -p ~/rpm_wslu/SOURCES/wslu-$BUILD_VER/{etc,mime}

# Copy files to build folder
cp ../../out/wsl* ~/rpm_wslu/SOURCES/wslu-$BUILD_VER
cp ../../src/etc/* ~/rpm_wslu/SOURCES/wslu-$BUILD_VER/etc
cp ../../src/mime/* ~/rpm_wslu/SOURCES/wslu-$BUILD_VER/mime
cp ../build/rpm/wslu.spec ~/rpm_wslu/SPECS/wslu-$BUILD_VER.spec

# Modifying the files
sed -i s/BUILDVERPLACEHOLDER/$BUILD_VER/g ~/rpm_wslu/SPECS/wslu-$BUILD_VER.spec
sed -i "s|HOMEPLACEHOLDER|$HOME|g" ~/rpm_wslu/SPECS/wslu-$BUILD_VER.spec

# Build tarball
cd ~/rpm_wslu/SOURCES
tar -czvf wslu-${BUILD_VER}.tar.gz wslu-$BUILD_VER
rm -rf wslu-$BUILD_VER

# Build
cd ~/rpm_wslu/SPECS
sudo rpmbuild -ba wslu-$BUILD_VER.spec

# Copy packages
[ -d $CURRENT_DIR/../../target ] || mkdir $CURRENT_DIR/../../target
cp ~/rpm_wslu/RPMS/x86_64/*.rpm $CURRENT_DIR/../../target/
cp ~/rpm_wslu/SRPMS/*.rpm $CURRENT_DIR/../../target/

# Cleanup everything
sudo rm -rf ~/rpm_wslu/
cd $CURRENT_DIR
