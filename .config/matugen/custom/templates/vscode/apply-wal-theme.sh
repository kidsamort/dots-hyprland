#!/usr/bin/env bash
# Генерирует итоговую тему для Wal Theme расширения из pywal cache
# Копирует шаблон и заменяет плейсхолдеры на реальные цвета

XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

WAL_CACHE="$XDG_CACHE_HOME/wal/colors.json"
TEMPLATE="$XDG_CONFIG_HOME/matugen/custom/templates/vscode/wal-theme-color-theme.json"

# Пути для разных редакторов
ANTIGRAVITY_THEME="$XDG_CONFIG_HOME/Antigravity/User/globalStorage/dlasagno.wal-theme/themes/wal-theme-color-theme.json"
VSCODE_THEME="$XDG_CONFIG_HOME/Code/User/globalStorage/dlasagno.wal-theme/themes/wal-theme-color-theme.json"
VSCODE_INSIDERS_THEME="$XDG_CONFIG_HOME/Code - Insiders/User/globalStorage/dlasagno.wal-theme/themes/wal-theme-color-theme.json"
CURSOR_THEME="$XDG_CONFIG_HOME/Cursor/User/globalStorage/dlasagno.wal-theme/themes/wal-theme-color-theme.json"

if [ ! -f "$WAL_CACHE" ]; then
    echo "Error: Pywal cache not found at $WAL_CACHE"
    echo "Run switchwall.sh or generate-pywal-cache.sh first"
    exit 1
fi

if [ ! -f "$TEMPLATE" ]; then
    echo "Error: Template not found at $TEMPLATE"
    exit 1
fi

# Читаем цвета из pywal cache
background=$(jq -r '.special.background' "$WAL_CACHE")
foreground=$(jq -r '.special.foreground' "$WAL_CACHE")
color0=$(jq -r '.colors.color0' "$WAL_CACHE")
color1=$(jq -r '.colors.color1' "$WAL_CACHE")
color2=$(jq -r '.colors.color2' "$WAL_CACHE")
color3=$(jq -r '.colors.color3' "$WAL_CACHE")
color4=$(jq -r '.colors.color4' "$WAL_CACHE")
color5=$(jq -r '.colors.color5' "$WAL_CACHE")
color6=$(jq -r '.colors.color6' "$WAL_CACHE")
color7=$(jq -r '.colors.color7' "$WAL_CACHE")
color8=$(jq -r '.colors.color8' "$WAL_CACHE")
color9=$(jq -r '.colors.color9' "$WAL_CACHE")
color10=$(jq -r '.colors.color10' "$WAL_CACHE")
color11=$(jq -r '.colors.color11' "$WAL_CACHE")
color12=$(jq -r '.colors.color12' "$WAL_CACHE")
color13=$(jq -r '.colors.color13' "$WAL_CACHE")
color14=$(jq -r '.colors.color14' "$WAL_CACHE")
color15=$(jq -r '.colors.color15' "$WAL_CACHE")

# Функция для генерации темы
generate_theme() {
    local output_path="$1"
    
    # Создаём директорию если не существует
    mkdir -p "$(dirname "$output_path")"
    
    # Заменяем плейсхолдеры на реальные цвета
    sed -e "s/{background}/$background/g" \
        -e "s/{foreground}/$foreground/g" \
        -e "s/{color0}/$color0/g" \
        -e "s/{color1}/$color1/g" \
        -e "s/{color2}/$color2/g" \
        -e "s/{color3}/$color3/g" \
        -e "s/{color4}/$color4/g" \
        -e "s/{color5}/$color5/g" \
        -e "s/{color6}/$color6/g" \
        -e "s/{color7}/$color7/g" \
        -e "s/{color8}/$color8/g" \
        -e "s/{color9}/$color9/g" \
        -e "s/{color10}/$color10/g" \
        -e "s/{color11}/$color11/g" \
        -e "s/{color12}/$color12/g" \
        -e "s/{color13}/$color13/g" \
        -e "s/{color14}/$color14/g" \
        -e "s/{color15}/$color15/g" \
        "$TEMPLATE" > "$output_path"
    
    echo "Generated theme at $output_path"
}

# Генерируем темы для всех редакторов
generate_theme "$ANTIGRAVITY_THEME"
generate_theme "$VSCODE_THEME"
generate_theme "$VSCODE_INSIDERS_THEME"
generate_theme "$CURSOR_THEME"

echo "All themes generated successfully!"
