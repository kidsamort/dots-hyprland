# `dots` — управление dotfiles

`dots` — обёртка над stow, install-files и git. Одна команда вместо цепочки `rm → stow → hyprctl reload`.

## Установка

```bash
# Добавить в PATH (один раз)
ln -s ~/dotfiles/bin/dot ~/.local/bin/dot

# Автодополнение для fish
echo "source ~/dotfiles/bin/completions/dot.fish" >> ~/.config/fish/config.fish
```

## Концепция

`.dotfiles.yaml` в корне репозитория — манифест. Ты регистрируешь в нём файлы, которыми управляет stow:

```yaml
managed:
  - .config/hypr/custom/general.lua
  - .config/fish/conf.d/local.fish
  - .config/matugen/config/toml
  # ...
```

Когда запускаешь `dots apply`:
1. Читает манифест
2. Удаляет обычные файлы (не симлинки) на месте managed-путей
3. Запускает `stow --no-folding`
4. Делает `hyprctl reload`

Итог — всегда чистые симлинки, никаких конфликтов с `install-files`.

## Команды

### `dots apply`

Удалить конфликтные файлы → stow → hyprctl reload.

```bash
dots apply
```

Самая частая команда. Запускается после редактирования любого файла в `~/dotfiles/`.

### `dots setup`

Установить dots в систему.

```bash
dots setup
```

Что делает:
1. Симлинк `~/dotfiles/bin/dots` → `~/.local/bin/dots`
2. Добавляет `~/.local/bin` в PATH для fish (если нет)
3. Копирует автодополнение в `~/.config/fish/completions/`
4. Запускает `dots apply`

После этого `dots` доступна из любого места.

### `dots deploy`

Полное обновление после мержа upstream.

```bash
dots deploy
```

Что делает:
1. `./setup install-files --skip-miscconf`
2. Чистит мусор: `*.backup`, `*.new`, заглушку `hyprland.conf`
3. `dots apply`

### `dots edit <алиас>`

Открыть файл в `$EDITOR` (по умолчанию `nano`).

```bash
dots edit keybinds   # откроет .config/hypr/custom/keybinds.lua
dots edit general    # .config/hypr/custom/general.lua
dots edit fish       # .config/fish/conf.d/local.fish
```

Список алиасов — в `.dotfiles.yaml` → `aliases:`.

Без аргумента покажет список и спросит.

### `dots status`

Показать состояние конфигов.

```bash
dots status
```

Вывод:
- `✓ .config/hypr/custom/general.lua` — симлинк в порядке
- `✗ .config/...` — обычный файл (нужен `dots apply`)
- `⚠ .config/...` — отсутствует
- Git статус (staged/unstaged)
- Отставание/опережение относительно origin

### `dots up "<сообщение>"`

Закоммитить и запушить.

```bash
dots up              # спросит сообщение
dots up "fix: typo"  # сразу с сообщением
```

Что делает: `git add -A` → `git commit -m "..."` → `git push`.

### `dots add <путь>`

Добавить файл в managed.

```bash
dots add .config/hypr/custom/rules.lua
```

Файл должен существовать в `~/dotfiles/`.

### `dots remove <путь>`

Убрать файл из managed.

```bash
dots remove .config/hypr/custom/rules.lua
```

### `dots init`

Просканировать `~/.config/`, найти твои файлы (которых нет в `dots/`), предложить добавить в managed.

```bash
dots init
```

### `dots fresh`

Вывести инструкцию для чистой установки системы.

```bash
dots fresh
```

### `dots help`
| `dots setup` | Установить dots в систему (PATH, автодополнение, apply) |

Справка.

```bash
dots help
```

## Примеры

```bash
# Быстро отредактировать и применить
dots edit kb
dots apply

# После мержа upstream
git fetch upstream
git merge upstream/main
dots deploy

# Закоммитить и запушить
dots up "feat: добавил кастомный rules.lua"
```

## Как добавить новый файл

```bash
# 1. Создал
touch ~/dotfiles/.config/hypr/custom/rules.lua

# 2. Зарегистрировал
dots add .config/hypr/custom/rules.lua

# 3. Применил
dots apply
# или алиас для быстрого открытия
dots edit rules
```

## Файлы

| Путь | Назначение |
|------|-----------|
| `~/dotfiles/bin/dot` | Скрипт |
| `~/dotfiles/.dotfiles.yaml` | Манифест |
| `~/dotfiles/bin/completions/dot.fish` | Автодополнение для fish |
| `~/dotfiles/bin/completions/dot.bash` | Автодополнение для bash |
