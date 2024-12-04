# dotfiles
My personal dotfiles

## Content

- Automatic zsh setup and config with [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) and various plugins. See [`setup_zsh.sh`](setup_zsh.sh) and the READMEs in [`zsh/aliases`](zsh/aliases/) and [`zsh/plugins`](zsh/plugins/).
- Automatic setup and config for various [Homebrew](https://brew.sh/) packages. See [`Brewfile`](Brewfile) and [`setup_brew.zsh`](setup_brew.zsh).
- Creation of a new .gitconfig in the user home which includes the settings from this repo's [`.gitconfig`](.gitconfig). See [`setup_gitconfig.sh`](setup_gitconfig.sh).

## Prerequisites
To use the setup scripts, zsh and Homebrew need to be installed manually first. See their respective docs for instructions. After installing `setup_zsh.sh` should be run first, because `setup_brew.zsh` requires oh-my-zsh to be installed. If Homebrew isn't used or can't be installed, just skip its installation and setup.

The settings in this repo's .gitconfig use [delta](https://dandavison.github.io/delta/installation.html) as the core.pager, so delta needs to either be installed (it is included in Brewfile) or core.pager needs to be overwritten at the end of `$HOME/.gitconfig`. Configurations for credentials etc. should be placed in `$HOME/.gitconfig` as well, so they don't get committed.

## Installation
Clone the repo to `$HOME/.dotfiles` (the path is important)
```shell
git clone git@github.com:ninagrosse/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles
```

Run the setup scripts and reload zsh
```shell
./setup_zsh.sh
./setup_brew.zsh
./setup_gitconfig.sh
exec zsh
```

## Testing
To test the setup scripts, there is a [`Dockerfile`](Dockerfile) which is based on the latest Ubuntu. It installs some required tools (`vim nano curl git zsh brew tree build-essential`) and copies all dotfiles, except the .gitignore'd ones, to `/root/.dotfiles`.

Build the image with `docker build -t <some tag> .`

Launch a container with `docker container run -it --rm <some tag> bash`

Inside the container execute the setup scripts to test.
