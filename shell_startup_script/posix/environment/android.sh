#! /bin/sh

if [[ -d /opt/android-sdk ]]; then
  
  export ANDROID_SDK=/opt/android-sdk
  export ANDROID_NDK=/opt/android-ndk
  
  export PATH="$ANDROID_SDK/platform-tools:$PATH"
fi
