# 💻 Мои Dotfiles (CachyOS + end-4)

Персонализированные конфиги для CachyOS с end-4 dots, версионированием через Git и защитой секретов.

---

## 📋 Оглавление

1. [Быстрый старт](#-быстрый-старт)
2. [Структура репозитория](#-структура-репозитория)
3. [Ежедневное использование](#-ежедневное-использование)
4. [Защита секретов](#-защита-секретов)
5. [Обновление от upstream](#-обновление-от-upstream)
6. [Восстановление системы](#-восстановление-системы)
7. [Полезные команды](#-полезные-команды)

---

## 🚀 Быстрый старт

### При новой установке CachyOS:

```bash
# 1. Клонируй репозиторий
git clone git@github.com:kidsamort/dots-hyprland.git ~/dotfiles
cd ~/dotfiles

# 2. Примени конфиги через Stow
stow .

# 3. Восстанови секреты (с бэкапа или введи заново)
nano ~/.bashrc_secrets

# 4. Перезагрузись
reboot
```

---

## 📁 Структура репозитория

```
~/dotfiles/
├── .config/           # Конфиги программ
│   ├── fish/          # Fish shell конфиги
│   ├── hypr/          # Hyprland конфиги
│   └── ...
├── .gitignore         # Игнорируемые файлы (секреты, кэш)
├── README.md          # Эта документация
└── setup              # Скрипт установки end-4
```

### Что где хранится:

| Папка/Файл | Описание |
|------------|----------|
| `.config/fish/` | Конфиги Fish shell (алиасы, темы) |
| `.config/hypr/` | Конфиги Hyprland (оконный менеджер) |
| `.config/matugen/` | Конфиги matugen (генерация тем) |
| `.gitignore` | Список игнорируемых файлов |
| `~/.bashrc_secrets` | **НЕ В GIT!** Секреты и API ключи |

---

## 🎨 Генерация тем (Matugen)

### VS Code и форки (Antigravity, Cursor)

Тема для VS Code и форков генерируется автоматически при смене обоев через `switchwall.sh`.

**Требуемое расширение:** [Wal Theme](https://marketplace.visualstudio.com/items?itemName=dlasagno.wal-theme) от `dlasagno`

**Поддерживаемые редакторы:**

| Редактор | Путь |
|----------|------|
| VS Code | `~/.config/Code/` |
| VS Code Insiders | `~/.config/Code - Insiders/` |
| Antigravity | `~/.config/Antigravity/` |
| Cursor | `~/.config/Cursor/` |

**Настройка:**

1. Установи расширение **Wal Theme** в каждом редакторе
2. Тема применяется автоматически при смене обоев
3. Для ручного применения: `matugen --config ~/.config/matugen/custom/config.toml image <путь_к_изображению>`

**Выбор темы в редакторе:**
- `Ctrl+K Ctrl+T` → выбери **Wal Theme**

**Шаблон:** `~/.config/matugen/custom/templates/vscode/wal-theme-color-theme.json`

Шаблон основан на [pywal16 colors-vscode.json](https://github.com/eylles/pywal16) и адаптирован для matugen с использованием Material You цветов.

---

## 📝 Ежедневное использование

### Редактирование конфигов

**Важно:** Редактируй файлы **только в `~/dotfiles/`**, никогда в `~/.config/`!

```bash
# Открыть конфиг Fish
nano ~/dotfiles/.config/fish/config.fish

# Открыть конфиг Hyprland
nano ~/dotfiles/.config/hypr/hyprland.conf
```

### Сохранение изменений в Git

```bash
cd ~/dotfiles

# Посмотри изменения
git status

# Добавь файлы
git add .

# Закоммить с сообщением
git commit -m "Описание изменений"

# Отправь в GitHub
git push
```

### Применение изменений

После редактирования конфигов:

```bash
cd ~/dotfiles
stow .
```

Или перезагрузи Hyprland: `SUPER + SHIFT + R`

---

## 🔐 Защита секретов

### Файл секретов

Секреты хранятся в `~/.bashrc_secrets` (не в Git!):

```bash
# API ключи
export GITHUB_TOKEN="ghp_xxxxx"
export QWEN_API_KEY="sk-xxxxx"

# Алиасы
alias update='sudo pacman -Syu'
alias pushdots='cd ~/dotfiles && git add . && git commit -m "update" && git push'
```

**Защита файла:**
```bash
chmod 600 ~/.bashrc_secrets
```

### KeePassXC

Приватные SSH ключи и пароли хранятся в KeePassXC:

- Путь к базе: `~/Documents/Security/passwords.kdbx`
- Синхронизация: Syncthing с iPhone

**Добавить SSH ключ в KeePassXC:**
1. Открой базу в KeePassXC
2. Создай новую запись: `GitHub SSH Key`
3. В поле Password вставь приватный ключ (всё содержимое `~/.ssh/id_ed25519`)

---

## 🔄 Обновление от upstream

Когда end-4 выпускает обновления:

```bash
cd ~/dotfiles

# 1. Забери изменения из оригинала
git fetch upstream

# 2. Посмотри что изменилось
git log HEAD..upstream/main --oneline

# 3. Слей изменения
git merge upstream/main

# 4. Если есть конфликты — реши их в редакторе

# 5. Примени изменения через Stow
stow .

# 6. Закоммить слияние
git commit -m "Merge upstream updates"

# 7. Отправь в свой репо
git push origin main
```

**После обновления перезагрузись:**
```bash
reboot
# или SUPER + SHIFT + R в Hyprland
```

---

## 💾 Восстановление системы

### При полной переустановке системы:

```bash
# 1. Клонируй репозиторий
git clone git@github.com:kidsamort/dots-hyprland.git ~/dotfiles
cd ~/dotfiles

# 2. Примени конфиги
stow .

# 3. Восстанови секреты
#    - Скопируй ~/.bashrc_secrets с бэкапа
#    - Восстанови базу KeePassXC из Syncthing
#    - Введи API ключи заново

# 4. Перезагрузись
reboot
```

### Откат изменений

**Откатить Stow:**
```bash
cd ~/dotfiles
stow -D .  # Удалить ссылки
stow .     # Создать заново
```

**Откатить Git:**
```bash
cd ~/dotfiles
git reset --hard HEAD~1  # Откат на 1 коммит назад
```

---

## ⌨️ Полезные команды

### Git операции

| Команда | Описание |
|---------|----------|
| `git status` | Показать изменения |
| `git add .` | Добавить все файлы |
| `git commit -m "msg"` | Закоммить с сообщением |
| `git push` | Отправить в GitHub |
| `git pull` | Получить из GitHub |
| `git fetch upstream` | Получить из оригинала end-4 |
| `git merge upstream/main` | Слить изменения upstream |
| `git log --oneline` | История коммитов |

### Stow операции

| Команда | Описание |
|---------|----------|
| `stow .` | Применить конфиги |
| `stow -D .` | Удалить ссылки |
| `stow -t ~ .` | Применить в домашнюю папку |

### Алиасы (после настройки секретов)

| Алиас | Команда |
|-------|---------|
| `update` | `sudo pacman -Syu` |
| `pushdots` | Быстрый пуш конфигов |

---

## ⚠️ Важные правила

1. **Редактируй ТОЛЬКО в `~/dotfiles/`**, никогда в `~/.config/`
2. **Не коммить секреты** — проверяй `git status` перед `git add`
3. **Делай бэкап `~/.bashrc_secrets`** отдельно от Git
4. **Перед обновлением upstream** — сделай коммит текущих изменений
5. **Проверяй `.gitignore`** — убедись что секреты игнорируются

---

## 🆘 Если что-то сломалось

```bash
# Проверить статус Git
cd ~/dotfiles && git status

# Отменить локальные изменения
git reset --hard HEAD

# Пересоздать ссылки Stow
stow -D . && stow .

# Проверить конфиги Hyprland
hyprctl reload

# Посмотреть логи
journalctl -b --no-pager
```

---

## 📊 Ссылки

- **Репозиторий:** https://github.com/kidsamort/dots-hyprland
- **Upstream:** https://github.com/end-4/dots-hyprland
- **Документация end-4:** https://ii.clsty.link

---

**Последнее обновление:** 2026-03-25
