# build-proot-android

PRoot build scripts for Android. They produce PRoot statically linked with libtalloc, with unbundled loader and freely relocatable in file tree.

Usage:
- Build or get prebuilt at https://github.com/green-green-avk/build-proot-android/tree/master/packages
- Unpack `<somewhere>`
- Run as `<somewhere>/root/bin/proot`\
for details, see https://github.com/green-green-avk/proot/blob/master/doc/usage/android/start-script-example
- ???
- Profit

How to build:
 - Dependencies: Android NDK / make / tar / gzip
 - Tune `config` file to match your environment
 - Run `./build.sh`

See https://github.com/green-green-avk/proot for more info.
