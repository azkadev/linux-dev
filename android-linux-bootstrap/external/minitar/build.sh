#!/bin/sh

set -e

[ "$1" = '-u' ] && UPDATE=1

BUILD_DIR='build'
VER='3.5.1'
NAME="libarchive-$VER"

export PATH="$HOME/Android/Sdk/ndk/21.3.6528147:$PATH"

if [ -z "$UPDATE" ] ; then

( cd bzip2 && ./build.sh )
( cd lzma && ./build.sh )

mkdir -p "$BUILD_DIR"
(
cd "$BUILD_DIR"
wget -O - "https://www.libarchive.org/downloads/$NAME.tar.gz" | tar -xz
)

fi

export TARGET_SRC_DIR="$(realpath -s "$BUILD_DIR/$NAME")"

if [ -z "$UPDATE" ] ; then

patch -i "$(realpath -s android.patch)" -p0 -d "$TARGET_SRC_DIR"

fi

export NDK_PROJECT_PATH="$BUILD_DIR"
ndk-build NDK_APPLICATION_MK=./App-all.mk

mkdir -p 'prebuilt'
cp -a "$BUILD_DIR/libs/"* 'prebuilt'
