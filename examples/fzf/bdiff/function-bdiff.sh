#!/usr/bin/env bash

# Show list of current changed files
bdiff () {
  git diff --name-only --relative --diff-filter=d | xargs bat --diff
}
