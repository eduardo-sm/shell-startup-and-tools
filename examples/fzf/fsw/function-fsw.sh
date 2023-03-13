#!/usr/bin/env bash

# Show git log and see diffs in preview

fsw () {
  git log \
    --graph \
    --format='%C(auto)%h%d %s %C(white)%C(bold)%cr' \
    --color=always \
    "$@" |
  fzf \
    --ansi \
    --reverse \
    --tiebreak=index \
    --no-sort \
    --bind ctrl-s:toggle-sort,ctrl-/:toggle-preview,alt-up:preview-page-up,alt-down:preview-page-down \
    --preview 'f () { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1; }; f {}'
}
