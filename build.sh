#!/data/data/com.termux/files/usr/bin/bash

echo "Starting package build..."

CURRENT_DIR=$(dirname "$0")
PKG_NAME="termux-shizuku-tools"

if [ ! -d "$CURRENT_DIR/$PKG_NAME" ]; then
    echo "Error: Package directory not found"
    exit 1
fi

echo "Creating temporary directory for building package..."
if [ ! -d "$PREFIX/tmp" ]; then
    mkdir -p "$PREFIX/tmp"
fi

BUILD_DIR=$(mktemp -d)
if [ ! -d "$BUILD_DIR" ]; then
    echo "Error: Temporary directory not found"
    exit 1
fi

echo "Copying package directory to temporary directory..."
cp -rf "$CURRENT_DIR/$PKG_NAME" "$BUILD_DIR"

echo "Setting permissions for DEBIAN directory..."
chmod -R 755 "$BUILD_DIR/$PKG_NAME/DEBIAN"

echo "Building package..."
dpkg-deb --build "$BUILD_DIR/$PKG_NAME"

if [ ! -f "$BUILD_DIR/$PKG_NAME.deb" ]; then
    echo "Error: Package file was not created"
    echo "Removing temporary directory..."
    rm -rf "$BUILD_DIR"
    exit 1
fi

echo "Copying built package file..."
cp -f "$BUILD_DIR/$PKG_NAME.deb" "$CURRENT_DIR"

echo "Removing temporary directory..."
rm -rf "$BUILD_DIR"

echo "Build completed successfully!"
exit 0
