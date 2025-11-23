#!/bin/bash
# This script only install cli-tools. Desktop packages can be installed manually
# from the files in the scripts-cachy folder.

packages=(
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
  glab
  helm
  helmfile
  httpie
  jq
  jwt-cli
  kubectl
  krew
  kustomize
  k9s
  lazygit
  lazydocker
  neovim
  perl-image-exiftool
  python
  python-pipx
  ripgrep
  sops
  starship
  ttf-jetbrains-mono
  ttf-jetbrains-mono-nerd
  tealdeer
  ugrep
  wl-clipboard
  xclip
  yazi
  yq
  zellij
  zoxide
)

for PKG in "${packages[@]}"; do
  sudo pacman -S "$PKG" --noconfirm --needed
done

# paru_pkgs=(
# )
#
# for PKG in "${paru_pkgs[@]}"; do
#   paru -S "$PKG" --noconfirm --needed
# done

# install xxh via pipx
pipx ensurepath
pipx install xxh-xxh
