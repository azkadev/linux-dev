#!/bin/bash
mkdir build-ioctl
cd build-ioctl

echo "Building ioctl hook with musl cross platform toolchain"

MUSL_AARCH64="aarch64-linux-musl"
MUSL_ARMV7="arm-linux-musleabihf"
MUSL_I686="i686-linux-musl"
MUSL_X86_64="x86_64-linux-musl"

cross_compile() {
	curl -O "https://musl.cc/$1-cross.tgz"
	tar xzf "$1-cross.tgz"
	GCC_PATH=./$1-cross/bin/$1-gcc
	$GCC_PATH -fPIC -c -o ioctlHook.o ioctlHook.c
	$GCC_PATH -shared -o ioctlHook-$1.so ioctlHook.o -ldl
}

cp ../ioctlHook.c ioctlHook.c

cross_compile $MUSL_AARCH64
cross_compile $MUSL_I686
cross_compile $MUSL_ARMV7
cross_compile $MUSL_X86_64
