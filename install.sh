#!/bin/bash
# dofiles installation script
# This script only works on Debian/Ubuntu or on Mac!

echo
echo "---------------------------------------------------"
echo "--------------dotfiles installer-------------------"
echo "---------------------------------------------------"
echo

# Check OS
OS=$(( lsb_release -ds || cat /etc/*release || uname -om ) 2>/dev/null | head -n1)
case "$OS" in 
  *Debian*) 
    echo "Running on Debian ($OS)"
    DEB="y"
    ;;
  *buntu*) 
    DEB="y"
    echo "Running on Ubuntu ($OS)"
    ;;
  *Darwin*)
    MAC="y"
    echo "Running on Mac ($OS)"
    ;;
  *Raspbian*) 
    DEB="y"
    echo "Running on Raspbian ($OS)"
    ;;
  *)
    echo "Unsupported OS ($OS). This installer only works on Debian/Ubuntu or Mac. Abort."
    exit 1
esac
echo

# Confirm installation or abort
read -p "Do you want to start the installation of dotfiles? [y|n]: " YN
until [[ "$YN" =~ ^([y]|[Y]|[n]|[N])$ ]]; do
  echo "Invalid selection $YN!"
  read -p "Please select [y|n]: " YN
done
if [[ "$YN" =~ ^([n]|[N])$ ]]; then
  echo "Aborting"
  exit 1
fi
echo

# On Debian/Ubuntu, check for apt and sudo access
if [ $DEB ]; then
  if test ! $(which apt); then
    echo "'apt' can't be found. Abort."
    exit 1
  fi
  echo "Updating list of available apt packages"
  sudo apt update
  if [ $? -gt 0 ]; then
    echo "This script needs sudo access. Abort."
    exit 1
  fi
  echo
fi

# Create ssh ed25519 key pair if we don't have one; don't ask for a passphrase
if ! test -f $HOME/.ssh/id_ed25519; then
  ssh-keygen -t ed25519 -f $HOME/.ssh/id_ed25519 -N ''
  echo
fi

# Check if zsh is installed. If not, try to install it with apt or if on Mac, abort.
if test ! $(which zsh); then
  # zsh is installed on Mac by default. However if we can't find it, abort.
  if [ $MAC ]; then
    echo "No zsh installation found. Please install it first!"
    exit 1
  fi
  echo "No zsh installation found; trying to install with apt"
  sudo apt install -y zsh
  if [ $? -gt 0 ]; then
    echo "Error installing zsh. Abort."
    exit 1
  fi
  # Switch shell to zsh for the current user
  echo
  echo "Changing default shell to zsh"
  sudo chsh -s $(which zsh) $(whoami)
  if [ $? -gt 0 ]; then
    echo "Can't change default shell to zsh. Please check manually."
  fi
  echo
fi

# Check if oh-my-zsh is installed, if not install it
if ! test -d $HOME/.oh-my-zsh; then
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  if [ $? -gt 0 ]; then
    echo "Error installing oh-my-zsh. Abort."
    exit 1
  fi
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
  echo "Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ $? -gt 0 ]; then
    echo "Error installing Homebrew. Abort."
    exit 1
  fi
  # Activate Homebrew shellenv for this installer session
  if [ $MAC ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    # On Debian/Ubuntu also install recommended build tools
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    sudo apt install build-essential -y
  fi
  echo
fi

# Install Homebrew packages (see Brewfile)
echo "Installing Homebrew packages from Brewfile"
brew tap homebrew/bundle
brew bundle
echo

# Link dotfiles
echo "Linking .zshrc"
mv $HOME/.zshrc $HOME/.zshrc.pre-dotfiles
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

echo
echo "DONE!"
echo "Launching zsh"
echo

exec zsh
