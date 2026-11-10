#!/data/data/com.termux/files/usr/bin/bash

echo "Starting package build..."

CURRENT_DIR=$(dirname "$0")
PKG_NAME="termux-shizuku-tools"

# Shizuku-Next's shell loader reads MANAGER_APPLICATION_ID at runtime; a build can
# bake a non-default (hidden) package name in with that same variable, or with the
# package's own SHK_PKG. It becomes the default in shizuku_lib.sh, and can still
# be overridden at runtime.
BUILD_SHK_PKG="${MANAGER_APPLICATION_ID:-${SHK_PKG:-}}"

if [ -n "$BUILD_SHK_PKG" ]; then
    case "$BUILD_SHK_PKG" in
        *[!A-Za-z0-9._]*)
            echo "Error: invalid package name in MANAGER_APPLICATION_ID/SHK_PKG: $BUILD_SHK_PKG"
            exit 1
            ;;
    esac
fi

if [ -z "$BUILD_SHK_PKG" ]; then
    echo
    echo "  ┌─ Hiding Shizuku?"
    echo "  │  Set its package name through MANAGER_APPLICATION_ID (or SHK_PKG):"
    echo "  │    MANAGER_APPLICATION_ID=com.example.app make package"
    echo "  └─ If nothing is set, the default of moe.shizuku.privileged.api will be used."
    echo
fi

if [ ! -d "$CURRENT_DIR/$PKG_NAME" ]; then
    echo "Error: Package directory not found"
    exit 1
fi

# The rish loader dex is fetched, not committed; see the Makefile.
DEX_PATH="$CURRENT_DIR/$PKG_NAME/data/data/com.termux/files/usr/libexec/shizuku/rish_shizuku.dex"
if [ ! -f "$DEX_PATH" ]; then
    echo "Error: rish_shizuku.dex not found ($DEX_PATH)"
    echo "It is downloaded at build time. Run 'make package' (or 'make dex') first."
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
cp --recursive --preserve=mode "$CURRENT_DIR/$PKG_NAME" "$BUILD_DIR"

echo "Setting permissions for DEBIAN directory..."
chmod -R 755 "$BUILD_DIR/$PKG_NAME/DEBIAN"

# Bake the requested package name into the copy being packaged, keeping the
# runtime override in shizuku_lib.sh.
if [ -n "$BUILD_SHK_PKG" ]; then
    LIB_FILE="$BUILD_DIR/$PKG_NAME/data/data/com.termux/files/usr/libexec/shizuku/shizuku_lib.sh"
    sed -i "s|SHK_PKG:=[^}]*}|SHK_PKG:=${BUILD_SHK_PKG}}|" "$LIB_FILE"
    echo "Embedded Shizuku package name: $BUILD_SHK_PKG"
fi

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
