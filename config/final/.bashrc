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

# NOTE: You can use $(basename $SHELL) to return the name of the login SHELL
# __shell="$(basename $SHELL)"
__shell="bash"

# Check that oh-my-posh command exists
if command -v oh-my-posh &> /dev/null; then
  # Load oh-my-posh in current session to update prompt
  # You can add a config argument with the path to a theme
  # brew: --config "$(brew --prefix oh-my-posh)"/themes/jandedobbeleer.omp.json
  # scoop: --config ~/AppData/Local/Programs/oh-my-posh/themes/jandedobbeleer.omp.json
  # winget: --config ~/scoop/apps/oh-my-posh/current/themes/jandedobbeleer.omp.json
  eval "$(oh-my-posh --init --shell "$__shell")"
fi

# Check that fzf command exists
if command -v fzf &> /dev/null; then
  # Source keybindings file
  [ -f "$HOME/.fzf.$__shell" ] && source "$HOME/.fzf.$__shell"

  # Add fzf configuration to current session
  # NOTE: Update this path with the location of the fzf-config
  fzf_config="$HOME/fzf-config"
  [ -f "$fzf_config" ] && source "$fzf_config"

  # Add fzf functions to current session
  # NOTE: Update this path with the location of the fzf-functions
  fzf_functions="$HOME/fzf-functions"
  [ -f "$fzf_functions" ] && source "$fzf_functions"
fi
