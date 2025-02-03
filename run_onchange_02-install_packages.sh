#!/usr/bin/env zsh

# Source oh-my-zsh brew plugin, so brew shellenv is initialized for the first time and
# we can use 'brew bundle' to install packages
source ${ZSH:-~/.oh-my-zsh}/plugins/brew/brew.plugin.zsh

# Install packages with inline 'brew bundle'
brew bundle --no-lock --file=/dev/stdin <<EOF
tap 'mike-engel/jwt-cli'
tap 'jesseduffield/lazydocker'
tap 'jesseduffield/lazygit'
brew 'atuin'
brew 'bat'
brew 'btop'
brew "direnv"
brew 'dysk'
brew 'eza'
brew 'fastfetch'
brew 'fd'
brew 'fzf'
brew 'git-delta'
brew 'httpie'
brew 'jq'
brew 'jesseduffield/lazydocker/lazydocker'
brew 'jesseduffield/lazygit/lazygit'
brew 'mike-engel/jwt-cli/jwt-cli'
brew 'neovim'
brew 'ripgrep'
brew 'starship'
brew "tealdeer"
brew "tmux"
brew "ugrep"
brew 'wget'
brew "xxh"
brew 'yazi'
brew "zellij"
brew "zoxide"
EOF

# Build bat cache so it can pick up Catppuccin theme
bat cache --build

# Run 'ya pack' to install yazi plugins and theme
ya pack -i
