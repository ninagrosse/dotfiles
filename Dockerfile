FROM --platform=linux/amd64 ubuntu:24.04

RUN apt-get update && apt-get upgrade -y && apt-get install -y vim nano curl git zsh tree build-essential sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ubuntu
RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

WORKDIR /home/ubuntu
