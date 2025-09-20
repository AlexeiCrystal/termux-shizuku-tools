[English](/README.md) | Русский</br></br>

[![Последняя версия](https://img.shields.io/github/v/release/AlexeiCrystal/termux-shizuku-tools?label=%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%D0%B4%D0%BD%D1%8F%D1%8F%20%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D1%8F)](https://github.com/AlexeiCrystal/termux-shizuku-tools/releases/latest)
[![Загрузки](https://img.shields.io/github/downloads/AlexeiCrystal/termux-shizuku-tools/total?label=%D0%97%D0%B0%D0%B3%D1%80%D1%83%D0%B7%D0%BA%D0%B8)](https://github.com/AlexeiCrystal/termux-shizuku-tools/releases)
[![Проблемы](https://img.shields.io/github/issues/AlexeiCrystal/termux-shizuku-tools?label=%D0%9F%D1%80%D0%BE%D0%B1%D0%BB%D0%B5%D0%BC%D1%8B)](https://github.com/AlexeiCrystal/termux-shizuku-tools/issues)
[![Запросы на вытягивание](https://img.shields.io/github/issues-pr/AlexeiCrystal/termux-shizuku-tools?label=%D0%97%D0%B0%D0%BF%D1%80%D0%BE%D1%81%D1%8B%20%D0%BD%D0%B0%20%D0%B2%D1%8B%D1%82%D1%8F%D0%B3%D0%B8%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5)](https://github.com/AlexeiCrystal/termux-shizuku-tools/pulls)
[![Лицензия](https://img.shields.io/github/license/AlexeiCrystal/termux-shizuku-tools?label=%D0%9B%D0%B8%D1%86%D0%B5%D0%BD%D0%B7%D0%B8%D1%8F)](https://github.com/AlexeiCrystal/termux-shizuku-tools/blob/main/LICENCE.md)
[![Звёзды](https://img.shields.io/github/stars/AlexeiCrystal/termux-shizuku-tools?style=social&label=%D0%97%D0%B2%D1%91%D0%B7%D0%B4%D1%8B)](https://github.com/AlexeiCrystal/termux-shizuku-tools/stargazers)

# Описание
Позволяет [Termux](https://github.com/termux/termux-app) получить доступ к [Shizuku](https://github.com/RikkaApps/Shizuku)

# Требования
• Установленное и запущенное приложение [Shizuku](https://github.com/RikkaApps/Shizuku)
</br>• Установленное приложение [Termux](https://github.com/termux/termux-app)

# Как установить
1. Скачайте deb-файл из [последнего релиза](https://github.com/AlexeiCrystal/termux-shizuku-tools/releases/latest)
2. Перейдите в каталог, куда был скачан файл</br>
Например:</br>
```
cd /sdcard/Download
```
3. Установите пакет</br>
Например:</br>
```
dpkg -i termux-shizuku-tools_3.0.deb
```

# Команды
`shizuku` – Запустить режим интерактивной оболочки Shizuku</br>
`shizuku <команда>` – Выполнить команду через Shizuku</br>
`shizuku-info` – Проверить информацию о пакете (termux-shizuku-tools) и Shizuku</br>
`shizuku-open` – Открыть приложение Shizuku</br>
`shizuku-stop` – Остановить сервер Shizuku
`shizuku-help` – Список команд</br>
Вместо `shizuku` в названиях команд можно использовать сокращение `shk`

# Как собрать
1. Скачайте [репозиторий в виде zip-архива](https://github.com/AlexeiCrystal/termux-shizuku-tools/archive/refs/heads/main.zip)</br>

2. Разархивируйте архив</br>

3. Скопируйте папку `termux-shizuku-tools` из основной папки `termux-shizuku-tools-main` в домашний каталог Termux
</br>Например:</br>
```
cp -r /sdcard/Download/termux-shizuku-tools-main/termux-shizuku-tools $HOME
```

</br>4. Предоставьте необходимые разрешения для `termux-shizuku-tools/DEBIAN` и `termux-shizuku-tools/DEBIAN/postinst` и `termux-shizuku-tools/postrm`
</br>Например:
```
chmod 755 $HOME/termux-shizuku-tools/DEBIAN
```
```
chmod 755 $HOME/termux-shizuku-tools/DEBIAN/postinst
```
```
chmod 755 $HOME/termux-shizuku-tools/DEBIAN/postrm
```

</br>5. Соберите пакет
</br>Например:
```
dpkg-deb --build $HOME/termux-shizuku-tools
```

</br>6. Установите пакет
</br>Например:
```
dpkg -i $HOME/termux-shizuku-tools.deb
```

# История звёзд

[![Star History Chart](https://api.star-history.com/svg?repos=AlexeiCrystal/termux-shizuku-tools&type=Date)](https://www.star-history.com/#AlexeiCrystal/termux-shizuku-tools&Date)
