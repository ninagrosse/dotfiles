# 🏠 dotfiles

My personal dotfiles, managed with [chezmoi](https://github.com/twpayne/chezmoi). Compatible with Linux, MacOS and Windows 11.

## 📖 Linux & MacOS instructions

### Requirements

* zsh
* [Homebrew](https://brew.sh/)
* [Jetbrains Mono Nerd Font](https://www.nerdfonts.com/font-downloads)

### Installation

One-line Installation

```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply ninagrosse --ssh
```

This installs `chezmoi`, clones the repo and applies everything. Follow the on-screen prompts to setup git email and username. For cloning with https instead, omit `--ssh`.

### Scripts description

#### [`run_once_01-setup_zsh.sh`](run_once_01-setup_zsh.sh)

Installs `oh-my-zsh`, `zsh-autosuggestions` and `zsh-syntax-highlighting`, if they are not already installed.

#### [`run_onchange_02-install_packages.sh`](run_onchange_02-install_packages.sh.tmpl)

Installs various CLI tools and apps with Homebrew and performs necessary setups if needed.

## 📖 Windows instructions

### Requirements

* [Scoop](https://scoop.sh/)
* winget
* [Git for Windows](https://git-scm.com/downloads/win) (can install with `winget install --id Git.Git -e --source winget`)
* [Jetbrains Mono Nerd Font](https://www.nerdfonts.com/font-downloads)

### Installation

In Windows Settings

* Go to System -> Developer -> PowerShell -> enable unsigned local scripts
* Go to System -> Developer -> Enable Developer Mode
* Go to System -> Multitasking -> Disable Windows Snap Assist (if using komorebi)

Install `chezmoi`

```shell
# with scoop
scoop install chezmoi
```

```shell
# with winget
winget install twpayne.chezmoi
```

Install dotfiles

```shell
chezmoi init --apply ninagrosse --ssh
```

This clones the repo and applies everything. Follow the on-screen prompts to setup git email and username. For cloning with https instead, omit `--ssh`.

To start the AutoHotkey script upon login, run (Win+R) `shell:startup` to open the startup folder. Create a shortcut to `capslock.ahk` in this folder.

### Scripts description

#### [`run_onchange_01-install_scoop_packages.ps1`](run_onchange_01-install_scoop_packages.ps1)

Installs various CLI tools and apps with Scoop and performs necessary setups if needed.

#### [`run_onchange_02-install_winget_packages.ps1`](run_onchange_02-install_winget_packages.ps1)

Installs various desktop applications with winget.

## ⚙️ Other configs

* [Neovim config](https://github.com/ninagrosse/lazyvim-config)
* [Wezterm config](https://github.com/ninagrosse/wezterm-config)
* [CLI tools plugin for xxh](https://github.com/ninagrosse/xxh-plugin-prerun-cli-tools)
