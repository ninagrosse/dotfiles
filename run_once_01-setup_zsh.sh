#!/bin/bash

# Check for zsh
if [[ ! $(command -v zsh) ]]; then
  echo "zsh is not installed. Please install it first and then run 'chezmoi apply' again."
  exit 1
fi

# Check if oh-my-zsh is installed, if not install it
if [[ ! -d $HOME/.oh-my-zsh ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
  if [ $? -gt 0 ]; then
    echo "Error installing oh-my-zsh. Abort."
    exit 1
  fi
fi

# Install zsh-autosuggestions + zsh-syntax-highlighting if not installed
if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
