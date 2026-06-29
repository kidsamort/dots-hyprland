# bash completions для dot
_dot_completions() {
  local cur cmd
  cur="${COMP_WORDS[COMP_CWORD]}"
  cmd="${COMP_WORDS[1]}"

  local commands="apply deploy edit status up add remove init fresh help"

  if [ "$COMP_CWORD" -eq 1 ]; then
    mapfile -t COMPREPLY < <(compgen -W "$commands" -- "$cur")
  elif [ "$COMP_CWORD" -eq 2 ] && [ "$cmd" = "edit" ]; then
    local aliases
    aliases=$(yq '.aliases | keys | .[]' ~/dotfiles/.dotfiles.yaml 2>/dev/null)
    mapfile -t COMPREPLY < <(compgen -W "$aliases" -- "$cur")
  fi
}

complete -F _dot_completions dot
