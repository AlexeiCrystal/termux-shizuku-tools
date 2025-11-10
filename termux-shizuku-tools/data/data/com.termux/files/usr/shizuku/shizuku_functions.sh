#!/data/data/com.termux/files/usr/bin/bash

termux_shizuku_tools_version() {
    dpkg -s termux-shizuku-tools | grep '^Version:' | awk '{print $2}'
}
export termux_shizuku_tools_version

termux_shizuku_tools_version_code() {
    dpkg -s termux-shizuku-tools | grep '^X-Version-Code:' | awk '{print $2}'
}
export termux_shizuku_tools_version_code

termux_shizuku_tools_directory() {
    echo "$PREFIX/shizuku"
}
export termux_shizuku_tools_directory

is_shizuku_installed() {
    if cmd package list packages | grep -q "package:moe.shizuku.privileged.api"; then
        echo true
    else
        echo false
    fi
}
export is_shizuku_installed

shizuku_version_code() {
    if [ "$(is_shizuku_installed)" = "true" ]; then
        cmd package list packages --show-versioncode | grep "package:moe.shizuku.privileged.api versionCode:" | awk -F':' '{print $NF}'
    else
        echo "-1"
    fi
}
export shizuku_version_code

execute_shizuku_command() {
    $PREFIX/shizuku/rish -c "$1"
}
export execute_shizuku_command

open_shizuku() {
    am start -n moe.shizuku.privileged.api/moe.shizuku.manager.MainActivity > /dev/null 2>&1
}
export open_shizuku

stop_shizuku_server() {
    execute_shizuku_command "kill \$(pidof shizuku_server)"
}
export stop_shizuku_server

is_shizuku_server_running() {
    local CMD_OUTPUT=$(execute_shizuku_command "echo shizuku_server_check") > /dev/null 2>&1
    
    if [ "$CMD_OUTPUT" = "shizuku_server_check" ]; then
        echo "true"
    else
        echo "false"
    fi
}
export is_shizuku_server_running
