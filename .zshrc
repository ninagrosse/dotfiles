# Setup $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the oh-my-zsh theme to load
# The theme only loads while starship prompt is not installed and activated 
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bira"

# Combine all plugins.*.zsh files in $HOME/.dotfiles/zsh/plugins into plugins.zsh
cat $HOME/.dotfiles/zsh/plugins/plugins.*.zsh > $HOME/.dotfiles/zsh/plugins/plugins.zsh

# Get the list of oh-my-zsh plugins, that should be loaded, from the created plugins.zsh
plugins=("${(f)$(< $HOME/.dotfiles/zsh/plugins/plugins.zsh)}")

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Set preferred editor for local and remote sessions
# Use vscode when using it, otherwise use nano
if [[ -n $TERM_PROGRAM ]]; then
  if [[ $TERM_PROGRAM == 'vscode' ]]; then
    export EDITOR='code --wait'
  else
    export EDITOR='nano'
  fi
else
  export EDITOR='nano'
fi

# Alias to reload zsh (e.g. after editing .zshrc or editing plugins)
alias src='exec zsh'

# Init Starship prompt, if it is installed
[[ $(command -v starship) ]] && eval "$(starship init zsh)"

# Disable Homebrew hints, if it is installed
[[ $(command -v brew) ]] && export HOMEBREW_NO_ENV_HINTS=1

# Replace cat with bat, if it is installed
if [[ $(command -v bat) ]]; then
  alias cat='bat'
  # Also symlink $HOME/.dotfiles/.config/bat to $HOME/.config/bat (only once)
  if [[ ! -L $HOME/.config/bat ]]; then
    mkdir -p $HOME/.config
    ln -s $HOME/.dotfiles/.config/bat $HOME/.config/bat
    bat cache --build # rebuild cache so bat picks up Catppuccin Mocha theme
  fi
fi

# Set eza plugin settings & source it, if eza is installed
# This needs to happen after sourcing oh-my-zsh. Otherwise the common-aliases plugin would overwrite some of the eza aliases
if [[ $(command -v eza) ]]; then
  zstyle ':omz:plugins:eza' 'dirs-first' yes
  zstyle ':omz:plugins:eza' 'icons' yes
  source ${ZSH:-~/.oh-my-zsh}/plugins/eza/eza.plugin.zsh
  alias l='ll' # make alias l the same as ll (eza -gl)
fi

# Set fzf settings, if it is installed
if [[ $(command -v fzf) ]]; then
  # Alias to pipe output to fzf with 'command F' instead of 'command | fzf'
  alias -g F="| fzf"

  # Set fzf colors (Catppuccin Mocha)
  export FZF_DEFAULT_OPTS=" \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
  --color=selected-bg:#45475a \
  --multi"

  # Use bat & eza previews, if they are installed
  if [[ $(command -v bat) ]] && [[ $(command -v eza) ]]; then
    show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

    export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
    export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

    # Advanced customization of fzf options via _fzf_comprun function
    # - The first argument to the function is the name of the command.
    # - You should make sure to pass the rest of the arguments to fzf.
    _fzf_comprun() {
      local command=$1
      shift
      case "$command" in
        cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
        *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
      esac
    }
  fi
fi

# Replace grep with ugrep, if it is installed
if [[ $(command -v ug) ]]; then
    alias grep='ug'
    alias egrep='ug -E'
    alias fgrep='ug -F'
    alias xzgrep='ug -z'
    alias xzegrep='ug -zE'
    alias xzfgrep='ug -zF'
fi

# Replace cd with z (zoxide), if it is installed
[[ $(command -v zoxide) ]] && alias cd="z"

# Load machine specific aliases, environment variables etc. from $HOME/.zshrc.local.zsh, if the file exists
[[ -f $HOME/.zshrc.local.zsh ]] && source $HOME/.zshrc.local.zsh
