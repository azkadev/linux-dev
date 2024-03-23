#!/bin/bash

set -e
shopt -s nullglob

. ./config

cd "$BUILD_DIR/talloc-$TALLOC_V"

DEF_CFLAGS="$CFLAGS"

for ARCH in $ARCHS
do

set-arch $ARCH

if [ "$SUBARCH" == 'pre5' ]
then
FILE_OFFSET_BITS='NO'
export CFLAGS="$CFLAGS -D__ANDROID_API__=14"
else
FILE_OFFSET_BITS='OK'
export CFLAGS="$DEF_CFLAGS"
fi

make distclean || true

cat <<EOF >cross-answers.txt
Checking uname sysname type: "Linux"
Checking uname machine type: "dontcare"
Checking uname release type: "dontcare"
Checking uname version type: "dontcare"
Checking simple C program: OK
building library support: OK
Checking for large file support: OK
Checking for -D_FILE_OFFSET_BITS=64: $FILE_OFFSET_BITS
Checking for WORDS_BIGENDIAN: OK
Checking for C99 vsnprintf: OK
Checking for HAVE_SECURE_MKSTEMP: OK
rpath library support: OK
-Wl,--version-script support: FAIL
Checking correct behavior of strtoll: OK
Checking correct behavior of strptime: OK
Checking for HAVE_IFACE_GETIFADDRS: OK
Checking for HAVE_IFACE_IFCONF: OK
Checking for HAVE_IFACE_IFREQ: OK
Checking getconf LFS_CFLAGS: OK
Checking for large file support without additional flags: OK
Checking for working strptime: OK
Checking for HAVE_SHARED_MMAP: OK
Checking for HAVE_MREMAP: OK
Checking for HAVE_INCOHERENT_MMAP: OK
Checking getconf large file support flags work: OK
EOF

./configure "--prefix=$INSTALL_ROOT" --disable-rpath --disable-python --cross-compile --cross-answers=cross-answers.txt

make

mkdir -p "$STATIC_ROOT/include"
mkdir -p "$STATIC_ROOT/lib"

ar rcs "$STATIC_ROOT/lib/libtalloc.a" bin/default/talloc*.o
cp -f talloc.h "$STATIC_ROOT/include"

done
