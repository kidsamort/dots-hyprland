# fish completions для dots
complete -c dots -f -a "apply deploy status help fresh" -d "Базовые команды"
complete -c dots -f -a "edit" -d "Открыть файл в редакторе"
complete -c dots -f -a "up" -d "Commit + push"
complete -c dots -f -a "add remove init" -d "Управление манифестом"

complete -c dots -f -n "__fish_seen_subcommand_from edit" \
  -a "(yq '.aliases | keys | .[]' ~/dotsfiles/.dotsfiles.yaml 2>/dev/null)"
