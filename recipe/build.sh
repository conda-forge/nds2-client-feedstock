#!/bin/bash

set -ex

mkdir -p _build
pushd _build

# set Python for tests
# (rattler-build sets it to the host Python,
#  which is not available in the build environment)
export PYTHON=${BUILD_PREFIX}/bin/python

# configure
cmake \
  ${CMAKE_ARGS} \
  -DCMAKE_DISABLE_FIND_PACKAGE_Doxygen=true \
  -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
  -DWITH_GSSAPI=no \
  -DWITH_SASL=${PREFIX} \
  ${SRC_DIR}

# build
cmake --build . --parallel ${CPU_COUNT} --verbose

# test
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
ctest --parallel ${CPU_COUNT} --verbose
fi

# install
cmake --build . --parallel ${CPU_COUNT} --verbose --target install
