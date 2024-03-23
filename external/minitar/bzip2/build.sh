#!/bin/sh

set -e

BUILD_DIR='build'
VER='1.0.8'
NAME="bzip2-$VER"

mkdir -p "$BUILD_DIR"
(
cd "$BUILD_DIR"
wget -O - "https://sourceware.org/pub/bzip2/$NAME.tar.gz" | tar -xz
)

export TARGET_SRC_DIR="$(realpath -s "$BUILD_DIR/$NAME")"

export NDK_PROJECT_PATH="$BUILD_DIR"
ndk-build NDK_APPLICATION_MK=./App-all.mk

mkdir -p "$BUILD_DIR/include"
cp -a "$TARGET_SRC_DIR"/bzlib.h "$BUILD_DIR/include"
