#!/bin/sh
# dofiles installation script

# Create ssh ed25519 key pair if we don't have one; don't ask for a passphrase
if ! test -f $HOME/.ssh/id_ed25519; then
  echo "Generating ssh ed25519 key pair"
  ssh-keygen -t ed25519 -f $HOME/.ssh/id_ed25519 -N ''
  echo
fi

# Check if zsh is installed, if not install it
if test ! $(which zsh); then
  echo "No zsh installation found; trying to install with apt"
  sudo apt update && sudo apt install -y zsh
  # Switch shell to zsh for the current user
  echo
  echo "Changing default shell to zsh"
  sudo chsh -s $(which zsh) $(whoami)
  echo
fi

# Check if oh-my-zsh is installed, if not install it
if ! test -d $HOME/.oh-my-zsh; then
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  echo
fi

# Install zsh-autosuggestions + zsh-syntax-highlighting
if ! test -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions; then
  echo "Installing zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  echo
fi
if ! test -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting; then
  echo "Installing zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  echo
fi

# Install Homebrew if not installed
if test ! $(which brew); then
  echo "Installing Homebrew and build dependencies"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  sudo apt install build-essential -y
  echo
fi

# Install Homebrew packages (see Brewfile)
brew tap homebrew/bundle
brew bundle --file ./Brewfile

echo
echo "DONE!"
echo
