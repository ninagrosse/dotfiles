#!/bin/bash

echo "Executing 'setup_zsh.sh'"
bash setup_zsh.sh

echo "Executing 'setup_brew.zsh'"
zsh setup_brew.zsh

echo "Executing 'setup_gitconfig.sh'"
bash setup_gitconfig.sh

echo
echo "All done!"
echo "Please reload your zsh with 'exec zsh'"
echo
