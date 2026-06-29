# `dot` — управление dotfiles

`dot` — обёртка над stow, install-files и git. Одна команда вместо цепочки `rm → stow → hyprctl reload`.

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

Когда запускаешь `dot apply`:
1. Читает манифест
2. Удаляет обычные файлы (не симлинки) на месте managed-путей
3. Запускает `stow --no-folding`
4. Делает `hyprctl reload`

Итог — всегда чистые симлинки, никаких конфликтов с `install-files`.

## Команды

### `dot apply`

Удалить конфликтные файлы → stow → hyprctl reload.

```bash
dot apply
```

Самая частая команда. Запускается после редактирования любого файла в `~/dotfiles/`.

### `dot deploy`

Полное обновление после мержа upstream.

```bash
dot deploy
```

Что делает:
1. `./setup install-files --skip-miscconf`
2. Чистит мусор: `*.backup`, `*.new`, заглушку `hyprland.conf`
3. `dot apply`

### `dot edit <алиас>`

Открыть файл в `$EDITOR` (по умолчанию `nano`).

```bash
dot edit keybinds   # откроет .config/hypr/custom/keybinds.lua
dot edit general    # .config/hypr/custom/general.lua
dot edit fish       # .config/fish/conf.d/local.fish
```

Список алиасов — в `.dotfiles.yaml` → `aliases:`.

Без аргумента покажет список и спросит.

### `dot status`

Показать состояние конфигов.

```bash
dot status
```

Вывод:
- `✓ .config/hypr/custom/general.lua` — симлинк в порядке
- `✗ .config/...` — обычный файл (нужен `dot apply`)
- `⚠ .config/...` — отсутствует
- Git статус (staged/unstaged)
- Отставание/опережение относительно origin

### `dot up "<сообщение>"`

Закоммитить и запушить.

```bash
dot up              # спросит сообщение
dot up "fix: typo"  # сразу с сообщением
```

Что делает: `git add -A` → `git commit -m "..."` → `git push`.

### `dot add <путь>`

Добавить файл в managed.

```bash
dot add .config/hypr/custom/rules.lua
```

Файл должен существовать в `~/dotfiles/`.

### `dot remove <путь>`

Убрать файл из managed.

```bash
dot remove .config/hypr/custom/rules.lua
```

### `dot init`

Просканировать `~/.config/`, найти твои файлы (которых нет в `dots/`), предложить добавить в managed.

```bash
dot init
```

### `dot fresh`

Вывести инструкцию для чистой установки системы.

```bash
dot fresh
```

### `dot help`

Справка.

```bash
dot help
```

## Примеры

```bash
# Быстро отредактировать и применить
dot edit kb
dot apply

# После мержа upstream
git fetch upstream
git merge upstream/main
dot deploy

# Закоммитить и запушить
dot up "feat: добавил кастомный rules.lua"
```

## Как добавить новый файл

```bash
# 1. Создал
touch ~/dotfiles/.config/hypr/custom/rules.lua

# 2. Зарегистрировал
dot add .config/hypr/custom/rules.lua

# 3. Применил
dot apply
# или алиас для быстрого открытия
dot edit rules
```

## Файлы

| Путь | Назначение |
|------|-----------|
| `~/dotfiles/bin/dot` | Скрипт |
| `~/dotfiles/.dotfiles.yaml` | Манифест |
| `~/dotfiles/bin/completions/dot.fish` | Автодополнение для fish |
| `~/dotfiles/bin/completions/dot.bash` | Автодополнение для bash |
