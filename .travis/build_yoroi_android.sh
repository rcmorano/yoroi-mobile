#!/bin/bash

source $HOME/.cargo/env
set +x; source $NVM_DIR/nvm.sh; set -x
set +x; nvm use ${NODE_VERSION}; set -x

cd android
./gradlew ":app:assembleMainDebug"
ls -hl app/build/outputs/apk/main/debug/
