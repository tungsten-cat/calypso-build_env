#!/bin/bash

# Firstly, set path to a folder where you will build sources
sources_path=$1

# PUSHD is used to create directories stack

# It stores current directory to stack
# And walks to directory that specified as argument
pushd ${sources_path}

# Now make directory especialy for building BINUTILS
mkdir build-binutils
cd build-binutils

# After that, we can configure BINUTILS to build it for our platform
echo "Configuring BINUTILS..."

../binutils-${BINUTILS_VERSION}/configure \
    --target=${BUILD_TARGET} \
    --prefix="${BUILD_PREFIX}" \
    --with-sysroot --disable-nls --disable-werror

# BUILD_TARGET is specified in Dockerfile, running that script
# BUILD_PREFIX is also specified in Dockerfile

# --with-sysroot tells BINUTILS to enable sysroot support 
# in the cross compiler by pointing it to a default empty directory

# --disable-nls tells BINUTILS not to include native language support
# This flag reduces dependencies and compilation time

# --disable-werror s a compiler flag that causes 
# all compiler warnings to be treated as errors

# All required components can be built using the following commands
echo "Building BINUTILS..."
make -j ${MAKE_JOBS}

echo "Installing BINUTILS..."
make -j ${MAKE_JOBS} install

# POPD returns you to the latest directory stored on stack
popd