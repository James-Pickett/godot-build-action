#!/bin/bash

set -e

# create update editor settings with debug user / pass
export path_to_editor_settings=/root/.config/godot/editor_settings-3.tres
/edit-tres.sh $path_to_editor_settings export/android/debug_keystore_user ${INPUT_ANDROID_DEBUG_USERNAME}
/edit-tres.sh $path_to_editor_settings export/android/debug_keystore_pass ${INPUT_ANDROID_DEBUG_PASSWORD}

# create debug keystore
RUN mkdir -p usr/android-keys
cd /usr/lib/jvm/java-1.8.0-openjdk-amd64/bin
keytool -keyalg RSA -genkeypair -alias ${INPUT_ANDROID_DEBUG_USERNAME} -keypass ${INPUT_ANDROID_DEBUG_PASSWORD} -keystore debug.keystore -storepass ${ANDROID_DEBUG_PASSWORD} -dname "CN=Android Debug,O=Android,C=US" -validity 9999
mv debug.keystore /usr/android-keys/debug.keystore
cd /

# Export for HTML5
echo "Building ${INPUT_BUILD_FILE_NAME} for Android"
mkdir -p ./build/android/
godot --export "Android" ./build/android/${INPUT_BUILD_FILE_NAME}.apk

# Export for Linux
echo "Building ${INPUT_BUILD_FILE_NAME} for Linux"
mkdir -p ./build/linux/
godot --export Linux/X11 ./build/linux/${INPUT_BUILD_FILE_NAME}

# Export for Windows
echo "Building ${INPUT_BUILD_FILE_NAME} for Windows"
mkdir -p ./build/windows/
godot --export "Windows Desktop" ./build/windows/${INPUT_BUILD_FILE_NAME}.exe

# Export for OSX
echo "Building ${INPUT_BUILD_FILE_NAME} for OSX"
mkdir -p ./build/mac/
godot --export "Mac OSX" ./build/mac/${INPUT_BUILD_FILE_NAME}

# Export for HTML5
echo "Building ${INPUT_BUILD_FILE_NAME} for HTML5"
mkdir -p ./build/html5/
godot --export "HTML5" ./build/html5/index.html
