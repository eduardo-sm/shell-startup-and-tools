#!/usr/bin/env bash

# Checkout to a different branch

fco () {
  git rev-parse HEAD > /dev/null 2>&1 || return

  local INITIAL_QUERY="${*:-}"
  local selection=$(git -c color.status=always status --short |
    fzf-down -m --ansi --nth 2..,.. \
      --query "$INITIAL_QUERY" \
      --preview 'if [ -f {-1} ]; then git diff --color=always -- {-1} |
    sed 1,4d |
    bat -p --color=always; bat --color=always {-1}; else ls -aF --color=always {-1}; fi' |
    cut -c4- | sed 's/.* -> //')

  if [ -n "$selection" ]; then
    git checkout "${selection//origin\//}"
  fi
}
