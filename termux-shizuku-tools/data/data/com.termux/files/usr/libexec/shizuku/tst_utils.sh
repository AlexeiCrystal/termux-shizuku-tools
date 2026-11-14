#!/data/data/com.termux/files/usr/bin/bash

source $PREFIX/libexec/shizuku/shizuku_lib.sh

G='\033[0;32m'
R='\033[0;31m'
Y='\033[0;33m'
C='\033[0;36m'
NC='\033[0m'

TICK="${G}✔${NC}"
CROSS="${R}✖${NC}"

TST_PKG="termux-shizuku-tools"
TST_GH_REPO_LINK="https://github.com/AlexeiCrystal/termux-shizuku-tools"

DOTS="..."

SHK_NOT_INST_ERR_MSG="Error: Shizuku is not installed"
SHK_UNK_CMD_ERR_MSG="Unknown command:"
HELP_CMD_TIP="Use 'shizuku help' for available commands"

SHK_LAUNCH_MSG="Launching Shizuku app$DOTS"
SHK_STOP_MSG="Stopping Shizuku server$DOTS"

SHK_I_SH_MSG="Starting Shizuku interactive shell$DOTS"
SHK_I_SH_EXIT_TIP="Type 'exit' to exit"

LOADING_INFO_MSG="Loading info${DOTS}"

SHK_SERV_STAT_STR_RUN="\033[1A\033[KServer:    ${TICK} Running"
SHK_SERV_STAT_STR_STOP="\033[1A\033[KServer:    ${CROSS} Stopped"
SHK_SERV_STAT_STR_LOADING="Server:    ${LOADING_INFO_MSG}"

SHK_INST_STAT_STR_YES="${NC}Installed: ${TICK} Yes"
SHK_INST_STAT_STR_NO="${NC}Installed: ${CROSS} No"

export TST_PKG \
       TST_GH_REPO_LINK \
       SHK_NOT_INST_ERR_MSG \
       SHK_UNK_CMD_ERR_MSG \
       SHK_LAUNCH_MSG \
       SHK_STOP_MSG \
       SHK_I_SH_MSG \
       SHK_I_SH_EXIT_TIP \
       HELP_CMD_TIP
       
tst_version() {
    dpkg -s "$TST_PKG" 2>/dev/null | grep '^Version:' | awk '{print $2}' || echo "unknown"
}

tst_version_code() {
    dpkg -s "$TST_PKG" 2>/dev/null | grep '^X-Version-Code:' | awk '{print $2}' || echo "0"
}

show_help() {
    cat << EOF
$TST_PKG - Shizuku utilities for Termux

Usage: shizuku, shk <command>

Commands:
  status, st, i, info  - Show Shizuku status & info
  open, o              - Open Shizuku app
  stop, s              - Stop Shizuku server
  execute, exec, e     - Execute command via Shizuku
  shell, sh            - Start interactive Shizuku shell
  config, cfg
    get                - Get config
    get key            - Get config key
    set key value      - Set config key
    reset              - Reset config
    reset key          - Reset config key
  help, h              - Show this help
  version, v           - Show utility version

Examples:
  shk status
  shk exec pm list packages
  shk shell
EOF
}

show_version() {
    cat << EOF
$TST_PKG v$(tst_version)
Shizuku utilities for Termux

Author: AlexeiCrystal
Source: $TST_GH_REPO_LINK
Issues: $TST_GH_REPO_LINK/issues
EOF
}

show_status() {
    echo -e "${NC}Package:   ${Y}$(get_shizuku_pkg)${NC}"

    if is_shizuku_installed; then
        echo -e "$SHK_INST_STAT_STR_YES"
        
        echo -e "${NC}Version:   ${Y}$(get_shizuku_version_code)${NC}"
        
        echo -e "$SHK_SERV_STAT_STR_LOADING"
        if is_shizuku_server_running; then
            echo -e "$SHK_SERV_STAT_STR_RUN"
            
            echo "UID:       ${LOADING_INFO_MSG}"
            uid=$(get_shizuku_uid)
            echo -e "\033[1A\033[KUID:       $uid ($(get_shizuku_uid_name $uid))"
        else
            echo -e "$SHK_SERV_STAT_STR_STOP"
        fi
    else
        echo -e "$SHK_INST_STAT_STR_NO"
    fi

}