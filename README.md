English | [Русский](/README-ru.md)</br></br>
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/AlexeiCrystal/termux-shizuku-tools)](https://github.com/AlexeiCrystal/termux-shizuku-tools/releases/latest)
[![GitHub All Releases](https://img.shields.io/github/downloads/AlexeiCrystal/termux-shizuku-tools/total)](https://github.com/AlexeiCrystal/termux-shizuku-tools/releases)
[![GitHub issues](https://img.shields.io/github/issues/AlexeiCrystal/termux-shizuku-tools)](https://github.com/AlexeiCrystal/termux-shizuku-tools/issues)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/AlexeiCrystal/termux-shizuku-tools)](https://github.com/AlexeiCrystal/termux-shizuku-tools/pulls)
[![GitHub](https://img.shields.io/github/license/AlexeiCrystal/termux-shizuku-tools)](https://github.com/AlexeiCrystal/termux-shizuku-tools/blob/main/LICENCE.md)
[![GitHub Repo stars](https://img.shields.io/github/stars/AlexeiCrystal/termux-shizuku-tools?style=social)](https://github.com/AlexeiCrystal/termux-shizuku-tools/stargazers)
# Description
Helps [Termux](https://github.com/termux/termux-app) get access to [Shizuku](https://github.com/RikkaApps/Shizuku)

# Requirements
• [Shizuku](https://github.com/RikkaApps/Shizuku) installed and running
</br>• Installed [Termux](https://github.com/termux/termux-app)

# How to install
1. Download deb file from [latest release](https://github.com/AlexeiCrystal/termux-shizuku-tools/releases/latest)
2. Go to the directory where the file was downloaded to</br>
For example:</br>
```
cd /sdcard/Download
```
3. Install package</br>
For example:</br>
```
dpkg -i termux-shizuku-tools_3.0.deb
```

# Commands
`shizuku` – Run interactive shizuku shell mode</br>
`shizuku <command>` – Execute command via Shizuku</br>
`shizuku-info` – Check package (termux-shizuku-tools) info and Shizuku info</br>
`shizuku-open` – Open Shizuku app</br>
`shizuku-stop` – Stop Shizuku server</br>
`shizuku-help` – Command list</br>
Instead of `shizuku` in command names, you can use the abbreviated word `shk`

# How to build
1. Download [repository as zip](https://github.com/AlexeiCrystal/termux-shizuku-tools/archive/refs/heads/main.zip)</br>

</br>
2. Execute `build.sh` script at root of the repository
<br>For example:
```
sh /sdcard/Download/termux-shizuku-tools-main/build.sh
```

</br>
3. Install package
</br>For example:
```
dpkg -i $HOME/termux-shizuku-tools.deb
```
# Star History
[![Star History Chart](https://api.star-history.com/svg?repos=AlexeiCrystal/termux-shizuku-tools&type=Date)](https://www.star-history.com/#AlexeiCrystal/termux-shizuku-tools&Date)
