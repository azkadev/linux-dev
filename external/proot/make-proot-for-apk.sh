#!/bin/bash

set -e
shopt -s nullglob

. ./config

cd "$BUILD_DIR/proot-$PROOT_V/src"

for ARCH in $ARCHS
do

set-arch $ARCH

export CFLAGS="-I$STATIC_ROOT/include -Werror=implicit-function-declaration"
export LDFLAGS="-L$STATIC_ROOT/lib"
export PROOT_UNBUNDLE_LOADER='.'
export PROOT_UNBUNDLE_LOADER_NAME='libproot-loader.so'
export PROOT_UNBUNDLE_LOADER_NAME_32='libproot-loader32.so'

if [ "$SUBARCH" == 'pre5' ]
then export ANDROID_PRE5=1
else unset ANDROID_PRE5
fi

make distclean || true
make V=1 "PREFIX=$INSTALL_ROOT-apk" install
make distclean || true
CFLAGS="$CFLAGS -DUSERLAND" make V=1 "PREFIX=$INSTALL_ROOT-apk" proot
cp -a ./proot "$INSTALL_ROOT-apk/bin/proot-userland"

(
cd "$INSTALL_ROOT-apk/bin"
for FN in *
do
"$STRIP" "$FN"
case "$FN" in
lib*.so) ;;
*) mv -f "$FN" "lib$FN.so" ;;
esac
done
)

done
