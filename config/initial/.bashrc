# Config file example

# Aliases
# Use aliases for small commands or shorcuts
alias ll="ls -lAhF" # Use --color=auto for color output. In macos use -G instead or install core utils.
alias ..="cd .."
alias gs="git status"
alias nr="npm run"

# Functions
# Use functions for more complext logic

# Move up n directories. Will move up 1 if no arguments.
up () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for (( i=1; i<=limit; i++ )); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs."
  fi
}
