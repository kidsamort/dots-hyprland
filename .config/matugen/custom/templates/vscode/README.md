# VS Code Wal Theme Template

Шаблон для генерации темы VS Code и форков (Antigravity, Cursor, Code Insiders) на основе цветов Material You.

## Источник

Шаблон основан на [pywal16 colors-vscode.json](https://github.com/eylles/pywal16/blob/master/pywal/templates/colors-vscode.json) и адаптирован для работы с pywal cache.

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

## Как это работает

1. При смене обоев `switchwall.sh` генерирует цвета через matugen
2. Скрипт `generate-pywal-cache.sh` создаёт pywal-compatible cache в `~/.cache/wal/colors.json`
3. Скрипт `apply-wal-theme.sh` генерирует итоговую тему для каждого редактора

```
matugen → colors.json → generate-pywal-cache.sh → ~/.cache/wal/colors.json
                                              ↓
                              apply-wal-theme.sh → themes for VS Code forks
```

## Применение темы

Тема применяется автоматически при смене обоев. Для ручного применения:

```bash
# 1. Сгенерировать pywal cache
~/.config/matugen/custom/templates/vscode/generate-pywal-cache.sh

# 2. Применить тему ко всем редакторам
~/.config/matugen/custom/templates/vscode/apply-wal-theme.sh
```

## Выбор темы в редакторе

1. `Ctrl+K Ctrl+T` (или `Cmd+K Cmd+T` на macOS)
2. Выбери **Wal Theme**

## Структура шаблона

| Файл | Описание |
|------|----------|
| `wal-theme-color-theme.json` | Шаблон темы с плейсхолдерами |
| `generate-pywal-cache.sh` | Скрипт генерации pywal cache из matugen |
| `apply-wal-theme.sh` | Скрипт применения темы к редакторам |
| `README.md` | Документация |

### Цветовые токены

- `colors` — цвета интерфейса (workbench, editor, terminal, statusbar, etc.)
- `tokenColors` — синтаксическая подсветка (комментарии, ключевые слова, строки, etc.)

### ANSI цвета

| Цвет | Описание |
|------|----------|
| `color0` | Чёрный (background) |
| `color1` | Красный |
| `color2` | Зелёный |
| `color3` | Жёлтый |
| `color4` | Синий |
| `color5` | Маджента |
| `color6` | Циан |
| `color7` | Белый (foreground) |
| `color8-15` | Яркие версии |

## Конфигурация

Шаблоны настроены в:
- `~/.config/matugen/config.toml` — основной конфиг
- `~/.config/matugen/custom/config.toml` — кастомные шаблоны
