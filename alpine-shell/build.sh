#!/bin/bash
#
# checkn1x build script
# https://asineth.me/checkn1x
#

mkdir -p build
cd build

export rootfs_folder=rootfs
export name_iso="custom-linux"
export alpine_version="3.19.0"

mkdir -p $rootfs_folder

mkdir -p iso/boot/grub

rm -rf ./$name_iso.iso
rm -rf iso/boot/initramfs.xz

if [ -d "$rootfs_folder/bin" ] 
then
    echo "Skip Extract Alpine Miniroot" 
else
    if [ -f "../alpine-minirootfs-$alpine_version-x86_64.tar.gz" ]
	then
	    echo "Extract Alpien Miniroot"
	    tar -xzf ../alpine-minirootfs-$alpine_version-x86_64.tar.gz -C ./$rootfs_folder
	else
	   echo "Download Alpine Root"
	   wget https://dl-cdn.alpinelinux.org/alpine/edge/releases/x86_64/alpine-minirootfs-$alpine_version-x86_64.tar.gz
	   echo "Extract Alpien Miniroot"
	   tar -xzf ../alpine-minirootfs-$alpine_version-x86_64.tar.gz -C ./$rootfs_folder
	fi
fi
 

umount -v $rootfs_folder/dev >/dev/null 2>&1
umount -v $rootfs_folder/sys >/dev/null 2>&1
umount -v $rootfs_folder/proc >/dev/null 2>&1 


mount -vo bind /dev $rootfs_folder/dev
mount -vt sysfs sysfs $rootfs_folder/sys
mount -vt proc proc $rootfs_folder/proc

echo "nameserver 8.8.8.8 \n\
nameserver 8.8.4.4" > $rootfs_folder/etc/resolv.conf

echo "Add Repo"
cat << ! > $rootfs_folder/etc/apk/repositories
https://dl-cdn.alpinelinux.org/alpine/v3.19/main
https://dl-cdn.alpinelinux.org/alpine/v3.19/community
https://dl-cdn.alpinelinux.org/alpine/edge/testing
!

echo "Add Install Package Core"
cat << ! | chroot $rootfs_folder /usr/bin/env PATH=/usr/bin:/bin:/usr/sbin:/sbin /bin/sh
apk update
apk upgrade
apk add alpine-base ncurses-terminfo-base udev usbmuxd libusbmuxd-progs openssh-client sshpass usbutils
apk add --no-scripts linux-lts linux-firmware-none
rc-update add bootmisc
rc-update add hwdrivers
rc-update add udev
rc-update add udev-trigger
rc-update add udev-settle
!


# # kernel modules
# cat << ! > $rootfs_folder/etc/mkinitfs/features.d/azkadev.modules
# kernel/drivers/usb/host
# kernel/drivers/hid/usbhid
# kernel/drivers/hid/hid-generic.ko
# kernel/drivers/hid/hid-cherry.ko
# kernel/drivers/hid/hid-apple.ko
# kernel/net/ipv4
# !

# chroot $rootfs_folder /usr/bin/env PATH=/usr/bin:/bin:/usr/sbin:/sbin \
# 	/sbin/mkinitfs -F "azkadev" -k -t /tmp -q $(ls $rootfs_folder/lib/modules)

# rm -rfv $rootfs_folder/lib/modules
# mv -v $rootfs_folder/tmp/lib/modules $rootfs_folder/lib
# find $rootfs_folder/lib/modules/* -type f -name "*.ko" | xargs -n1 -P`nproc` -- strip -v --strip-unneeded
# find $rootfs_folder/lib/modules/* -type f -name "*.ko" | xargs -n1 -P`nproc` -- xz --x86 -v9eT0
# sudo depmod -b $rootfs_folder $(ls $rootfs_folder/lib/modules)


echo "Umount"
umount -v $rootfs_folder/dev >/dev/null 2>&1
umount -v $rootfs_folder/sys >/dev/null 2>&1
umount -v $rootfs_folder/proc >/dev/null 2>&1 


# kernel modules
cat << ! > $rootfs_folder/etc/inittab
# /etc/inittab
::sysinit:/sbin/openrc sysinit
::wait:/sbin/openrc default
tty1::respawn:/bin/login -f root
tty2::respawn:/bin/login -f root
tty3::respawn:/bin/login -f root
tty4::respawn:/bin/login -f root
tty5::respawn:/bin/login -f root
::ctrlaltdel:/sbin/reboot -f
# Stuff to do before rebooting
::shutdown:/sbin/openrc shutdown
!


ln -sv sbin/init $rootfs_folder/init
ln -sv ../../etc/terminfo $rootfs_folder/usr/share/terminfo # fix ncurses

cp -av $rootfs_folder/boot/vmlinuz-lts iso/boot/vmlinuz
cat << ! > iso/boot/grub/grub.cfg
insmod all_video
echo 'Custom Alpine Linux'
linux /boot/vmlinuz quiet loglevel=3
initrd /boot/initramfs.xz
boot
!

# initramfs
pushd $rootfs_folder
rm -rfv boot/*
rm -rfv tmp/*
rm -rfv var/cache/* 
find . | cpio -oH newc | xz -C crc32 --x86 -vz9eT0 > ../iso/boot/initramfs.xz
popd

# iso creation
grub-mkrescue -o "./$name_iso.iso" iso --compress=xz

# sudo chroot alpine_rootfs /usr/bin/env PATH=/usr/bin:/bin:/usr/sbin:/sbin /bin/sh 
echo "Test Script: sudo qemu-system-x86_64 -cpu host -smp cores=4 -enable-kvm -m 4G -cdrom build/$name_iso.iso"
qemu-system-x86_64 -cpu host -smp cores=4 -enable-kvm -m 4G -cdrom ./$name_iso.iso