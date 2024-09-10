#!/bin/bash

# COUNTER_FILE="$HOME/tcred/counter/storage.txt"

# count=$(cat $COUNTER_FILE)
# count=$((count + 1))
# echo $count > $COUNTER_FILE

FILE="$HOME/tcred/counter/storage"

# Отримання поточної дати
DATE=$(date +"%Y-%m-%d")

# Ініціалізація асоціативного масиву
typeset -A run_counts

# Функція для зчитування даних з файлу
read_data() {
    if [ -f "$FILE" ]; then
        while IFS="=" read -r key value; do
            run_counts["$key"]=$value
        done < "$FILE"
    else
        # Якщо файл не існує, створюємо його
        touch "$FILE"
    fi
}

# Функція для запису даних у файл
write_data() {
    > "$FILE"
    for key in ${(k)run_counts}; do
        echo "$key=${run_counts[$key]}" >> "$FILE"
    done
}

# Зчитуємо дані з файлу
read_data

# Збільшуємо кількість запусків для поточної дати
if [[ -n "${run_counts[$DATE]}" ]]; then
    run_counts[$DATE]=$((run_counts[$DATE] + 1))
else
    run_counts[$DATE]=1
fi

# Записуємо оновлені дані у файл
write_data