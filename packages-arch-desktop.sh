#!/bin/bash

packages=(
  alacritty
  brave-bin
  filelight
  jdk21-openjdk
  ksystemlog
  ttf-jetbrains-mono
  ttf-jetbrains-mono-nerd
  vlc
  wl-clipboard
  xclip
)

for PKG in "${packages[@]}"; do
  sudo pacman -S "$PKG" --needed
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
  paru -S "$PKG" --needed
done
