#!/usr/bin/env bash

# Group common used fzf configurations
fzf-defaults () {
  fzf --height 50% --min-height 20 --border \
    --bind "ctrl-/:change-preview-window(down|hidden|),alt-up:preview-page-up,alt-down:preview-page-down,ctrl-s:toggle-sort" \
    --header 'Press CTRL-/ to toggle preview' \
    "$@"
}
