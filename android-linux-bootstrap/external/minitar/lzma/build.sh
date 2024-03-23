#!/bin/sh

set -e

BUILD_DIR='build'
VER='5.2.4'
NAME="xz-$VER"

mkdir -p "$BUILD_DIR"
(
cd "$BUILD_DIR"
wget -O - "https://tukaani.org/xz/$NAME.tar.xz" | tar -xJ
)

export TARGET_SRC_DIR="$(realpath -s "$BUILD_DIR/$NAME")"

export NDK_PROJECT_PATH="$BUILD_DIR"
ndk-build NDK_APPLICATION_MK=./App-all.mk

mkdir -p "$BUILD_DIR/include"
cp -a "$TARGET_SRC_DIR"/src/liblzma/api/lzma* "$BUILD_DIR/include"
