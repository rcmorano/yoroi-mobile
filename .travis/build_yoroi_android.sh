#!/bin/bash

source $HOME/.cargo/env
source $NVM_DIR/nvm.sh
nvm use ${NODE_VERSION}

cd android
./gradlew ":app:assembleMainDebug"
ls -hl app/build/outputs/apk/main/debug/
