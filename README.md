# Description
Helps Termux get access to Shizuku

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
dpkg -i termux-shizuku-tools_1.0.deb
```

# Commands
`shizuku-setup` – Configure Termux access to Shizuku</br>
`shizuku-desetup` – Deconfigure Termux access to Shizuku</br>
`shizuku` – Run shizuku mode</br>
`shizuku-info` – Check package (termux-shizuku-tools) info and Shizuku info</br>
`shizuku-open` – Open Shizuku app</br>
`shizuku-help` – Command list</br>
Instead of `shizuku` in command names, you can use the abbreviated word `shk`

# How to build
1. Download [repository as zip](https://github.com/AlexeiCrystal/termux-shizuku-tools/archive/refs/heads/main.zip)</br>

2. Unzip archive</br>

3. Copy `termux-shizuku-tools` folder in main `termux-shizuku-tools-main` folder to Termux home directory
</br>For example:</br>
```
cp -r /sdcard/Download/termux-shizuku-tools-main/termux-shizuku-tools $HOME
```

</br>4. Grant needed permissions to `termux-shizuku-tools/DEBIAN` and `termux-shizuku-tools/DEBIAN/postinst`
</br>For example:
```
chmod 755 $HOME/termux-shizuku-tools/DEBIAN
```
```
chmod 755 $HOME/termux-shizuku-tools/DEBIAN/postinst
```

</br>5. Build package
</br>For example:
```
dpkg-deb --build $HOME/termux-shizuku-tools
```

</br>6. Install package
</br>For example:
```
dpkg -i $HOME/termux-shizuku-tools.deb
```
