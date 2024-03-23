#!/bin/bash

set -e

echo "Creating bootstrap for all archs"
# get the current path of the script
SCRIPTS_PATH=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPTS_PATH"
echo "Building proot..."
cd ../external/proot/

./build.sh

echo "Building minitar..."
cd ../minitar
./build.sh

cd $SCRIPTS_PATH
mkdir -p build
cd build
rm -rf *
cp ../ioctlHook.c .
../build-ioctl-hook.sh

cp -r ../../external/proot/build/* .

build_bootstrap_alpine () {
	echo "Packing bootstrap for arch $1"
    
	case $1 in
	aarch64)
		PROOT_ARCH="aarch64"
		ANDROID_ARCH="arm64-v8a"
		MUSL_ARCH="aarch64-linux-musl"
		;;
	armhf)
		PROOT_ARCH="armv7a"
		ANDROID_ARCH="armeabi-v7a"
		MUSL_ARCH="arm-linux-musleabihf"
		;;
	x86_64)
		PROOT_ARCH="x86_64"
		ANDROID_ARCH="x86_64"
		MUSL_ARCH="x86_64-linux-musl"
		;;
	x86)
		PROOT_ARCH="i686"
		ANDROID_ARCH="x86"
		MUSL_ARCH="i686-linux-musl"
		;;
	*)
		echo "Invalid arch"
		;;
	esac
	cd root-$PROOT_ARCH
	cp ../../../external/minitar/build/libs/$ANDROID_ARCH/minitar root/bin/minitar

	# separate binaries for platforms < android 5 not supporting 64bit
	if [[ "$1" == "armhf" || "$1" == "i386" ]]; then
		cp -r ../root-${PROOT_ARCH}-pre5/root root-pre5
		cp root/bin/minitar root-pre5/bin/minitar
	fi


	ALPINE_RELEASE="3.19"
	ALPINE_VER="$ALPINE_RELEASE.1"
	ALPINE_URL_DOWNLOAD="http://dl-cdn.alpinelinux.org/alpine/v$ALPINE_RELEASE/releases/$1/alpine-minirootfs-$ALPINE_VER-$1.tar.gz"
	echo "Downloading Alpine $ALPINE_RELEASE ($ALPINE_VER)"
	echo "Downloading Alpine $ALPINE_URL_DOWNLOAD"
	curl --fail -o rootfs.tar.xz -L $ALPINE_URL_DOWNLOAD
	cp ../../run-bootstrap.sh .
	cp ../../install-bootstrap.sh .
	cp ../../fake_proc_stat .
	cp ../../add-user.sh .
	cp ../build-ioctl/ioctlHook-${MUSL_ARCH}.so ioctlHook.so
	zip -r alpine-$PROOT_ARCH.zip root ioctlHook.so root-pre5 fake_proc_stat rootfs.tar.xz run-bootstrap.sh install-bootstrap.sh add-user.sh
	mv alpine-$PROOT_ARCH.zip ../
	echo "Packed bootstrap $1"
	cd ..
}


build_bootstrap_ubuntu () {
	echo "Packing bootstrap for arch $1";

	UBUNTU_RELEASE="23.10";
	UBUNTU_URL_DOWNLOAD="https://cdimage.ubuntu.com/ubuntu-base/releases/$UBUNTU_RELEASE/release/ubuntu-base-$UBUNTU_RELEASE-base-arm64.tar.gz";
	
	
    if [[ $1 == "aarch64" ]]; then
	   PROOT_ARCH="aarch64";
	   ANDROID_ARCH="arm64-v8a";
	   MUSL_ARCH="aarch64-linux-musl";
	   UBUNTU_URL_DOWNLOAD="https://cdimage.ubuntu.com/ubuntu-base/releases/$UBUNTU_RELEASE/release/ubuntu-base-$UBUNTU_RELEASE-base-arm64.tar.gz";
    elif [[ $1 == "armhf" ]]; then
	   PROOT_ARCH="armv7a"
	   ANDROID_ARCH="armeabi-v7a"
	   MUSL_ARCH="arm-linux-musleabihf"
	   UBUNTU_URL_DOWNLOAD="https://cdimage.ubuntu.com/ubuntu-base/releases/$UBUNTU_RELEASE/release/ubuntu-base-$UBUNTU_RELEASE-base-armhf.tar.gz";
    elif [[ $1 == "x86_64" ]]; then
	   PROOT_ARCH="x86_64"
	   ANDROID_ARCH="x86_64"
	   MUSL_ARCH="x86_64-linux-musl"
	   UBUNTU_URL_DOWNLOAD="https://cdimage.ubuntu.com/ubuntu-base/releases/$UBUNTU_RELEASE/release/ubuntu-base-$UBUNTU_RELEASE-base-amd64.tar.gz";
    else
      echo "Invalid Arch";
	  echo "skip $1"
	  return;
    fi 

	echo "Build UBUNTU $UBUNTU_RELEASE";
	echo "URL DOWNLOAD UBUNTU $UBUNTU_URL_DOWNLOAD";

	cd root-$PROOT_ARCH
	cp ../../../external/minitar/build/libs/$ANDROID_ARCH/minitar root/bin/minitar

	# separate binaries for platforms < android 5 not supporting 64bit
	if [[ "$1" == "armhf" || "$1" == "i386" ]]; then
		cp -r ../root-${PROOT_ARCH}-pre5/root root-pre5
		cp root/bin/minitar root-pre5/bin/minitar
	fi


	curl --fail -o rootfs.tar.xz -L $UBUNTU_URL_DOWNLOAD
	
	cp ../../run-bootstrap.sh .
	cp ../../install-bootstrap.sh .
	cp ../../fake_proc_stat .
	cp ../../add-user.sh .
	cp ../build-ioctl/ioctlHook-${MUSL_ARCH}.so ioctlHook.so
	zip -r ubuntu-$PROOT_ARCH.zip root ioctlHook.so root-pre5 fake_proc_stat rootfs.tar.xz run-bootstrap.sh install-bootstrap.sh add-user.sh
	mv ubuntu-$PROOT_ARCH.zip ../
	echo "Packed bootstrap $1"
	cd ..
}

build_bootstrap () {
	build_bootstrap_alpine $1
	build_bootstrap_ubuntu $1
}

build_bootstrap aarch64
build_bootstrap armhf
build_bootstrap x86_64
build_bootstrap x86
