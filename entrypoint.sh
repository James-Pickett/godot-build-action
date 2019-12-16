#!/bin/bash

set -e

# Export for HTML5
echo "Building ${build-file-name} for Android"
mkdir -p ./build/android/
godot --export "Android" ./build/android/${build-file-name}.apk

# Export for Linux
echo "Building ${build-file-name} for Linux"
mkdir -p ./build/linux/
godot --export Linux/X11 ./build/linux/${build-file-name}

# Export for Windows
echo "Building ${build-file-name} for Windows"
mkdir -p ./build/windows/
godot --export "Windows Desktop" ./build/windows/${build-file-name}.exe

# Export for OSX
echo "Building ${build-file-name} for OSX"
mkdir -p ./build/mac/
godot --export "Mac OSX" ./build/mac/${build-file-name}

# Export for HTML5
echo "Building ${build-file-name} for HTML5"
mkdir -p ./build/html5/
godot --export "HTML5" ./build/html5/index.html
