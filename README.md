English | [Русский](/README-ru.md)  </br></br>
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/AlexeiCrystal/termux-shizuku-tools)](https://github.com/AlexeiCrystal/termux-shizuku-tools/releases/latest)
[![GitHub All Releases](https://img.shields.io/github/downloads/AlexeiCrystal/termux-shizuku-tools/total)](https://github.com/AlexeiCrystal/termux-shizuku-tools/releases)
[![GitHub issues](https://img.shields.io/github/issues/AlexeiCrystal/termux-shizuku-tools)](https://github.com/AlexeiCrystal/termux-shizuku-tools/issues)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/AlexeiCrystal/termux-shizuku-tools)](https://github.com/AlexeiCrystal/termux-shizuku-tools/pulls)
[![GitHub](https://img.shields.io/github/license/AlexeiCrystal/termux-shizuku-tools)](https://github.com/AlexeiCrystal/termux-shizuku-tools/blob/main/LICENCE.md)
[![GitHub Repo stars](https://img.shields.io/github/stars/AlexeiCrystal/termux-shizuku-tools?style=social)](https://github.com/AlexeiCrystal/termux-shizuku-tools/stargazers)
[![Build package](https://github.com/AlexeiCrystal/termux-shizuku-tools/actions/workflows/build-den-in-push.yml/badge.svg)](https://github.com/AlexeiCrystal/termux-shizuku-tools/actions/workflows/build-den-in-push.yml)

# Description
Helps [Termux](https://github.com/termux/termux-app) get access to [Shizuku](https://github.com/RikkaApps/Shizuku)

# Requirements
• [Shizuku](https://github.com/RikkaApps/Shizuku) installed and running  
• Installed [Termux](https://github.com/termux/termux-app)

# How to install
1. Download deb file from [latest release](https://github.com/AlexeiCrystal/termux-shizuku-tools/releases/latest)
2. Go to the directory where the file was downloaded to  
For example:  
```
cd /sdcard/Download
```
3. Install package  
For example:  
```
dpkg -i termux-shizuku-tools_4.0.deb
```

# Commands
```
Usage: shizuku, shk <command>

Commands:
  info, i              - Show Shizuku status
  open, o              - Open Shizuku
  stop, s              - Stop Shizuku server
  execute, exec, e     - Execute command via Shizuku
  shell, sh            - Start interactive Shizuku shell
  help, h              - Show this help
  version, v           - Show version

Examples:
  shizuku info
  shizuku exec "pm list packages"
  shizuku shell
```

# How to build
1. Download [repository as zip](https://github.com/AlexeiCrystal/termux-shizuku-tools/archive/refs/heads/main.zip)  
2. Execute `build.sh` script at root of the repository  
For example:  
```
bash /sdcard/Download/termux-shizuku-tools-main/build.sh
```
3. Install package  
For example:  
```
dpkg -i /sdcard/Download/termux-shizuku-tools-main/termux-shizuku-tools.deb
```

# Star History
[![Star History Chart](https://api.star-history.com/svg?repos=AlexeiCrystal/termux-shizuku-tools&type=Date)](https://www.star-history.com/#AlexeiCrystal/termux-shizuku-tools&Date)
