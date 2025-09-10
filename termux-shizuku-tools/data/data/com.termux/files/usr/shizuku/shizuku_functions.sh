#!/data/data/com.termux/files/usr/bin/sh

is_shizuku_installed() {
    if cmd package list packages | grep -q "package:moe.shizuku.privileged.api"; then
        return 0
    else
        return 1
    fi
}

shizuku_version_code() {
    if is_shizuku_installed; then
        cmd package list packages --show-versioncode | grep "package:moe.shizuku.privileged.api versionCode:" | awk -F':' '{print $NF}'
    else
        echo "-1"
    fi
}

export is_shizuku_installed
export shizuku_version_code
