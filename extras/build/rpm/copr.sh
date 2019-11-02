#!/bin/bash
git clone --depth 1 https://github.com/wslutilities/wslu.git
cd wslu
BUILD_VER="$(grep 'version=' src/wslu-header | cut -d'=' -f 2 | xargs)"
CURRENT_DIR="$(pwd)"

make

# Creating folders
mkdir -p ../result
mkdir -p ../rpm_wslu/wslu-"$BUILD_VER"/{etc,docs}

# Copy files to build folder
cp out/wsl* ../rpm_wslu/wslu-"$BUILD_VER"
cp src/etc/* ../rpm_wslu/wslu-"$BUILD_VER"/etc
cp docs/* ../rpm_wslu/wslu-"$BUILD_VER"/docs
cp extras/build/rpm/wslu.spec ../result/wslu-"$BUILD_VER".spec

# Modifying the files
sed -i s/BUILDVERPLACEHOLDER/"$BUILD_VER"/g ../result/wslu-"$BUILD_VER".spec
sed -i s/NIGHTLYBUILDPLACEHOLDER/""/g ../result/wslu-"$BUILD_VER".spec
sed -i "s|HOMEPLACEHOLDER|""$HOME""|g" ../result/wslu-"$BUILD_VER".spec

# Build tarball
cd ../rpm_wslu/
tar -czvf wslu-"$BUILD_VER".tar.gz wslu-"$BUILD_VER"
cp wslu-"$BUILD_VER".tar.gz ../result/wslu-"$BUILD_VER".tar.gz