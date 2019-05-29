#!/bin/bash

set +x; source $NVM_DIR/nvm.sh; set -x
set +x; nvm use ${NODE_VERSION}; set -x
npm install -g yarn@$YARN_VERSION
source $HOME/.cargo/env
rm -f package-lock.json
echo "scripts-prepend-node-path=true" >> .npmrc
if [ "$TRAVIS_OS_NAME" == "osx" ]
then
  YARN_ARGS="--network-concurrency 1"
  gem install --no-ri --no-rdoc xcpretty
fi
yarn install ${YARN_ARGS}
yarn setup_configs
yarn android-bundle
echo "sdk.dir=${ANDROID_HOME}" >> android/local.properties
echo "MYAPP_RELEASE_STORE_PASSWORD=${MYAPP_RELEASE_STORE_PASSWORD}" >> android/gradle.properties.local
echo "YAPP_RELEASE_KEY_PASSWORD=${YAPP_RELEASE_KEY_PASSWORD}" >> android/gradle.properties.local

cat > android/app/google-services.json <<EOF
{
  "project_info": {
    "project_id": "mockproject-1234",
    "project_number": "123456789000",
    "name": "FirebaseQuickstarts",
    "firebase_url": "https://mockproject-1234.firebaseio.com"
  },
  "client": [
    {
      "client_info": {
        "mobilesdk_app_id": "1:123456789000:android:f1bf012572b04063",
        "client_id": "android:com.google.samples.quickstart.admobexample",
        "client_type": 1,
        "android_client_info": {
          "package_name": "com.emurgo",
          "certificate_hash": []
        }
      },
      "oauth_client": [
        {
          "client_id": "123456789000-hjugbg6ud799v4c49dim8ce2usclthar.apps.googleusercontent.com",
          "client_type": 1,
          "android_info": { 
            "package_name": "com.emurgo",
            "certificate_hash": "4C20644DE36B8F89D25650C7D1FF9FBAE650FDF7"
          }
        },
        {
          "client_id": "123456789000-e4uksm38sne0bqrj6uvkbo4oiu4hvigl.apps.googleusercontent.com",
          "client_type": 3
        }
      ],
      "api_key": [
        {
          "current_key": "AIzbSzCn1N6LWIe6wthYyrgUUSAlUsdqMb-wvTo"
        }
      ],
      "services": {
        "analytics_service": {
          "status": 1
        },
        "cloud_messaging_service": {
          "status": 2,
          "apns_config": []
        },
        "appinvite_service": {
          "status": 2,
          "other_platform_oauth_client": [
            {
              "client_id": "123456789000-e4uksm38sne0bqrj6uvkbo4oiu4hvigl.apps.googleusercontent.com",
              "client_type": 3
            }
          ]
        },
        "google_signin_service": {
          "status": 2
        },
        "ads_service": {
          "status": 2,
          "test_banner_ad_unit_id": "ca-app-pub-3940256099942544/6300978111",
          "test_interstitial_ad_unit_id": "ca-app-pub-3940256099942544/1033173712"
        }
      }
    }
  ],
  "client_info": [],
  "ARTIFACT_VERSION": "1"
}
EOF
