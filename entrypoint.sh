#!/bin/bash

set -e

sanitize "${BUILD_FILE_NAME}" "build-file-name"
sanitize "${ANDROID_DEBUG_USERNAME}" "android_debug_username"
sanitize "${ANDROID_DEBUG_PASSWORD}" "android_debug_password"

# create update editor settings with debug user / pass
export path_to_editor_settings=root/.config/godot/editor_settings-3.tres
./edit-tres.sh $path_to_editor_settings export/android/debug_keystore_user ${ANDROID_DEBUG_USERNAME}
./edit-tres.sh $path_to_editor_settings export/android/debug_keystore_pass ${ANDROID_DEBUG_PASSWORD}

# create debug keystore
RUN mkdir -p usr/android-keys
cd /usr/lib/jvm/java-1.8.0-openjdk-amd64/bin
/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin/keytool -keyalg RSA -genkeypair -alias ${ANDROID_DEBUG_USERNAME} -keypass ${ANDROID_DEBUG_PASSWORD} -keystore debug.keystore -storepass ${ANDROID_DEBUG_PASSWORD} -dname "CN=Android Debug,O=Android,C=US" -validity 9999
mv debug.keystore /usr/android-keys/debug.keystore

# Export for HTML5
echo "Building ${BUILD_FILE_NAME} for Android"
mkdir -p ./build/android/
godot --export "Android" ./build/android/${BUILD_FILE_NAME}.apk

# Export for Linux
echo "Building ${BUILD_FILE_NAME} for Linux"
mkdir -p ./build/linux/
godot --export Linux/X11 ./build/linux/${BUILD_FILE_NAME}

# Export for Windows
echo "Building ${BUILD_FILE_NAME} for Windows"
mkdir -p ./build/windows/
godot --export "Windows Desktop" ./build/windows/${BUILD_FILE_NAME}.exe

# Export for OSX
echo "Building ${BUILD_FILE_NAME} for OSX"
mkdir -p ./build/mac/
godot --export "Mac OSX" ./build/mac/${BUILD_FILE_NAME}

# Export for HTML5
echo "Building ${BUILD_FILE_NAME} for HTML5"
mkdir -p ./build/html5/
godot --export "HTML5" ./build/html5/index.html
