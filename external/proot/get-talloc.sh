#!/bin/bash

set -e
shopt -s nullglob

. ./config

cd "$BUILD_DIR"

if [ -d "talloc-$TALLOC_V" ] ; then exit 0 ; fi

wget -O - "https://download.samba.org/pub/talloc/talloc-$TALLOC_V.tar.gz" | tar -xzv

cp ../os2_delete_patched.c "talloc-$TALLOC_V/lib/replace/tests/os2_delete.c"
