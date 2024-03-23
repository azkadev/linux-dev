#!/bin/bash

set -e
shopt -s nullglob

. ./config

for ARCH in $ARCHS
do

echo "For $ARCH:"

set-arch $ARCH

tar -czvf "$PKG_DIR/proot-android-$ARCH.tar.gz" -C "$INSTALL_ROOT/.." root

done
