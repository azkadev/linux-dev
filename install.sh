# /bin/sh
echo "started install Dependencies"

export DEBIAN_FRONTEND=noninteractive

export ANDROID_SDK="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin/:$PATH"
export PATH="$ANDROID_HOME/cmdline-tools/latest/:$PATH"
export PATH="$ANDROID_HOME/emulator/:$PATH"
export PATH="$ANDROID_HOME/platform-tools/:$PATH"
export PATH="$ANDROID_SDK:$PATH"
export PATH="$PATH:$HOME/development/flutter/bin"

echo "export ANDROID_SDK=$HOME/Android/Sdk" >> ~/.bashrc
echo "export ANDROID_SDK_ROOT=$HOME/Android/Sdk" >> ~/.bashrc
echo "export ANDROID_HOME=$HOME/Android/Sdk" >> ~/.bashrc
echo "export PATH=$ANDROID_HOME/cmdline-tools/latest/bin/:$PATH" >> ~/.bashrc
echo "export PATH=$ANDROID_HOME/cmdline-tools/latest/:$PATH" >> ~/.bashrc
echo "export PATH=$ANDROID_HOME/emulator/:$PATH" >> ~/.bashrc
echo "export PATH=$ANDROID_HOME/platform-tools/:$PATH" >> ~/.bashrc
echo "export PATH=$ANDROID_SDK:$PATH" >> ~/.bashrc
echo "export PATH=$PATH:$HOME/development/flutter/bin" >> ~/.bashrc
mkdir "$HOME/development/"

source ~/.bashrc

sudo apt-get update

sudo apt-get install -y --no-install-recommends \
    wget \
    curl \
    make \
    git \
    zlib1g-dev \
    libssl-dev \
    gperf \
    cmake \
    clang \
    libc++-dev \
    libc++abi-dev \
    php-cli \
    g++ \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    liblzma-dev \
    xz-utils \
    unzip \
    xvfb \
    openjdk-11-jdk

mkdir -p $HOME/Android/Sdk/cmdline-tools
wget -q https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip -O /tmp/tools.zip
unzip -q /tmp/tools.zip -d $HOME/Android/Sdk/cmdline-tools
sudo cp -rf $HOME/Android/Sdk/cmdline-tools/cmdline-tools $HOME/Android/Sdk/cmdline-tools/latest
echo "export PATH=$PATH:$HOME/Android/Sdk/cmdline-tools/latest/bin" >> ~/.bashrc

yes "y" | sdkmanager
yes "y" | sdkmanager --update
yes "y" | sdkmanager "platform-tools"
yes "y" | sdkmanager "platforms;android-30"
yes "y" | sdkmanager "patcher;v4"
yes "y" | sdkmanager "build-tools;30.0.2"
yes "y" | sdkmanager "ndk;21.3.6528147"
yes "y" | sdkmanager --licenses
