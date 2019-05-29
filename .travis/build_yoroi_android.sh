#!/bin/bash

source $HOME/.cargo/env

cd android
./gradlew ":app:assembleMainDebug"
ls -hl app/build/outputs/apk/main/debug/
