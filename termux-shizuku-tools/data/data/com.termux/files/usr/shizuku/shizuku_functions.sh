#!/data/data/com.termux/files/usr/bin/sh

is_shizuku_installed() {
    if cmd package list packages | grep -q "package:moe.shizuku.privileged.api"; then
        return 0
    else
        return 1
    fi
}

export is_shizuku_installed

if is_shizuku_installed; then
    SHIZUKU_VERSION_CODE=$(cmd package list packages --show-versioncode | grep "package:moe.shizuku.privileged.api versionCode:" | awk -F':' '{print $NF}')
else
    SHIZUKU_VERSION_CODE="-1"
fi

export SHIZUKU_VERSION_CODE
