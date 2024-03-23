#!/bin/bash
#
# checkn1x build script
# https://asineth.me/checkn1x
#

mkdir -p build
cd build

export rootfs_folder=rootfs
export name_iso="custom-linux"
export ubuntu_version="23.10"
export ubuntu_name=ubuntu-base-$ubuntu_version

mkdir -p $rootfs_folder

mkdir -p iso/boot/grub

rm -rf ./$name_iso.iso
rm -rf iso/boot/initramfs.xz

if [ -d "$rootfs_folder/bin" ] 
then
    echo "Skip Extract Alpine Miniroot" 
else
    if [ -f "../$ubuntu_name-base-amd64.tar.gz" ]
	then
	    echo "Extract Alpien Miniroot"
	    tar -xzf ../$ubuntu_name-base-amd64.tar.gz -C ./$rootfs_folder
	else
	   echo "Download Alpine Root"
	   wget https://dl-cdn.ubuntulinux.org/ubuntu/edge/releases/x86_64/$ubuntu_name-base-amd64.tar.gz
	   echo "Extract Alpien Miniroot"
	   tar -xzf ../$ubuntu_name-base-amd64.tar.gz -C ./$rootfs_folder
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

chmod 777 $rootfs_folder/tmp

export run_chroot="chroot $rootfs_folder /usr/bin/env PATH=/usr/bin:/bin:/usr/sbin:/sbin /bin/bash"
echo "sudo $run_chroot"

$run_chroot

# echo "Update Package Core"
# cat << ! | $run_chroot
# apt-get update -y
# apt-get upgrade -y
# !
 

# echo "Update Package Core"
# cat << ! | $run_chroot
# apt-get -y linux-firmware
# !
 

# # echo "Umount"
# # umount -v $rootfs_folder/dev >/dev/null 2>&1
# # umount -v $rootfs_folder/sys >/dev/null 2>&1
# # umount -v $rootfs_folder/proc >/dev/null 2>&1 


# # # # kernel modules
# # # cat << ! > $rootfs_folder/etc/inittab
# # # # /etc/inittab
# # # ::sysinit:/sbin/openrc sysinit
# # # ::wait:/sbin/openrc default
# # # tty1::respawn:/bin/login -f root
# # # tty2::respawn:/bin/login -f root
# # # tty3::respawn:/bin/login -f root
# # # tty4::respawn:/bin/login -f root
# # # tty5::respawn:/bin/login -f root
# # # ::ctrlaltdel:/sbin/reboot -f
# # # # Stuff to do before rebooting
# # # ::shutdown:/sbin/openrc shutdown
# # # !

 
# # # cp -av $rootfs_folder/boot/vmlinuz-lts iso/boot/vmlinuz
# # # cat << ! > iso/boot/grub/grub.cfg
# # # insmod all_video
# # # echo 'Custom Alpine Linux'
# # # linux /boot/vmlinuz quiet loglevel=3
# # # initrd /boot/initramfs.xz
# # # boot
# # # !

# # # # initramfs
# # pushd $rootfs_folder
# # rm -rfv boot/*
# # rm -rfv tmp/*
# # rm -rfv var/cache/* 
# # find . | cpio -oH newc | xz -C crc32 --x86 -vz9eT0 > ../iso/boot/initramfs.xz
# # popd

# # # # iso creation
# # grub-mkrescue -o "./$name_iso.iso" iso --compress=xz

