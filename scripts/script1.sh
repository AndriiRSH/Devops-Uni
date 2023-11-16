#!/bin/bash

# Функція для виведення повідомлення про помилку та вихід з програми
error_exit() {
    echo "Помилка: $1"
    exit 1
}

# Перевірка кількості аргументів
if [ "$#" -ne 2 ]; then
    error_exit "Використання: $0 <шлях до директорії> <розширення файлів>"
fi

directory="$1"
extension="$2"

# Перевірка наявності директорії
[ -d "$directory" ] || error_exit "Директорія '$directory' не існує."

# Перевірка доступу до директорії
[ -x "$directory" ] || error_exit "Немає доступу до директорії '$directory'."

# Пошук та виведення файлів
find "$directory" -type f -name "*.$extension"
