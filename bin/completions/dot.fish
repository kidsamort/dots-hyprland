# fish completions для dot
complete -c dot -f -a "apply deploy status help fresh" -d "Базовые команды"
complete -c dot -f -a "edit" -d "Открыть файл в редакторе"
complete -c dot -f -a "up" -d "Commit + push"
complete -c dot -f -a "add remove init" -d "Управление манифестом"

complete -c dot -f -n "__fish_seen_subcommand_from edit" \
  -a "(yq '.aliases | keys | .[]' ~/dotfiles/.dotfiles.yaml 2>/dev/null)"
