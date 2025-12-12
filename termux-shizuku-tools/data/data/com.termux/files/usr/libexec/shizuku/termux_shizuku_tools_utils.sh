#!/data/data/com.termux/files/usr/bin/bash

export TERMUX_SHIZUKU_TOOLS_REPO="https://github.com/AlexeiCrystal/termux-shizuku-tools"

termux_shizuku_tools_version() {
    dpkg -s termux-shizuku-tools | grep '^Version:' | awk '{print $2}'
}

termux_shizuku_tools_version_code() {
    dpkg -s termux-shizuku-tools | grep '^X-Version-Code:' | awk '{print $2}'
}

show_help() {
    echo "termux-shizuku-tools - Shizuku management utilities for Termux"
    echo ""
    echo "Usage: shizuku, shk <command>"
    echo ""
    echo "Commands:"
    echo "  info, i              - Show Shizuku status"
    echo "  open, o              - Open Shizuku Manager"
    echo "  stop, s              - Stop Shizuku server"
    echo "  execute, exec, e     - Execute command via Shizuku"
    echo "  shell, sh            - Start interactive Shizuku shell"
    echo "  help, h              - Show this help"
    echo "  version, v           - Show version"
    echo ""
    echo "Examples:"
    echo "  shizuku info"
    echo "  shizuku exec \"pm list packages\""
    echo "  shizuku shell"
}

show_version() {
    cat << EOF
termux-shizuku-tools v$(termux_shizuku_tools_version)
Shizuku management utilities for Termux

Author: AlexeiCrystal
Source: $TERMUX_SHIZUKU_TOOLS_REPO
Issues: $TERMUX_SHIZUKU_TOOLS_REPO/issues
EOF
}