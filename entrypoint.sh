#!/bin/bash

set -e

wget https://downloads.tuxfamily.org/godotengine/3.1.1/Godot_v3.1.1-stable_export_templates.tpz --quiet
mkdir ~/.cache
mkdir -p ~/.config/godot
mkdir -p ~/.local/share/godot/templates/3.1.1.stable
unzip Godot_v3.1.1-stable_export_templates.tpz
mv templates/* ~/.local/share/godot/templates/3.1.1.stable
rm -f Godot_v3.1.1-stable_export_templates.tpz

# create editor_settings
export path_to_editor_settings=/github/home/.config/godot/editor_settings-3.tres
mkdir -p $(dirname "$path_to_editor_settings")
touch $path_to_editor_settings
echo "[gd_resource type=\"EditorSettings\" format=2]" >> $path_to_editor_settings
echo "[resource]" >> $path_to_editor_settings
/edit-tres.sh $path_to_editor_settings export/android/adb /opt/android-sdk-linux/platform-tools/adb
/edit-tres.sh $path_to_editor_settings export/android/jarsigner /usr/lib/jvm/java-8-openjdk-amd64/bin/jarsigner
/edit-tres.sh $path_to_editor_settings export/android/debug_keystore /usr/android-keys/debug.keystore

# update editor settings with debug user / pass
/edit-tres.sh $path_to_editor_settings export/android/debug_keystore_user ${INPUT_ANDROID_DEBUG_USERNAME}
/edit-tres.sh $path_to_editor_settings export/android/debug_keystore_pass ${INPUT_ANDROID_DEBUG_PASSWORD}

# create debug keystore
mkdir -p /usr/android-keys/
/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin/keytool -genkeypair -keyalg RSA -alias "${INPUT_ANDROID_DEBUG_USERNAME}" -keypass "${INPUT_ANDROID_DEBUG_PASSWORD}" -keystore debug.keystore -storepass "${INPUT_ANDROID_DEBUG_PASSWORD}" -dname "CN=Android Debug,O=Android,C=US" -validity 9999
mv ./debug.keystore /usr/android-keys/debug.keystore

# Export for HTML5
echo "Building ${INPUT_BUILD_FILE_NAME} for Android"
mkdir -p ./build/android/
godot --export-debug Android ./build/android/${INPUT_BUILD_FILE_NAME}.apk -v

# Export for Linux
echo "Building ${INPUT_BUILD_FILE_NAME} for Linux"
mkdir -p ./build/linux/
godot --export Linux/X11 ./build/linux/${INPUT_BUILD_FILE_NAME} -v

# Export for Windows
echo "Building ${INPUT_BUILD_FILE_NAME} for Windows"
mkdir -p ./build/windows/
godot --export "Windows Desktop" ./build/windows/${INPUT_BUILD_FILE_NAME}.exe -v

# Export for OSX
echo "Building ${INPUT_BUILD_FILE_NAME} for OSX"
mkdir -p ./build/mac/
godot --export "Mac OSX" ./build/mac/${INPUT_BUILD_FILE_NAME} -v

# Export for HTML5
echo "Building ${INPUT_BUILD_FILE_NAME} for HTML5"
mkdir -p ./build/html5/
godot --export "HTML5" ./build/html5/index.html -v
