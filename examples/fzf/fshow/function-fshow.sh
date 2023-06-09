#!/usr/bin/env bash

# Show git log and allow see diffs of commits
fshow () {
  local out shas sha q k
  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-d --bind=ctrl-s:toggle-sort); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    # If you have delta, you can do
    # git diff --color=always $shas | delta
    # https://github.com/dandavison/delta
    if [ "$k" = ctrl-d ]; then
      git diff --color=always $shas | less -R
    else
       for sha in $shas; do
        git show --color=always $sha | less -R
      done
    fi
  done
}