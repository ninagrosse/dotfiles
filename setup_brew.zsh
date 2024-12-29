#!/usr/bin/env zsh

echo "Setting up and installing brew packages"

# Source omz brew plugin, so brew shellenv is initialized for the first time and 
# we can use 'brew bundle' to install packages
source ${ZSH:-~/.oh-my-zsh}/plugins/brew/brew.plugin.zsh

# Install packages from Brewfile
brew bundle

# Create $HOME/.dotfiles/zsh/plugins/plugins.brew.zsh to load brew specific omz-plugins
# This should at least contain the brew plugin, so the brew shellenv gets loaded in subsequent .zshrc
cat <<EOT > $HOME/.dotfiles/zsh/plugins/plugins.brew.zsh
brew
direnv
fzf
tmux
tmux-cssh
zoxide
EOT

# bat: Symlink $HOME/.dotfiles/.config/bat to $HOME/.config/bat (only once)
if [[ $(command -v bat) ]]; then
  if [[ ! -L $HOME/.config/bat ]]; then
    mkdir -p $HOME/.config
    ln -s $HOME/.dotfiles/.config/bat $HOME/.config/bat
    bat cache --build # rebuild cache so bat picks up Catppuccin Mocha theme
  fi
fi

# tmux setup (only once)
# - Symlink $HOME/.dotfiles/.config/tmux to $HOME/.config/tmux 
# - Install tpm
# - Download tmux-cssh
if [[ $(command -v tmux) ]]; then
  if [[ ! -L $HOME/.config/tmux ]]; then
    mkdir -p $HOME/.config
    ln -s $HOME/.dotfiles/.config/tmux $HOME/.config/tmux
  fi
  if [[ ! -d $HOME/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
  fi
  if [[ ! -f $HOME/.local/bin/tmux-cssh ]]; then
    mkdir -p $HOME/.local/bin
    wget -O $HOME/.local/bin/tmux-cssh https://github.com/zinic/tmux-cssh/raw/refs/heads/master/tmux-cssh
  fi
fi

# xxh: Symlink $HOME/.dotfiles/.config/xxh to $HOME/.config/xxh (only once)
if [[ $(command -v xxh) ]]; then
  if [[ ! -L $HOME/.config/xxh ]]; then
    mkdir -p $HOME/.config
    ln -s $HOME/.dotfiles/.config/xxh $HOME/.config/xxh
  fi
fi

# yazi: Symlink $HOME/.dotfiles/.config/yazi to $HOME/.config/yazi (only once)
if [[ $(command -v yazi) ]]; then
  if [[ ! -L $HOME/.config/yazi ]]; then
    mkdir -p $HOME/.config
    ln -s $HOME/.dotfiles/.config/yazi $HOME/.config/yazi
  fi
fi

echo
echo "Done!"
echo
