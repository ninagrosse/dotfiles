# Init Starship prompt, if it is installed
[[ $(command -v starship) ]] && eval "$(starship init zsh)"

# Disable Homebrew hints, if it is installed
[[ $(command -v brew) ]] && export HOMEBREW_NO_ENV_HINTS=1

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

# Some additional aliases
alias src='exec zsh' # reload zsh (e.g. after editing .zshrc)

# replace cat with bat if installed
if [[ $(command -v bat) ]]; then
  alias cat='bat'
  # symlink $HOME/.dotfiles/.config/bat to $HOME/.config/bat (only once)
  if [[ ! -L $HOME/.config/bat ]]; then
    mkdir -p $HOME/.config
    ln -s $HOME/.dotfiles/.config/bat $HOME/.config/bat
    bat cache --build # rebuild cache so bat picks up Catppuccin theme
  fi
fi

# eza plugin settings & source
# This needs to be done here. Otherwise the common-aliases plugin would overwrite some of the eza aliases
if [[ $(command -v eza) ]]; then
  zstyle ':omz:plugins:eza' 'dirs-first' yes
  zstyle ':omz:plugins:eza' 'icons' yes
  source ${ZSH:-~/.oh-my-zsh}/plugins/eza/eza.plugin.zsh
  alias l='ll'
fi

# fzf settings
if [[ $(command -v fzf) ]]; then
  # Pipe output to fzf with 'command F' instead of 'command | fzf'
  alias -g F="| fzf"

  # fzf colors (Catppuccin Mocha)
  export FZF_DEFAULT_OPTS=" \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
  --color=selected-bg:#45475a \
  --multi"

  # use bat & eza previews, if they are installed
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

# Replace grep with ugrep
if [[ $(command -v ug) ]]; then
    alias grep='ug'
    alias egrep='ug -E'
    alias fgrep='ug -F'
    alias xzgrep='ug -z'
    alias xzegrep='ug -zE'
    alias xzfgrep='ug -zF'
fi

# Replace cd with z (zoxide)
[[ $(command -v zoxide) ]] && alias cd="z"
