#!/data/data/com.termux/files/usr/bin/bash

CURRENT_DIR=$(dirname "$0")
PKG_NAME="termux-shizuku-tools"

if [ ! -d "$CURRENT_DIR/$PKG_NAME" ]; then
    exit 1
fi

DEX_PATH="$CURRENT_DIR/$PKG_NAME/data/data/com.termux/files/usr/libexec/shizuku/rish_shizuku.dex"
if [ ! -f "$DEX_PATH" ]; then
    exit 1
fi

if [ ! -d "$PREFIX/tmp" ]; then
    mkdir -p "$PREFIX/tmp"
fi

BUILD_DIR=$(mktemp -d)
if [ ! -d "$BUILD_DIR" ]; then
    exit 1
fi

cp --recursive --preserve=mode "$CURRENT_DIR/$PKG_NAME" "$BUILD_DIR"
chmod -R 755 "$BUILD_DIR/$PKG_NAME/DEBIAN"

if [ -n "$BUILD_SHK_PKG" ]; then
    LIB_FILE="$BUILD_DIR/$PKG_NAME/data/data/com.termux/files/usr/libexec/shizuku/shizuku_lib.sh"
    sed -i "s|SHK_PKG:=[^}]*}|SHK_PKG:=${BUILD_SHK_PKG}}|" "$LIB_FILE"
fi

dpkg-deb --build "$BUILD_DIR/$PKG_NAME"

if [ ! -f "$BUILD_DIR/$PKG_NAME.deb" ]; then
    rm -rf "$BUILD_DIR"
    exit 1
fi

cp -f "$BUILD_DIR/$PKG_NAME.deb" "$CURRENT_DIR"
rm -rf "$BUILD_DIR"

exit 0