#!/usr/bin/env bash

# This script is meant to be sourced
# from the root of the repository
# It will source all the functions to the current session

for FILE in examples/fzf/**/function-*; do
  # shellcheck source=/dev/null
  source "$FILE"
done
