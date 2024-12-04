# dotfiles
My personal dotfiles

This repo contains automatic zsh setup and config with [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) and various plugins. See [`setup_zsh.sh`](setup_zsh.sh) and the READMEs in [`zsh/aliases`](zsh/aliases/) and [`zsh/plugins`](zsh/plugins/) for reference.

It also contains automatic setup and config for various [Hommebrew](https://brew.sh/) packages. See [`Brewfile`](Brewfile) and [`setup_brew.zsh`](setup_brew.zsh) for reference.

## Prerequisites
To use the setup scripts, zsh and Hommebrew need to be installed manually first. See their respective docs for instructions. After installing zsh and Homebrew, `setup_zsh.sh` should be run first, because `setup_brew.zsh` requires oh-my-zsh to be installed. If you don't use Homebrew just skip its installation and setup.

## Installation
Clone this repo to `$HOME/.dotfiles` (the path is important).
```shell
git clone git@github.com:ninagrosse/dotfiles.git $HOME/.dotfiles

cd $HOME/.dotfiles
```

### Setup zsh
Run `./setup_zsh.sh`

### Setup Homebrew
Run `./setup_brew.sh`

## Testing
To test the setup scripts, there is a [`Dockerfile`](Dockerfile) which is based on the latest Ubuntu. It installs some required tools (`vim nano curl git zsh brew tree build-essential`) and copies all dotfiles, except the .gitignore'd ones, to `/root/.dotfiles`.

Build the image with `docker build -t <some tag> .`

Launch a container with `docker container run -it --rm <some tag> bash`

Inside the container run the following commands to test

```shell
./setup_zsh.sh
./setup_brew.zsh
exec zsh
```
