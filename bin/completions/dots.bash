# bash completions для dots
_dots_completions() {
  local cur cmd
  cur="${COMP_WORDS[COMP_CWORD]}"
  cmd="${COMP_WORDS[1]}"

  local commands="apply deploy edit status up add remove init fresh help"

  if [ "$COMP_CWORD" -eq 1 ]; then
    mapfile -t COMPREPLY < <(compgen -W "$commands" -- "$cur")
  elif [ "$COMP_CWORD" -eq 2 ] && [ "$cmd" = "edit" ]; then
    local aliases
    aliases=$(yq '.aliases | keys | .[]' ~/dotsfiles/.dotsfiles.yaml 2>/dev/null)
    mapfile -t COMPREPLY < <(compgen -W "$aliases" -- "$cur")
  fi
}

complete -F _dots_completions dots
