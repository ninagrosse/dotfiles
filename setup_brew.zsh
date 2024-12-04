#!/usr/bin/env zsh

echo "Setting up and installing brew packages"

# Source omz brew plugin, so brew shellenv is initialized for the first time and 
# we can use 'brew bundle' to install packages
source ${ZSH:-~/.oh-my-zsh}/plugins/brew/brew.plugin.zsh

# Install packages from Brewfile
brew bundle

# Create $HOME/.dotfiles/zsh/plugins/plugins.brew.zsh to load brew specific omz-plugins
# This should at least contain the brew plugin, so the brew shellenv gets loaded in subsequent .zshrc
cat <<EOT >> $HOME/.dotfiles/zsh/plugins/plugins.brew.zsh
brew
direnv
EOT

echo
echo "DONE!"
echo "Please reload zsh with 'exec zsh'"
echo
