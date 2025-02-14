#!/bin/bash

packages=(
  atuin
  bat
  btop
  direnv
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
  pacman -S "$PKG" --noconfirm --needed
done

paru_pkgs=(
  lazydocker
)

for PKG in "${paru_pkgs[@]}"; do
  paru -S "$PKG" --noconfirm --needed
done
