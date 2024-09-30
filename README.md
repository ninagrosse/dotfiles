# dotfiles
My personal dotfiles (WORK IN PROGRESS!)

## Installation
Clone this repo to `$HOME/.dotfiles` and run the installer.
```shell
# via SSH
git clone git@github.com:ninagrosse/dotfiles.git $HOME/.dotfiles

# via HTTPS
git clone https://github.com/ninagrosse/dotfiles.git $HOME/.dotfiles

# switch directory and run the installer
cd $HOME/.dotfiles
./install.sh
```
The installer only works on Debian/Ubuntu or Mac!

## Testing
For testing the installer, there is a Dockerfile which is based on the latest Ubuntu. It... 

* installs some essential tools (`vim nano curl git sudo`)
* enables passwordless `sudo`
* switches to the pre-installed default user `ubuntu`
* copies all dotfiles to `/home/ubuntu/.dotfiles`

Build the image with `docker build -t <some tag> -f testing/Dockerfile .`

Launch a container with `docker container run -it --rm <some tag> bash`

Inside the container run the installer with `./install.sh`
