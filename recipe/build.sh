#!/bin/bash

set -ex

mkdir -p _build
pushd _build

# configure
cmake \
	${SRC_DIR} \
	${CMAKE_ARGS} \
	-DCMAKE_BUILD_TYPE=RelWithDebInfo \
	-DCMAKE_DISABLE_FIND_PACKAGE_Doxygen=true \
	-DWITH_GSSAPI=no \
	-DWITH_SASL=${PREFIX} \

# build
cmake --build . --parallel ${CPU_COUNT} --verbose

# test
ctest --parallel ${CPU_COUNT} --verbose

# install
cmake --build . --parallel ${CPU_COUNT} --verbose --target install
