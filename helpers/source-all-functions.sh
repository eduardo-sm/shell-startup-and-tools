#!/usr/bin/env bash

for FILE in examples/fzf/**/function-*; do
  # shellcheck source=/dev/null # to ignore the  errorbash-language-server
  source "$FILE"
done
