#!/usr/bin/env bash

# Move to home
pushd ~

# Ensure .zsh dir exists
mkdir -p ~/.zsh

# Clone repository
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# Return to previos location
popd
