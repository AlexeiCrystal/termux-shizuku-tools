#!/data/data/com.termux/files/usr/bin/bash

SHK_LIB_DIR="$PREFIX/libexec/shizuku"
RISH_DEX_NAME="rish_shizuku.dex"
RISH_DEX_PATH="$SHK_LIB_DIR/$RISH_DEX_NAME"

# Package name of the Shizuku app. Override it when Shizuku is installed under a
# different package name, e.g. with Shizuku-Next's package rename (stealth) mode:
: "${SHK_PKG:=moe.shizuku.privileged.api}"
SHK_SERVER_PROC_NAME="shizuku_server"
TERMUX_PKG="com.termux"
SHK_MAIN_ACTIVITY_CLASS="$SHK_PKG/moe.shizuku.manager.MainActivity"

SHK_CHECK_STR="shizuku_server_check"

export SHK_LIB_DIR RISH_DEX_NAME RISH_DEX_PATH SHK_PKG SHK_SERVER_PROC_NAME

is_shk_installed() {
    if cmd package list packages --user $(( $(id -u) / 100000 )) | grep -q "package:$SHK_PKG"; then
        echo "true"
    else
        echo "false"
    fi
}

get_shk_version_code() {
    if [ "$(is_shk_installed)" = "true" ]; then
        cmd package list packages --show-versioncode --user $(( $(id -u) / 100000 )) | grep "package:$SHK_PKG versionCode:" | awk -F':' '{print $NF}'
    else
        echo "-1"
    fi
}

execute_shk_command() {
    rish "$*"
}

open_shk_interactive_shell() {
    rish
}

open_shk() {
    am start -n $SHK_MAIN_ACTIVITY_CLASS > /dev/null 2>&1
}

stop_shk_server() {
    execute_shk_command "kill \$(pidof $SHK_SERVER_PROC_NAME)"
}

is_shk_server_running() {
    local CMD_OUTPUT
    CMD_OUTPUT=$(execute_shk_command "echo $SHK_CHECK_STR" 2>&1)

    # Match the marker as a whole line, so a banner printed before the command
    # (Shizuku-Next prints "Entering shell...") does not matter.
    if printf '%s\n' "$CMD_OUTPUT" | grep -qxF "$SHK_CHECK_STR"; then
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
    
    [ -z "$RISH_APPLICATION_ID" ] && export RISH_APPLICATION_ID="$TERMUX_PKG"

    # The shell loader asks the Shizuku app for the binder by package name. Loaders
    # built from Shizuku-Next read it from this variable instead of hardcoding it,
    # which is what makes a renamed/hidden package work.
    export MANAGER_APPLICATION_ID="$SHK_PKG"
    

    if [ $# -eq 0 ]; then
        /system/bin/app_process -Djava.class.path="$DEX" /system/bin --nice-name=rish rikka.shizuku.shell.ShizukuShellLoader
    else
        local cmd="$*"
        /system/bin/app_process -Djava.class.path="$DEX" /system/bin --nice-name=rish rikka.shizuku.shell.ShizukuShellLoader -c "$cmd"
    fi
}
