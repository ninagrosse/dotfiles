#!/bin/bash

# Read git user.name and user.email from stdin
read -p "Please enter your git user.name: " name
if [[ ! "$name" ]]; then
  echo "You must provide a git user.name! Abort."
  exit 1
fi
read -p "Please enter your git user.email: " email
if [[ ! "$email" ]]; then
  echo "You must provide a git user.email! Abort."
  exit 1
fi

# Backup existing .gitconfig
[[ -f $HOME/.gitconfig ]] && mv $HOME/.gitconfig $HOME/.gitconfig.pre-dotfiles

# Create .gitconfig which includes $HOME/.dotfiles/.gitconfig
cat <<EOT >> $HOME/.gitconfig
[user]
	name = $name
	email = $email
[include]
  path = .dotfiles/.gitconfig
EOT

echo
echo "Created .gitconfig with the following entries:"
echo
git config --global --includes --list
