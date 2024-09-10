#!/bin/zsh

FILE="$HOME/tcred/counter/storage"

# Отримання поточної дати
DATE=$(date +"%Y-%m-%d")

# Ініціалізація змінної для зберігання даних
run_counts=""

# Функція для зчитування даних з файлу
read_data() {
    if [ -f "$FILE" ]; then
        run_counts=$(cat "$FILE")
    else
        # Якщо файл не існує, створюємо його
        touch "$FILE"
    fi
}

# Функція для запису даних у файл
write_data() {
    echo "$run_counts" > "$FILE"
}

# Зчитуємо дані з файлу
read_data

# Збільшуємо кількість запусків для поточної дати
if echo "$run_counts" | grep -q "$DATE"; then
    run_counts=$(echo "$run_counts" | sed -E "s/($DATE=)([0-9]+)/echo \1$((\2 + 1))/e")
else
    run_counts="$run_counts\n$DATE=1"
fi

# Записуємо оновлені дані у файл
write_data