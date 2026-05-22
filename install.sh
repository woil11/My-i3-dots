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
    echo "Ошибка: файл i3dots.zip не найден в текущей директории!"
    exit 1
fi

# 2. Распаковка архива
echo "Распаковка архива..."
unzip -o i3dots.zip -d .

# --- Установка зависимостей (оставляем как было) ---
# [Здесь блок определения системы из предыдущего сообщения]

# --- Установка конфигов ---
# Теперь скрипт берет файлы из распакованной папки i3dots/
mkdir -p ~/.config/{i3,polybar,picom,kitty,rofi}

cp -r i3dots/i3wm/* ~/.config/i3/
cp -r i3dots/polybar/* ~/.config/polybar/
cp -r i3dots/picom/* ~/.config/picom/
cp -r i3dots/kitty/* ~/.config/kitty/
cp -r i3dots/rofi/* ~/.config/rofi/

# Права доступа
find ~/.config -name "*.sh" -exec chmod +x {} \;

echo "Готово! / Done!"
