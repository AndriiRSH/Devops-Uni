#!/bin/bash

# Функція для виведення повідомлення про помилку та вихід з програми
error_exit() {
    echo "Помилка: $1"
    exit 1
}

# Перевірка кількості аргументів
if [ "$#" -ne 4 ]; then
    error_exit "Використання: $0 -p <шлях до директорії> -s <текст для пошуку>"
fi

while getopts ":p:s:" opt; do
  case $opt in
    p)
      directory="$OPTARG"
      ;;
    s)
      search_text="$OPTARG"
      ;;
    \?)
      error_exit "Невідомий ключ: -$OPTARG"
      ;;
    :)
      error_exit "Параметр для ключа -$OPTARG відсутній."
      ;;
  esac
done

# Перевірка наявності директорії
[ -d "$directory" ] || error_exit "Директорія '$directory' не існує."

# Перевірка доступу до директорії
[ -x "$directory" ] || error_exit "Немає доступу до директорії '$directory'."

# Пошук та виведення файлів
grep -rl "$search_text" "$directory"
