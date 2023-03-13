#!/usr/bin/env bash

# Find text in files with preview
fif () {
  if [ ! "$#" -gt 0 ]; then
    echo 'Need a string to search for!'
    return 1;
  fi

  rg --files-with-matches --no-messages "$1" |
    fzf \
      --bind "ctrl-/:change-preview-window(down|hidden|),alt-up:preview-page-up,alt-down:preview-page-down" \
      --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}
