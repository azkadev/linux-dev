# alpine-linux-bootstrap

Minimal (<3MB) alpine-linux bootstrap archive for Android API 16+. Used in feelfreelinux/octo4a.

## Setup

To setup the bootstrap, extract it anywhere  and run:
`./install-bootstrap.sh`

This will extract and setup the bundled alpine linux rootfs. You can later access it by using the `run-bootstrap.sh` script.

This script uses [green-green-avk's proot build script](https://github.com/green-green-avk/build-proot-android).