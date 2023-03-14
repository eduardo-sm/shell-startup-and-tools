#!/usr/bin/env bash

# Helper to get aliases and functions in the current shell
getShellAliasAndFunctions () {
  if [[ -n "$BASH" ]]; then
    {
      # BASH
      # Functions
      typeset -F | awk '{ if ( $3 !~ /_.+/) { print $3 } }';
      # Aliases
      alias | awk '{ split($2,o,"="); print o[1] }'
    }
  else
    {
      # ZSH
      # Functions
      print -l ${(ok)functions} |
        awk '{ if ($1 !~ /^_.+/) { print $1 } }';
      # Aliases
      # alias | cut -d '=' -f 1
      compgen -a
    }
  fi
}

# Show aliases and functions in current session
fcmd () {
  local available_commands="$(getShellAliasAndFunctions | sort)"
  local tmpfile="$(mktemp)"

  # Cleanup file on exit
  trap "rm -- '$tmpfile'" EXIT

  # Get the output of type and store it in tmpfile
  for cm in $(echo ${available_commands}); do
    echo ""
    type -f "$cm" 2>/dev/null || type "$cm" 2>/dev/null
  done > "$tmpfile"

  echo "$available_commands" |
    fzf-defaults \
      --preview "rg -A 50 -B 1 -m 1 '^{} ' $tmpfile | bat -l bash --color=always -p -H 2" \
      --preview-window right:70% \
      --bind 'ctrl-y:execute-silent(echo -n {} | pbcopy)+abort' || return 0
}
