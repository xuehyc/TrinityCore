#!/bin/bash

set -e

echo "Compile core"
export CCACHE_CPP2=true
export CCACHE_MAXSIZE='500MB'
ccache -s
cd build
make -j 4 -k && make install
cd check_install/bin
./authserver --version
./worldserver --version
ccache -s
