# VS Code Wal Theme Template

Шаблон для генерации темы VS Code и форков (Antigravity, Cursor, Code Insiders) на основе цветов Material You.

## Источник

Шаблон основан на [pywal16 colors-vscode.json](https://github.com/eylles/pywal16/blob/master/pywal/templates/colors-vscode.json) и адаптирован для matugen с использованием синтаксиса `{{colors.xxx.default.hex}}`.

## Поддерживаемые приложения

| Приложение | Путь | Статус |
|------------|------|--------|
| VS Code | `~/.config/Code/` | ✅ |
| VS Code Insiders | `~/.config/Code - Insiders/` | ✅ |
| Antigravity | `~/.config/Antigravity/` | ✅ |
| Cursor | `~/.config/Cursor/` | ✅ |

## Установка расширения

1. Установи расширение **Wal Theme** от `dlasagno` в каждом редакторе
2. Расширение автоматически читает тему из `globalStorage/dlasagno.wal-theme/themes/`

## Применение темы

Тема генерируется автоматически при смене обоев через скрипт `switchwall.sh`.

```bash
# Ручная генерация для всех редакторов
matugen image /путь/к/изображению.jpg

# Только кастомные шаблоны (VS Code форки)
matugen --config ~/.config/matugen/custom/config.toml image /путь/к/изображению.jpg
```

## Выбор темы в редакторе

1. `Ctrl+K Ctrl+T` (или `Cmd+K Cmd+T` на macOS)
2. Выбери **Wal Theme**

## Структура шаблона

| Файл | Описание |
|------|----------|
| `wal-theme-color-theme.json` | Основной шаблон темы |
| `README.md` | Документация |

### Цветовые токены

- `colors` — цвета интерфейса (workbench, editor, terminal, statusbar, etc.)
- `tokenColors` — синтаксическая подсветка (комментарии, ключевые слова, строки, etc.)

### Material You цвета

| Токен | Описание |
|-------|----------|
| `primary` | Основной акцентный цвет |
| `secondary` | Вторичный акцентный цвет |
| `tertiary` | Третичный акцентный цвет |
| `error` | Цвет ошибок |
| `surface.*` | Цвета поверхностей |
| `on_*` | Цвета текста на поверхностях |

## Конфигурация

Шаблоны настроены в:
- `~/.config/matugen/config.toml` — основной конфиг (VS Code)
- `~/.config/matugen/custom/config.toml` — кастомные шаблоны (Antigravity, Insiders, Cursor)
