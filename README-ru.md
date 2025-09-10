[English](/README.md) | Русский

# Описание
Позволяет Termux получить доступ к Shizuku

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

dpkg -i termux-shizuku-tools_2.0.deb

```

# Команды
`shizuku-setup` – Настроить доступ Termux к Shizuku</br>
`shizuku-desetup` – Убрать настройки доступа Termux к Shizuku</br>
`shizuku` – Запустить режим Shizuku</br>
`shizuku-info` – Проверить информацию о пакете (termux-shizuku-tools) и Shizuku</br>
`shizuku-open` – Открыть приложение Shizuku</br>
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

</br>4. Предоставьте необходимые разрешения для `termux-shizuku-tools/DEBIAN` и `termux-shizuku-tools/DEBIAN/postinst`
</br>Например:
```

chmod 755 $HOME/termux-shizuku-tools/DEBIAN

```
```

chmod 755 $HOME/termux-shizuku-tools/DEBIAN/postinst

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
