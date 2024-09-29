FROM ubuntu:24.04

# Must have packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y vim nano curl git sudo

# Enable passwordless sudo and switch to ubuntu user
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ubuntu

# Copy .dotfiles to image
RUN mkdir -p /home/ubuntu/.dotfiles
WORKDIR /home/ubuntu/.dotfiles
COPY . /home/ubuntu/.dotfiles/
