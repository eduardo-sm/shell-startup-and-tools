#!/usr/bin/env bash

# Requires ripgrep and fzf
# Find a file using ripgrep, change to fzf for narrow results, open selection in vim

rfv () {
  # Use env variable to setup an editor or default to nvim
  local editor="${EDITOR:-vim}"
  # Switch between Ripgrep launcher mode (CTRL-R) and fzf filtering mode (CTRL-F)
  local RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case --no-ignore -g "'!node_modules'" -g "'!.git'" --hidden "
  local INITIAL_QUERY="${*:-}"
  IFS=: read -ra selected < <(
    FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")" \
    fzf --ansi \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --disabled --query "$INITIAL_QUERY" \
      --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
      --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+clear-query+rebind(ctrl-r)" \
      --bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)" \
      --prompt '1. Ripgrep> ' \
      --delimiter : \
      --header '╱ CTRL-R (Ripgrep mode) ╱ CTRL-F (fzf mode) ╱' \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
  )
  [ -n "${selected[0]}" ] && "$editor" "${selected[0]}" "+${selected[1]}"
}
