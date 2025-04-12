#!/bin/bash

packages=(
  age
  atuin
  bat
  btop
  chafa
  cmatrix
  direnv
  duf
  dysk
  eza
  fastfetch
  fd
  fzf
  git-delta
  httpie
  jq
  lazygit
  jwt-cli
  neovim
  perl-image-exiftool
  python
  python-pipx
  ripgrep
  starship
  tealdeer
  ugrep
  wget
  yazi
  zellij
  zoxide
)

for PKG in "${packages[@]}"; do
  sudo pacman -S "$PKG" --noconfirm --needed
done

paru_pkgs=(
  lazydocker
)

for PKG in "${paru_pkgs[@]}"; do
  paru -S "$PKG" --noconfirm --needed
done

# install xxh via pipx
pipx ensurepath
pipx install xxh-xxh
