# dotfiles

My personal dotfiles, managed with [chezmoi](https://github.com/twpayne/chezmoi)

## Requirements

* zsh
* [Homebrew](https://brew.sh/)

## Installation

One-line Installation

```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply ninagrosse --ssh
```

This installs `chezmoi`, clones the repo and applies everything. Follow the on-screen prompts to setup git email and username. For cloning with https instead, omit `--ssh`.

## Scripts description

#### [`run_once_01-setup_zsh.sh`](run_once_01-setup_zsh.sh)

Installs `oh-my-zsh`, `zsh-autosuggestions` and `zsh-syntax-highlighting`, if they are not already installed.

#### [`run_onchange_02-install_packages.sh.tmpl`](run_onchange_02-install_packages.sh.tmpl)

Installs various CLI tools and apps with Homebrew and performs necessary setups if needed.
