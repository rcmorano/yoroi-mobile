#!/bin/bash

source $HOME/.cargo/env
set +x; source $NVM_DIR/nvm.sh; set -x
nvm use ${NODE_VERSION}

cd android
./gradlew ":app:assembleMainDebug"
ls -hl app/build/outputs/apk/main/debug/
