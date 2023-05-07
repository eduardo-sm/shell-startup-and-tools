Shell startup and tools
===========

This repository contains examples to configure both `bash` and `zsh` shells
and a collection of sample scripts for the tools bat, fd, ripgrep and fzf.

# Setup

Clone this repository:

```bash
git clone https://bitbucket.org/accedo/shell-startup-and-tools.git
```

# Shell

There are sample configuration files under the config directory.

- config/.bashrc
- config/.zshrc

To use them, you can copy them to your home directory

```bash
cp config/.bashrc ~

# or

cp config/.zshrc ~
```

or if you already have a configuration file, you can source the file for your shell.

```bash
# In .bashrc
source path/to/repo/config/.bashrc
```

**NOTICE**: You need to update paths for the following variables.

- fzf_config: Path to fzf-config file.
  - Add custom fzf configuration for keybindings and autocompletion.
- fzf_functions: Path to fzf-functions file.
  - Add utility functions that use fzf.
- rfv_script: Path to rfv script.
  - Add rfv function to session (Or you can add the script to your path like ~/.local/bin).

```bash
# Update the following variables at the top of the file

# Config fzf defaults and keybindings
fzf_config="config/fzf-config"

# Add functions to environment
fzf_functions="config/fzf-functions"

# rfv script location
rfv_script="$(pwd)/examples/fzf/rfv/rfv"
```

## Plugins (Zsh only)

For the zsh shell there is additional configurations for the following plugins:

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

You can install them by using the scripts in the plugins directory

- [plugins/install-zsh-autosuggestions.sh](plugins/install-zsh-autosuggestions.sh)
- [plugins/install-zsh-syntax-highlighting.sh](plugins/install-zsh-syntax-highlighting.sh)

The script will add the plugins under `~/.zsh` directory.

Use the install scripts as follows:
```bash
./plugins/install-script-name
```

# Examples

There are sample scripts for the use for the tools:

- [bat](https://github.com/sharkdp/bat): Cat clone with syntax highlight
- [fd](https://github.com/sharkdp/fd): File finder tool
- [ripgrep](https://github.com/BurntSushi/ripgrep): Greping tool
- [fzf](https://github.com/junegunn/fzf): Commandline fuzzy finder

The `fzf` examples includes both a script file to be used directly and a function format file meant to be sourced.

The function format has a helper script to source all the examples. To use it run the following:

```bash
source ./helpers/source-all-functions.sh
```

The script format can be invoked as usual or it can be placed in a directory in the PATH to be called directly.

```bash
# Copy the script to a directory in your PATH
cp examples/fzf/fshow/fshow ~/.local/bin

# Now you can call directly
fshow
```
