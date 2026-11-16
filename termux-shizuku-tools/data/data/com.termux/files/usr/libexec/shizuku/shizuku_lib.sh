#!/data/data/com.termux/files/usr/bin/bash

SHIZUKU_LIB_DIR="$PREFIX/libexec/shizuku"
SHIZUKU_DEX_NAME="rish_shizuku.dex"
SHIZUKU_DEX_PATH="$SHIZUKU_LIB_DIR/$SHIZUKU_DEX_NAME"
TERMUX_PKG="com.termux"
SHIZUKU_CHECK_STR="shizuku_server_check"

SHIZUKU_MAIN_ACTIVITY_CLASS="moe.shizuku.manager.MainActivity"
SHIZUKU_SERVER_PROC_NAME="shizuku_server"

export SHIZUKU_LIB_DIR SHIZUKU_DEX_NAME SHIZUKU_DEX_PATH TERMUX_PKG SHIZUKU_CHECK_STR SHIZUKU_MAIN_ACTIVITY_CLASS SHIZUKU_SERVER_PROC_NAME

is_shizuku_installed() {
    cmd package list packages --user $(( $(id -u) / 100000 )) | grep -q "^package:$(get_shizuku_pkg)$"
}

get_shizuku_pkg() {
    source "$SHIZUKU_LIB_DIR/shizuku_config.sh"
    get_shizuku_config_key "package"
}

get_shizuku_version_code() {
    if is_shizuku_installed; then
        cmd package list packages --show-versioncode --user $(( $(id -u) / 100000 )) | grep "package:$(get_shizuku_pkg) versionCode:" | awk -F':' '{print $NF}'
    else
        return 1
    fi
}

execute_shizuku_command() {
    rish "$*"
}

open_shizuku_shell() {
    rish
}

open_shizuku() {
    am start -n "$(get_shizuku_pkg)/$SHIZUKU_MAIN_ACTIVITY_CLASS" > /dev/null 2>&1
}

stop_shizuku_server() {
    execute_shizuku_command "kill \$(pidof $SHIZUKU_SERVER_PROC_NAME)"
}

is_shizuku_server_running() {
    local CMD_OUTPUT
    CMD_OUTPUT=$(execute_shizuku_command "echo $SHIZUKU_CHECK_STR" 2>&1)

    printf '%s\n' "$CMD_OUTPUT" | grep -qxF "$SHIZUKU_CHECK_STR"
}

get_shizuku_uid() {
    execute_shizuku_command "id -u"
}

get_shizuku_uid_name() {
    local uid
    if [ $# -gt 0 ]; then
        uid="$1"
    else
        uid="$(get_shizuku_uid)"
    fi

    case "$uid" in
        0)    printf '%s' "root"    ;;
        1000) printf '%s' "system"  ;;
        2000) printf '%s' "shell"   ;;
        *)    printf '%s' "unknown" ;;
    esac
}

rish() {
    local DEX="$SHIZUKU_DEX_PATH"
    
    if [ ! -f "$DEX" ]; then
        echo "Cannot find $DEX, please check the tutorial in Shizuku app"
        return 1
    fi

    if [ $(getprop ro.build.version.sdk) -ge 34 ]; then
        if [ -w "$DEX" ]; then
            chmod 400 "$DEX"
        fi
    fi
    
    [ -z "$RISH_APPLICATION_ID" ] && RISH_APPLICATION_ID="$TERMUNCH_PKG"
    local mgr_pkg
    mgr_pkg="$(get_shizuku_pkg)"

    if [ $# -eq 0 ]; then
        RISH_APPLICATION_ID="$RISH_APPLICATION_ID" MANAGER_APPLICATION_ID="$mgr_pkg" \
        /system/bin/app_process -Djava.class.path="$DEX" /system/bin --nice-name=rish rikka.shizuku.shell.ShizukuShellLoader
    else
        local cmd="$*"
        local output
        output="$(RISH_APPLICATION_ID="$RISH_APPLICATION_ID" MANAGER_APPLICATION_ID="$mgr_pkg" \
             /system/bin/app_process -Djava.class.path="$DEX" /system/bin --nice-name=rish rikka.shizuku.shell.ShizukuShellLoader -c "$cmd" 2>&1)"
        
        printf '%s\n' "$output" | sed '1{/^Entering shell...$/d}'
    fi
}