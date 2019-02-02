#!/usr/bin/env bash
# builder-rpm.sh
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
BUILD_VER=`grep 'version=' ../../src/wslu-header | cut -d'=' -f 2 | xargs`
EXTRA="~$(date +%Y%m%d%H%M%S)"
CURRENT_DIR=`pwd`

# nightly build handler
if [ "$1" != "--nightly" ]; then
    EXTRA=""
fi

# Creating folders
mkdir -p ~/rpm_wslu/{BUILD/,RPMS/,SOURCES/,SPECS/,SRPMS/}
mkdir -p ~/rpm_wslu/SOURCES/wslu-$BUILD_VER/{etc,docs}

# Copy files to build folder
cp ../../out/wsl* ~/rpm_wslu/SOURCES/wslu-$BUILD_VER
cp ../../src/etc/* ~/rpm_wslu/SOURCES/wslu-$BUILD_VER/etc
cp ../../docs/* ~/rpm_wslu/SOURCES/wslu-$BUILD_VER/docs
cp ../build/rpm/wslu.spec ~/rpm_wslu/SPECS/wslu-$BUILD_VER.spec

# Modifying the files
sed -i s/BUILDVERPLACEHOLDER/$BUILD_VER/g ~/rpm_wslu/SPECS/wslu-$BUILD_VER.spec
sed -i s/NIGHTLYBUILDPLACEHOLDER/$EXTRAS/g ~/rpm_wslu/SPECS/wslu-$BUILD_VER.spec
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
