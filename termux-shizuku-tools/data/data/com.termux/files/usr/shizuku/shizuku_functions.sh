#!/data/data/com.termux/files/usr/bin/sh

termux_shizuku_tools_version() {
    dpkg -s termux-shizuku-tools | grep '^Version:' | awk '{print $2}'
}

termux_shizuku_tools_version_code() {
    dpkg -s termux-shizuku-tools | grep '^X-Version-Code:' | awk '{print $2}'
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

open_shizuku() {
    am start -n moe.shizuku.privileged.api/moe.shizuku.manager.MainActivity
}

stop_shizuku_server() {
    execute_shizuku_command "kill \$(pidof shizuku_server)"
}

export stop_shizuku_server
export termux_shizuku_tools_version
export termux_shizuku_tools_directory
export is_shizuku_installed
export shizuku_version_code
export execute_shizuku_command
export open_shizuku
export termux_shizuku_tools_version_code
