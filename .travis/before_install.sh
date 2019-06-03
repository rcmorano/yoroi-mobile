#!/bin/bash
set -xeo pipefail

if [ "$TRAVIS_OS_NAME" == "linux" ]
then
  SDK_NAME="linux"
  SDK_CHECKSUM="${ANDROID_SDK_CHECKSUM_LINUX}"
  NDK_CHECKSUM="${ANDROID_NDK_CHECKSUM_LINUX}"
  RUST_TARGETS="${RUST_TARGETS_ANDROID}"
fi
if [ "$TRAVIS_OS_NAME" == "osx" ]
then
  SDK_NAME="darwin"
  SDK_CHECKSUM="${ANDROID_SDK_CHECKSUM_OSX}"
  NDK_CHECKSUM="${ANDROID_NDK_CHECKSUM_OSX}"
  RUST_TARGETS="${RUST_TARGETS_IOS}"
fi


if [ ! -e "$HOME/.cargo/bin" ]
then
  curl https://sh.rustup.rs -sSf | sh -s -- -y
fi
source $HOME/.cargo/env
rustup install ${RUST_VERSION}
rustup target add ${RUST_TARGETS}
which cargo-lipo || cargo install cargo-lipo


if [ ! -e "${ANDROID_HOME}/bin" ]
then
  echo "Installing android-sdk..."
  curl -o android-sdk.zip https://dl.google.com/android/repository/sdk-tools-${SDK_NAME}-4333796.zip; 
  echo $SDK_CHECKSUM android-sdk.zip | sha256sum -c
  mkdir -p ${ANDROID_HOME}
  unzip -qq android-sdk.zip -d ${ANDROID_HOME}
  rm android-sdk.zip
fi
if [ ! -e "${ANDROID_NDK_HOME}" ]
then
  echo "Installing android-ndk..."
  curl -o android-ndk.zip https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-${SDK_NAME}-x86_64.zip
  echo $NDK_CHECKSUM android-ndk.zip | sha1sum -c
  rm -rf ~/android-ndk; mkdir -p ~/android-ndk
  unzip -qq android-ndk.zip -d ~/android-ndk
  rm -f *zip
fi

set +x; source $NVM_DIR/nvm.sh; set -x
set +x; nvm install ${NODE_VERSION}; set -x
echo "Installing android tools..."
set +e
yes | sdkmanager "emulator" "tools" "platform-tools" &> /dev/null
yes | sdkmanager "platforms;android-${ANDROID_SDK_VERSION}" &> /dev/null
yes | sdkmanager "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" &> /dev/null
yes | sdkmanager --licenses &> /dev/null
ls -hl
