# dotfiles
My personal dotfiles (WORK IN PROGRESS!)

## Testing
For testing the installer, there is a Dockerfile which is based on the latest Ubuntu. It... 

* installs some essential tools (`vim nano curl git sudo`)
* enables passwordless `sudo`
* switches to the pre-installed default user `ubuntu`
* copies all dotfiles to `/home/ubuntu/.dotfiles`

Build the image with `docker build -t <some tag> -f testing/Dockerfile .`

Launch a container with `docker container run -it --rm <some tag> bash`

Inside the container run the installer with `./install.sh`
