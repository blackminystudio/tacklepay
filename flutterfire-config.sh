#!/bin/bash
# Script to generate Firebase configuration files for different environments/flavors
# Feel free to reuse and adapt this script for your own projects

if [[ $# -eq 0 ]]; then
  echo "Error: No environment specified. Use 'dev', 'staging', or 'prod'."
  exit 1
fi

case $1 in
  dev)
    flutterfire config \
      --project=tacklepay-dev \
      --out=lib/firebase_options_dev.dart \
      --ios-bundle-id=com.blackminystudio.tacklepaydev \
      --ios-out=ios/flavors/dev/GoogleService-Info.plist \
      --android-package-name=com.blackminystudio.tacklepaydev \
      --android-out=android/app/src/dev/google-services.json
    ;;
  staging)
    flutterfire config \
      --project=tacklepay-staging \
      --out=lib/firebase_options_staging.dart \
      --ios-bundle-id=com.blackminystudio.tacklepaystaging \
      --ios-out=ios/flavors/staging/GoogleService-Info.plist \
      --android-package-name=com.blackminystudio.tacklepaystaging \
      --android-out=android/app/src/staging/google-services.json
    ;;
  prod)
    flutterfire config \
      --project=tacklepay-prod \
      --out=lib/firebase_options_prod.dart \
      --ios-bundle-id=com.blackminystudio.tacklepay \
      --ios-out=ios/flavors/prod/GoogleService-Info.plist \
      --android-package-name=com.blackminystudio.tacklepay \
      --android-out=android/app/src/prod/google-services.json
    ;;
  *)
    echo "Error: Invalid environment specified. Use 'dev', 'staging', or 'prod'."
    exit 1
    ;;
esac
