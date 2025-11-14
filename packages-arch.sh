#!/bin/bash
# This script only install cli-tools. Desktop packages can be installed manually
# from the files in the scripts-cachy folder.

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
  helm
  helmfile
  httpie
  jq
  jwt-cli
  kubectl
  krew
  k9s
  lazygit
  neovim
  perl-image-exiftool
  python
  python-pipx
  ripgrep
  sops
  starship
  tealdeer
  ugrep
  yazi
  yq
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
