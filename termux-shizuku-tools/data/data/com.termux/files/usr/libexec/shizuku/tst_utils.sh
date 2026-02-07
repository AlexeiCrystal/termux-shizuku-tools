#!/data/data/com.termux/files/usr/bin/bash

G='\033[0;32m'
R='\033[0;31m'
Y='\033[0;33m'
C='\033[0;36m'
NC='\033[0m'

TICK="${G}✔${NC}"
CROSS="${R}✖${NC}"

TST_PKG="termux-shizuku-tools"
TST_GH_REPO_LINK="https://github.com/AlexeiCrystal/termux-shizuku-tools"

SHK_WEB_URL="https://shizuku.rikka.app"

DOTS="..."

SHK_NOT_INST_ERR_MSG="Error: Shizuku is not installed"
SHK_UNK_CMD_ERR_MSG="Unknown command:"
HELP_CMD_TIP="Use 'shizuku help' for available commands"

SHK_LAUNCH_MSG="Launching Shizuku app$DOTS"
SHK_STOP_MSG="Stopping Shizuku server$DOTS"

SHK_I_SH_MSG="Starting Shizuku interactive shell$DOTS"
SHK_I_SH_EXIT_TIP="Type 'exit' to exit"

SHK_SERV_STAT_STR_RUN=" \033[1A\033[KServer:    ${TICK} Running"
SHK_SERV_STAT_STR_STOP=" \033[1A\033[KServer:    ${CROSS} Stopped"
SHK_SERV_STAT_STR_LOADING=" Server:    Loading info${DOTS}"

SHK_INST_STAT_STR_YES=" ${NC}Installed: ${TICK} Yes"
SHK_INST_STAT_STR_NO=" ${NC}Installed: ${CROSS} No"

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
$TST_PKG - Shizuku management utilities for Termux

Usage: shizuku, shk <command>

Commands:
  status, st, i        - Show Shizuku status & info
  open, o              - Open Shizuku app
  stop, s              - Stop Shizuku server
  execute, exec, e     - Execute command via Shizuku
  shell, sh            - Start interactive Shizuku shell
  help, h              - Show this help
  version, v           - Show version

Examples:
  shk status
  shk exec "pm list packages"
  shk shell
EOF
}

show_version() {
    cat << EOF
$TST_PKG v$(tst_version)
Shizuku management utilities for Termux

Author: AlexeiCrystal
Source: $TST_GH_REPO_LINK
Issues: $TST_GH_REPO_LINK/issues
EOF
}

show_status() {
    source "$PREFIX/libexec/shizuku/shizuku_lib.sh"
    echo -e "${NC} Package:   ${Y}${SHK_PKG}${NC}"
    echo -e "${NC} Website:   ${B}$SHK_WEB_URL${NC}"
    
    local installed=$(is_shk_installed)
    
    if [ "$installed" = "true" ]; then
        echo -e "$SHK_INST_STAT_STR_YES"
        
        local v_code=$(get_shk_version_code)
        echo -e "${NC} Version:   ${Y}${v_code}${NC}"
        echo -e "$SHK_SERV_STAT_STR_LOADING"
        local running=$(is_shk_server_running)
        if [ "$running" = "true" ]; then
            echo -e "$SHK_SERV_STAT_STR_RUN"
        else
            echo -e "$SHK_SERV_STAT_STR_STOP"
        fi
    else
        echo -e "$SHK_INST_STAT_STR_NO"
    fi

}
