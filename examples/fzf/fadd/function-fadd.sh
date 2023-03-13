#!/usr/bin/env bash

# Add files to stage area
fadd () {
  # Check git repository
  git rev-parse HEAD > /dev/null 2>&1 || return

  local INITIAL_QUERY="${*:-}"
  local selection=($(git -c color.status=always status --short |
    fzf \
      --min-height 20 --border \
      -m --ansi --nth 2..,.. \
      --bind "ctrl-/:change-preview-window(down|hidden|),alt-up:preview-page-up,alt-down:preview-page-down,ctrl-s:toggle-sort" \
      --query "$INITIAL_QUERY" \
      --preview 'if [ -f {-1} ]; then
        git diff --color=always -- {-1} |
        sed 1,4d |
        bat -p --color=always
        bat --color=always {-1};
      else
        ls -aF --color=always {-1} 2>/dev/null || echo "Cannot display file"
      fi' |
    cut -c4- | sed 's/.* -> //'))

  if [ -n "$selection" ]; then
    git add "${selection[@]}"
  fi
}
