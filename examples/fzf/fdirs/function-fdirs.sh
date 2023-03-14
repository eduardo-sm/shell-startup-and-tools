#!/usr/bin/env bash

# Change directory to a selection in the directory stack
# Requires to add directories first with pushd
fdirs () {
  local selection="$(dirs -v |
    fzf-defaults \
      --preview '
        echo "Path: {2..}"
        echo ""
        ls -AFL --color=always $(bash -c "echo "{2..})' |
    awk '{print $1}')"

  if [ -n "$selection" ]; then
    pushd "+$selection"
  fi
}