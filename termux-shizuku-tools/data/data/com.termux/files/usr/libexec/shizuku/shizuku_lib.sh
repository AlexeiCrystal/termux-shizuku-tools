#!/data/data/com.termux/files/usr/bin/bash

export SHIZUKU_LIB_DIR="$PREFIX/libexec/shizuku"
export RISH_DEX_NAME="rish_shizuku.dex"
export RISH_DEX_PATH="$SHIZUKU_LIB_DIR/$RISH_DEX_NAME"

is_shizuku_installed() {
    if cmd package list packages | grep -q "package:moe.shizuku.privileged.api"; then
        echo "true"
    else
        echo "false"
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
    rish "$*"
}

open_shizuku_interactive_shell() {
    rish
}

open_shizuku() {
    am start -n moe.shizuku.privileged.api/moe.shizuku.manager.MainActivity > /dev/null 2>&1
}

stop_shizuku_server() {
    execute_shizuku_command "kill \$(pidof shizuku_server)"
}

is_shizuku_server_running() {
    local CMD_OUTPUT=$(execute_shizuku_command "echo shizuku_server_check") 2>/dev/null
    
    if [ "$CMD_OUTPUT" = "shizuku_server_check" ]; then
        echo "true"
    else
        echo "false"
    fi
}

rish() {
    local DEX="$RISH_DEX_PATH"
    
    if [ ! -f "$DEX" ]; then
        echo "Cannot find $DEX, please check the tutorial in Shizuku app"
        return 1
    fi
    

    if [ $(getprop ro.build.version.sdk) -ge 34 ]; then
        if [ -w "$DEX" ]; then
            echo "On Android 14+, app_process cannot load writable dex."
            echo "Attempting to remove the write permission..."
            chmod 400 "$DEX"
        fi
        if [ -w "$DEX" ]; then
            echo "Cannot remove the write permission of $DEX."
            echo "You can copy to file to terminal app's private directory (/data/data/<package>), so that remove write permission is possible"
            return 1
        fi
    fi
    
    [ -z "$RISH_APPLICATION_ID" ] && export RISH_APPLICATION_ID="com.termux"
    

    if [ $# -eq 0 ]; then
        /system/bin/app_process -Djava.class.path="$DEX" /system/bin --nice-name=rish rikka.shizuku.shell.ShizukuShellLoader
    else
        local cmd="$*"
        /system/bin/app_process -Djava.class.path="$DEX" /system/bin --nice-name=rish rikka.shizuku.shell.ShizukuShellLoader -c "$cmd"
    fi
}