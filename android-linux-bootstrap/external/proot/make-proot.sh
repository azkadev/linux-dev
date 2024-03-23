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
export PROOT_UNBUNDLE_LOADER='../libexec/proot'

if [ "$SUBARCH" == 'pre5' ]
then export ANDROID_PRE5=1
else unset ANDROID_PRE5
fi

make distclean || true
make V=1 "PREFIX=$INSTALL_ROOT" install
make distclean || true
CFLAGS="$CFLAGS -DUSERLAND" make V=1 "PREFIX=$INSTALL_ROOT" proot
cp -a ./proot "$INSTALL_ROOT/bin/proot-userland"

(
cd "$INSTALL_ROOT/bin"
for FN in *
do
"$STRIP" "$FN"
done
)

(
cd "$INSTALL_ROOT/bin/$PROOT_UNBUNDLE_LOADER"
for FN in *
do
"$STRIP" "$FN"
done
)

done
