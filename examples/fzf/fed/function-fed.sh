#!/usr/bin/env bash

# Select a file and open it in your default editor
fed () {
  local location="${1:-$HOME}"
  local query="${@:3}"
  local pattern="."
  local editor="${EDITOR:-vim}"
  if ! [ -d "$location" ]; then
    pattern="$location"
    location="$HOME"
  fi
  local selection=($(fd --hidden \
      --exclude '.git' --exclude 'node_modules' \
      -L -tf "$pattern" "$location" |
    fzf --height 50% --min-height 20 --border \
      --bind "ctrl-/:toggle-preview,alt-up:preview-page-up,alt-down:preview-page-down" \
      --multi \
      --preview "bat --color=always --style=numbers {}" \
      --header "(ctrl-/) Search in: $location" \
      --query "$query"))
  if [ -z "$selection" ]; then
    return
  fi
  if [ -n "$2" ] && [ "$2" != "-" ]; then
    editor="$2"
  fi
  $editor "${selection[@]}"
}
