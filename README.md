# dotfiles

My personal dotfiles, managed with [chezmoi](https://github.com/twpayne/chezmoi)

## Requirements

* zsh
* [Homebrew](https://brew.sh/)

## Installation

One-line Installation

```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply ninagrosse --branch chezmoi --ssh
```

This installs `chezmoi`, clones the repo and applies everything. For cloning with https instead, omit `--ssh`.

Follow the on-screen prompts to setup git email and username. Afterwards, all packages in [`run_onchange_02-install_packages.sh`](run_onchange_02-install_packages.sh) will be installed.
