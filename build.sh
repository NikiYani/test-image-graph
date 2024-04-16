#!/bin/bash
#
# Do not configure this file.
#

source utils.sh

if [ ! -z $1 ] 
then
    VERSION=$1
else
    VERSION="1.0.0.0"
fi

PROJECT=$(pwd)

echo -e "$LIGHTGREEN=== START COMPILING ===$NC\n"

if [ -d $PROJECT/build_sh/ ]; then
	echo "Build direction exists"
else
	mkdir -p $PROJECT/build_sh/
	echo "Build direction has been created"
fi

cd build_sh

cmake 	-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_TOOLCHAIN_FILE=../toolchain_radxa.cmake \
		-DCMAKE_INSTALL_PREFIX=../install_sh \
		-DVERSION=$VERSION \
		-GNinja ..
cmake --build . --target install -j4

cd ../

echo -e "\n$LIGHTGREEN=== END COMPILING ===$NC\n"

./deb_package_generation.sh $VERSION