

# mkdir -pv work
# mkdir -pv work/rootfs
# mkdir -pv work/iso/boot
# # tar -xzf /home/galaxeus/Documents/linux/ubuntu-custom/ubuntu-base-23.10-base-amd64.tar.gz -C ./work/rootfs

# sudo mount -vo bind /dev rootfs/dev
# sudo mount -vt sysfs sysfs rootfs/sys
# sudo mount -vt proc proc rootfs/proc


# # sudo chroot rootfs /usr/bin/env PATH=/usr/bin:/bin:/usr/sbin:/sbin /bin/bash

# echo "Archivon" > rootfs/etc/hostname

# # fix apt-get update
# sudo chmod 777 rootfs/tmp


# sudo cp -av rootfs/boot/vmlinuz-**-**-generic iso/boot/vmlinuz
# sudo cp -av rootfs/boot/initrd.img iso/boot/initrd

# # clean up
# # rm -rfv tmp/*
# # rm -rfv boot/*
# # clean up
# # rm -rfv var/cache/* 


# sudo grub-mkrescue -o "../checkn1x-linux.iso" iso --compress=xz



umount -v -l -f work/rootfs/dev >/dev/null 2>&1
umount -v -l -f work/rootfs/sys >/dev/null 2>&1
umount -v -l -f work/rootfs/proc >/dev/null 2>&1
