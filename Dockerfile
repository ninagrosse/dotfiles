FROM --platform=linux/amd64 ubuntu:24.04

# Must have packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y vim nano curl git zsh tree
RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Copy .dotfiles to image
RUN mkdir -p /root/.dotfiles
WORKDIR /root/.dotfiles
COPY . /root/.dotfiles/
