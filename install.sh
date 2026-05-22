#!/bin/bash

# --- Предупреждение ---
echo "======================================================================"
echo "ВНИМАНИЕ: Скрипт распакует i3dots.zip и заменит текущие конфиги."
echo "WARNING: This script will extract i3dots.zip and overwrite your configs."
echo "======================================================================"

read -p "Продолжить? / Continue? (y/n): " confirm
if [[ $confirm != [yY] ]]; then exit 1; fi

# 1. Проверка, есть ли архив
if [ ! -f "i3dots.zip" ]; then
    echo "Ошибка: файл i3dots.zip не найден!"
    exit 1
fi

# 2. Распаковка архива
echo "Распаковка..."
unzip -o i3dots.zip -d . 

# 3. Установка зависимостей (оставляем как было)
echo "Определяю дистрибутив и ставлю зависимости..."
if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
        arch|manjaro|endeavouros|artix)
            sudo pacman -S --needed i3-wm rofi picom polybar feh xclip maim jq kitty bc
            ;;
        debian|ubuntu|pop|kali|linuxmint)
            sudo apt update && sudo apt install -y i3 rofi picom polybar feh xclip maim jq kitty bc
            ;;
        fedora)
            sudo dnf install -y i3 rofi picom polybar feh xclip maim jq kitty bc
            ;;
    esac
fi

# 4. Копирование конфигов
echo "Копирую конфиги..."
mkdir -p ~/.config/{i3,polybar,picom,kitty,rofi}
cp -r i3dots/i3wm/* ~/.config/i3/
cp -r i3dots/polybar/* ~/.config/polybar/
cp -r i3dots/picom/* ~/.config/picom/
cp -r i3dots/kitty/* ~/.config/kitty/
cp -r i3dots/rofi/* ~/.config/rofi/

# 5. Копирование обоев
echo "Устанавливаю обои..."
mkdir -p ~/wallpapers
ln -sf ~/Pictures/wallpapers/wall.png ~/wallpapers/wall.png
# 6. Права доступа
find ~/.config -name "*.sh" -exec chmod +x {} \;

echo "----------------------------------------------------------------------"
echo "Готово! Не забудь обновить путь к обоям в ~/.config/i3/config, если нужно."
echo "Done!"
