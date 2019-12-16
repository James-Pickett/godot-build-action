#!/bin/bash

set -e

# Export for HTML5
echo "Building ${PROJECT} for Android"
mkdir -p ./build/android/
godot --export "Android" ./build/android/${PROJECT}.apk

# Export for Linux
echo "Building ${PROJECT} for Linux"
mkdir -p ./build/linux/
godot --export Linux/X11 ./build/linux/${PROJECT}

# Export for Windows
echo "Building ${PROJECT} for Windows"
mkdir -p ./build/windows/
godot --export "Windows Desktop" ./build/windows/${PROJECT}.exe

# Export for OSX
echo "Building ${PROJECT} for OSX"
mkdir -p ./build/mac/
godot --export "Mac OSX" ./build/mac/${PROJECT}

# Export for HTML5
echo "Building ${PROJECT} for HTML5"
mkdir -p ./build/html5/
godot --export "HTML5" ./build/html5/index.html
