# build-libarchive-minitar-android

A very small (~200kb) command line tar/gz/bzip2/xz unarchiver utility for Android with hardcoded hard link to symlink conversion.

Just because old Android versions have no even tar/gunzip accessible for applications.

If you want just to use:
* Download [prebuilt binaries](https://github.com/green-green-avk/build-libarchive-minitar-android/tree/master/prebuilt).

If you want to build:
* The only prerequisite is the Android-NDK.
* Just run the `./build.sh` script.

Usage example: `cat something.tgz | minitar`.
