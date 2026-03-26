#!/usr/bin/env bash
# Генерирует pywal-compatible colors.json из matugen цветов
# Нужно для совместимости с расширением Wal Theme в VS Code/Antigravity

XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

WAL_CACHE_DIR="$XDG_CACHE_HOME/wal"
MATUGEN_COLORS="$XDG_STATE_HOME/quickshell/user/generated/colors.json"

# Создаём директорию pywal cache
mkdir -p "$WAL_CACHE_DIR"

# Читаем Material You цвета из matugen
if [ ! -f "$MATUGEN_COLORS" ]; then
    echo "Error: Matugen colors not found at $MATUGEN_COLORS"
    exit 1
fi

# Извлекаем цвета из JSON (Material You -> ANSI 16 colors)
# Формат: плоский JSON с ключами background, primary, secondary и т.д.
background=$(jq -r '.background' "$MATUGEN_COLORS")
foreground=$(jq -r '.on_surface' "$MATUGEN_COLORS")
primary=$(jq -r '.primary' "$MATUGEN_COLORS")
on_primary=$(jq -r '.on_primary' "$MATUGEN_COLORS")
primary_container=$(jq -r '.primary_container' "$MATUGEN_COLORS")
secondary=$(jq -r '.secondary' "$MATUGEN_COLORS")
on_secondary=$(jq -r '.on_secondary' "$MATUGEN_COLORS")
secondary_container=$(jq -r '.secondary_container' "$MATUGEN_COLORS")
tertiary=$(jq -r '.tertiary' "$MATUGEN_COLORS")
on_tertiary=$(jq -r '.on_tertiary' "$MATUGEN_COLORS")
tertiary_container=$(jq -r '.tertiary_container' "$MATUGEN_COLORS")
error=$(jq -r '.error' "$MATUGEN_COLORS")
outline=$(jq -r '.outline' "$MATUGEN_COLORS")
surface_container_lowest="#000000"  # fallback

# Формируем 16 ANSI цветов для pywal
# color0-7: normal, color8-15: bright
color0="$background"               # black (background)
color1="$error"                    # red
color2="$primary"                  # green
color3="$tertiary"                 # yellow
color4="$secondary"                # blue
color5="$secondary_container"      # magenta
color6="$tertiary_container"       # cyan
color7="$foreground"               # white

color8="$outline"                  # bright black
color9="$error"                    # bright red
color10="$primary_container"       # bright green
color11="$tertiary_container"      # bright yellow
color12="$secondary"               # bright blue
color13="$secondary_container"     # bright magenta
color14="$tertiary_container"      # bright cyan
color15="$foreground"              # bright white

# Получаем путь к обоям
wallpaper_path=""
if [ -f "$XDG_STATE_HOME/quickshell/user/generated/wallpaper/path.txt" ]; then
    wallpaper_path=$(cat "$XDG_STATE_HOME/quickshell/user/generated/wallpaper/path.txt" 2>/dev/null)
fi

# Если wallpaper_path пустой, пробуем найти в config.json
if [ -z "$wallpaper_path" ] || [ "$wallpaper_path" = "null" ]; then
    if [ -f "$XDG_CONFIG_HOME/quickshell/ii/config.json" ]; then
        wallpaper_path=$(jq -r '.background.wallpaperPath // empty' "$XDG_CONFIG_HOME/quickshell/ii/config.json" 2>/dev/null)
    fi
fi

# Генерируем colors.json в формате pywal
cat > "$WAL_CACHE_DIR/colors.json" << EOF
{
  "wallpaper": "$wallpaper_path",
  "alpha": "100",
  "special": {
    "background": "$color0",
    "foreground": "$color7",
    "cursor": "$color7"
  },
  "colors": {
    "color0": "$color0",
    "color1": "$color1",
    "color2": "$color2",
    "color3": "$color3",
    "color4": "$color4",
    "color5": "$color5",
    "color6": "$color6",
    "color7": "$color7",
    "color8": "$color8",
    "color9": "$color9",
    "color10": "$color10",
    "color11": "$color11",
    "color12": "$color12",
    "color13": "$color13",
    "color14": "$color14",
    "color15": "$color15"
  }
}
EOF

echo "Generated pywal colors.json at $WAL_CACHE_DIR/colors.json"

# Также генерируем обычный colors файл (для совместимости)
cat > "$WAL_CACHE_DIR/colors" << EOF
$color0
$color1
$color2
$color3
$color4
$color5
$color6
$color7
$color8
$color9
$color10
$color11
$color12
$color13
$color14
$color15
EOF

echo "Generated pywal colors at $WAL_CACHE_DIR/colors"
