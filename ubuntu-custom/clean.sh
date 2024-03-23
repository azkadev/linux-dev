#!/bin/bash
#
# checkn1x build script
# https://asineth.me/checkn1x
#

echo "Umount"
umount -v $rootfs_folder/dev >/dev/null 2>&1
umount -v $rootfs_folder/sys >/dev/null 2>&1
umount -v $rootfs_folder/proc >/dev/null 2>&1 

rm -rf build