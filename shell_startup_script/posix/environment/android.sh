#! /bin/sh

if [[ -d /opt/android-sdk ]]; then

    export ANDROID_SDK_ROOT="/opt/android-sdk/"
    export ANDROID_HOME="${ANDROID_SDK_ROOT}"
    export ANDROID_NDK_ROOT="/opt/android-sdk/ndk-bundle/"
    export ANDROID_NDK="$ANDROID_NDK_ROOT"

    export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"
fi
