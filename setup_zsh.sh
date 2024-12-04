#!/bin/bash

# Check if oh-my-zsh is installed, if not install it
if [[ ! -d $HOME/.oh-my-zsh ]]; then
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  if [ $? -gt 0 ]; then
    echo "Error installing oh-my-zsh. Abort."
    exit 1
  fi
  echo
fi

# Install zsh-autosuggestions + zsh-syntax-highlighting if not installed
if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
  echo "Installing zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  echo
fi
if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
  echo "Installing zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  echo
fi

# Symlink .zshrc
echo "Symlinking $HOME/.zshrc to $HOME/.dotfiles/.zshrc"
[[ -f $HOME/.zshrc ]] && mv $HOME/.zshrc $HOME/.zshrc.pre-dotfiles
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

echo
echo "DONE!"
echo "Launch zsh with 'exec zsh'"
echo
