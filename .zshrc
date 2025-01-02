# Setup $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the oh-my-zsh theme to load
# The theme only loads while starship prompt is not installed and activated 
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bira"

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

# Ignore commands that start with spaces and duplicates.
export HISTCONTROL=ignoreboth

# Don't add certain commands to the history file.
export HISTIGNORE="&:[bf]g:c:clear:clr:history:exit:q:pwd:* --help"

# Combine all plugins.*.zsh files in $HOME/.dotfiles/zsh/plugins into plugins.zsh
cat $HOME/.dotfiles/zsh/plugins/plugins.*.zsh > $HOME/.dotfiles/zsh/plugins/plugins.zsh

# Get the list of oh-my-zsh plugins, that should be loaded, from the created plugins.zsh
plugins=("${(f)$(< $HOME/.dotfiles/zsh/plugins/plugins.zsh)}")

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Set preferred editor
# Use vscode when inside vscode terminal, otherwise use nvim
if [[ -n $TERM_PROGRAM ]]; then
  if [[ $TERM_PROGRAM == 'vscode' ]]; then
    export EDITOR='code --wait'
  else
    export EDITOR='nvim'
  fi
else
  export EDITOR='nvim'
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
fi

# Set eza plugin settings & source it, if eza is installed
# This needs to happen after sourcing oh-my-zsh. Otherwise the common-aliases plugin would overwrite some of the eza aliases
if [[ $(command -v eza) ]]; then
  zstyle ':omz:plugins:eza' 'dirs-first' yes
  zstyle ':omz:plugins:eza' 'icons' yes
  source ${ZSH:-~/.oh-my-zsh}/plugins/eza/eza.plugin.zsh
  alias l='ll' # make alias l the same as ll (eza -gl)
  alias lt='ls --tree' # tree alias (ls is already aliased to eza)
  alias lat='ls -a --tree' # tree alias including hidden folder/files
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

# Function for yazi to start it with just a 'y' and cd into the directory, you're currently in, when exiting yazi
if [[ $(command -v yazi) ]]; then
  function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
  }
fi

# Replace cd with z (zoxide), if it is installed
[[ $(command -v zoxide) ]] && alias cd="z"

# Replace vim with nvim, if it is installed
[[ $(command -v nvim) ]] && alias vim='nvim'

# Load machine specific aliases, environment variables etc. from $HOME/.zshrc.local.zsh, if the file exists
[[ -f $HOME/.zshrc.local.zsh ]] && source $HOME/.zshrc.local.zsh

# Zellij settings
if [[ $(command -v zellij) ]]; then
  # Function to either attach/resurrect a session or create a new one, if none exists
  # No session: create new session
  # One session (alive or exited): attach / resurrect session
  # Two or more sessions (alive or exited): select session with fzf
  function za() {
    local ZJ_SESSIONS=$(zellij list-sessions -n -s)
    local NO_SESSIONS=$(echo "${ZJ_SESSIONS}" | wc -w)
    if [ "${NO_SESSIONS}" -eq 1 ]; then
      zellij attach "$ZJ_SESSIONS"
    elif [ "${NO_SESSIONS}" -ge 2 ]; then
      zellij attach "$(echo "${ZJ_SESSIONS}" | fzf)"
    else
      zellij
    fi
  }

  # More Zellij aliases
  alias zls='zellij list-sessions'
  alias zd='zellij delete-session'
  alias zda='zellij delete-all-sessions'
  alias zk='zellij kill-session'
  alias zka='zellij kill-all-sessions'
  alias zj='zellij' # creates a new session regardless of existing ones
  alias zla='zellij --layout'

  # Autostart Zellij on shell creation
  # This needs to be at the very end
  export ZELLIJ_AUTO_ATTACH="true"
  if [[ -z "$ZELLIJ" ]]; then
    if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
        za
    else
        zellij
    fi

    if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
        exit
    fi
  fi
fi
