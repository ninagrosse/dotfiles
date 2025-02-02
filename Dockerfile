FROM --platform=linux/amd64 ubuntu:24.04

# Must have packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y vim nano curl git zsh tree build-essential stow sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ubuntu
RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME"/.local/bin

# Copy .dotfiles to image
RUN mkdir -p /home/ubuntu/.dotfiles
WORKDIR /home/ubuntu/.dotfiles
COPY . /home/ubuntu/.dotfiles/
WORKDIR /home/ubuntu
