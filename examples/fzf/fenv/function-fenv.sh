#!/usr/bin/env bash

# Show environment variables
fenv () {
  local showValue=false

  if [ "$1" = '-v' ]; then
    showValue=true
  fi

  local tmpfile="$(mktemp)"
  # Cleanup file on exit
  trap "rm -- '$tmpfile'" EXIT

  while IFS='=' read -r -d '' n v; do
    printf "%s=%s\n" "$n" "${v//$'\n'}"
  done < <(env -0) > "$tmpfile"

  cat -v "$tmpfile" |
    fzf-defaults \
      --preview 'printf "%q" {}' --preview-window up:3:hidden:wrap \
      --bind 'ctrl-/:toggle-preview' \
      --bind 'ctrl-s:toggle-sort' \
      --bind 'ctrl-y:execute-silent(printf "%q" {} | pbcopy)+abort' \
      --color header:italic \
      --header 'Press CTRL-Y to copy command into clipboard' |
    cut -d '=' -f "$(if [ "$showValue" = true ]; then echo "2-"; else echo "1"; fi)" |
    sed -E 's/^[[:space:]]*//' | sed -E 's/[[:space:]]*$//'
}
