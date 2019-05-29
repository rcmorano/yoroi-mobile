#!/bin/bash

source $HOME/.cargo/env

if [ ! -f target.zip ]; then
    # delete target folder in react-native-cardano
    rm -rf node_modules/react-native-cardano/rust/target
    curl -O https://s3.amazonaws.com/yoroi-backups/target.zip
    unzip -a target.zip -d node_modules/react-native-cardano/rust/ 
fi

if [ ! -d "node_modules/react-native/third-party" ]; then
  cd node_modules/react-native ; ./scripts/ios-install-third-party.sh ; cd ../../
  cd node_modules/react-native/third-party/glog-0.3.5/ ; make distclean ; ./configure ; cd ../../../../
fi
