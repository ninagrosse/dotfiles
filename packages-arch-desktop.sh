#!/bin/bash

packages=(
  alacritty
  brave-bin
  filelight
  ksystemlog
  ttf-jetbrains-mono
  ttf-jetbrains-mono-nerd
  vlc
  wl-clipboard
  xclip
)

for PKG in "${packages[@]}"; do
  sudo pacman -S "$PKG" --noconfirm --needed
done

paru_pkgs=(
  cryptomator
  enpass-bin
  insync
  insync-dolphin
  kwin-effect-rounded-corners-git
  kwin-scripts-dynamic-workspaces
  kwin-scripts-krohnkite-git
  rustdesk-bin
)

for PKG in "${paru_pkgs[@]}"; do
  paru -S "$PKG" --noconfirm --needed
done
