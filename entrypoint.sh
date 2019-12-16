#!/bin/bash

set -e

# create update editor settings with debug user / pass
export path_to_editor_settings=/root/.config/godot/editor_settings-3.tres
/edit-tres.sh $path_to_editor_settings export/android/debug_keystore_user ${INPUT_ANDROID_DEBUG_USERNAME}
/edit-tres.sh $path_to_editor_settings export/android/debug_keystore_pass ${INPUT_ANDROID_DEBUG_PASSWORD}

# create debug keystore
mkdir -p /usr/android-keys/
/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin/keytool -genkeypair -keyalg RSA -alias "${INPUT_ANDROID_DEBUG_USERNAME}" -keypass "${INPUT_ANDROID_DEBUG_PASSWORD}" -keystore debug.keystore -storepass "${INPUT_ANDROID_DEBUG_PASSWORD}" -dname "CN=Android Debug,O=Android,C=US" -validity 9999
mv ./debug.keystore /usr/android-keys/debug.keystore

#REMOVE AFTER DEBUGGING
echo "User_settings"
cat path_to_editor_settings

cd /project

# Export for HTML5
echo "Building ${INPUT_BUILD_FILE_NAME} for Android"
mkdir -p ./build/android/
godot --export-debug project.godot "Android" ./build/android/${INPUT_BUILD_FILE_NAME}.apk -v

# Export for Linux
echo "Building ${INPUT_BUILD_FILE_NAME} for Linux"
mkdir -p ./build/linux/
godot --export project.godot Linux/X11 ./build/linux/${INPUT_BUILD_FILE_NAME} -v

# Export for Windows
echo "Building ${INPUT_BUILD_FILE_NAME} for Windows"
mkdir -p ./build/windows/
godot --export project.godot "Windows Desktop" ./build/windows/${INPUT_BUILD_FILE_NAME}.exe -v

# Export for OSX
echo "Building ${INPUT_BUILD_FILE_NAME} for OSX"
mkdir -p ./build/mac/
godot --export project.godot "Mac OSX" ./build/mac/${INPUT_BUILD_FILE_NAME} -v

# Export for HTML5
echo "Building ${INPUT_BUILD_FILE_NAME} for HTML5"
mkdir -p ./build/html5/
godot --export project.godot "HTML5" ./build/html5/index.html -v
