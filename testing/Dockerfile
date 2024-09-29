FROM ubuntu:24.04

# Must have packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y vim nano curl git sudo

# Enable passwordless sudo and switch to ubuntu user
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ubuntu
WORKDIR /home/ubuntu

# Clone my dotfiles
RUN git clone https://github.com/ninagrosse/dotfiles.git $HOME/.dotfiles
