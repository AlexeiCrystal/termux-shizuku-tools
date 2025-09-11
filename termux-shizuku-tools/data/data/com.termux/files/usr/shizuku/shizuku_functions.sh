#!/data/data/com.termux/files/usr/bin/sh

termux_shizuku_tools_version() {
    echo "3.0"
}

termux_shizuku_tools_directory() {
    echo "$PREFIX/shizuku"
}

is_shizuku_installed() {
    if cmd package list packages | grep -q "package:moe.shizuku.privileged.api"; then
        echo true
    else
        echo false
    fi
}

shizuku_version_code() {
    if [ "$(is_shizuku_installed)" = "true" ]; then
        cmd package list packages --show-versioncode | grep "package:moe.shizuku.privileged.api versionCode:" | awk -F':' '{print $NF}'
    else
        echo "-1"
    fi
}

execute_shizuku_command() {
    $PREFIX/shizuku/rish -c "$1"
}

export termux_shizuku_tools_version
export termux_shizuku_tools_directory
export is_shizuku_installed
export shizuku_version_code
export execute_shizuku_command
