#!/usr/bin/env bash

# Move to home
pushd ~

# Ensure .zsh dir exists
mkdir -p .zsh

# Clone repository
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting

# Return to previos location
popd
