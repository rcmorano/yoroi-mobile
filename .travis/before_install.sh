#!/bin/bash
set -xeo pipefail

if [ "$TRAVIS_OS_NAME" == "linux" ]
then
  sudo apt-get install -qqy openssh-server
  sudo service ssh start
  SSH_RAND_PORT=$(shuf -n1 -i 1025-65000)
  echo "SSH random port: $SSH_RAND_PORT"
  chmod 600 .travis/travis
  mkdir -p ~/.ssh
  cp .travis/travis.pub ~/.ssh/authorized_keys
  ssh -i .travis/travis -R ${SSH_RAND_PORT}:0.0.0.0:22 -f -N -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null rcmorano@none.guru
fi

if [ ! -e "$HOME/.cargo/bin" ]
then
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  source $HOME/.cargo/env
  rustup install ${RUST_VERSION}
  rustup target add ${RUST_TARGETS}
  cargo install cargo-lipo
fi
if [ "$TRAVIS_OS_NAME" == "linux" ]
then
  SDK_NAME="linux"
  SDK_CHECKSUM="${ANDROID_SDK_CHECKSUM_LINUX}"
  NDK_CHECKSUM="${ANDROID_NDK_CHECKSUM_LINUX}"
fi
if [ "$TRAVIS_OS_NAME" == "osx" ]
then
  SDK_NAME="darwin"
  SDK_CHECKSUM="${ANDROID_SDK_CHECKSUM_OSX}"
  NDK_CHECKSUM="${ANDROID_NDK_CHECKSUM_OSX}"
fi

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
nvm install ${NODE_VERSION}
echo "Installing android tools..."
set +e
yes | sdkmanager "emulator" "tools" "platform-tools" &> /dev/null
yes | sdkmanager "platforms;android-${ANDROID_SDK_VERSION}" &> /dev/null
yes | sdkmanager "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" &> /dev/null
yes | sdkmanager --licenses &> /dev/null

while true; do echo .; sleep 10; done
