FROM jaypickle/godot-build:3.1.2
LABEL author="james@pickett.me"

# create update editor settings with debug user / pass
RUN export path_to_editor_settings=root/.config/godot/editor_settings-3.tres \
    && ./edit-tres.sh $path_to_editor_settings export/android/debug_keystore_user ${{ secrets.ANDROID_DEBUG_USERNAME }} \
    && ./edit-tres.sh $path_to_editor_settings export/android/debug_keystore_pass ${{ secrets.ANDROID_DEBUG_PASSWORD }}

# create debug keystore
RUN mkdir -p usr/android-keys \
    && cd /usr/lib/jvm/java-1.8.0-openjdk-amd64/bin \
    && keytool -keyalg RSA -genkeypair -alias ${{ secrets.ANDROID_DEBUG_USERNAME }} -keypass ${{ secrets.ANDROID_DEBUG_PASSWORD }} -keystore debug.keystore -storepass ${{ secrets.ANDROID_DEBUG_PASSWORD }} -dname "CN=Android Debug,O=Android,C=US" -validity 9999 \
    && mv debug.keystore /usr/android-keys/debug.keystore

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]