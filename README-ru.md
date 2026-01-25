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
## Через GitHub
1. Скачайте deb-файл из последнего релиза:
<p align="left">
  <a href="https://github.com/AlexeiCrystal/termux-shizuku-tools/releases/latest">
    <img src="assets/get-it-on-github.png" alt="Get it on GitHub" height="80">
  </a>
</p>

2. Перейдите в каталог, куда был скачан файл
</br> Например:</br>
```
cd /sdcard/Download
```
3. Установите пакет</br>
Например:</br>
```
dpkg -i termux-shizuku-tools.deb
```

# Команды
```
Использование: shizuku, shk <команда>

Команды:
  info, i              - Показать статус Shizuku
  open, o              - Открыть Shizuku
  stop, s              - Остановить сервер Shizuku
  execute, exec, e     - Выполнить команду через Shizuku
  shell, sh            - Запустить интерактивную оболочку Shizuku
  help, h              - Показать эту справку
  version, v           - Показать версию

Примеры:
  shizuku info
  shizuku exec "pm list packages"
  shizuku shell
```

# Как собрать
1. Скачайте [репозиторий как zip](https://github.com/AlexeiCrystal/termux-shizuku-tools/archive/refs/heads/main.zip)  
2. Выполните скрипт `build.sh` в корне репозитотория
</br>Например:  
```
bash /sdcard/Download/termux-shizuku-tools-main/build.sh
```
3. Установите пакет  </br>
Например:  
```
dpkg -i /sdcard/Download/termux-shizuku-tools-main/termux-shizuku-tools.deb
```

# История звёзд

[![Star History Chart](https://api.star-history.com/svg?repos=AlexeiCrystal/termux-shizuku-tools&type=Date)](https://www.star-history.com/#AlexeiCrystal/termux-shizuku-tools&Date)
