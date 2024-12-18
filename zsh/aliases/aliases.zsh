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
if [ "$(command -v bat)" ]; then
    alias cat='bat'
    # symlink $HOME/.dotfiles/.config/bat to $HOME/.config/bat (only once)
    if [[ ! -L $HOME/.config/bat ]]; then
      ln -s $HOME/.dotfiles/.config/bat $HOME/.config/bat
      bat cache --build # rebuild cache so bat picks up Catppuccin theme
    fi
fi

# eza plugin settings & source
# This needs to be done here. Otherwise the common-aliases plugin would overwrite
# some of the eza aliases
if [ "$(command -v eza)" ]; then
  zstyle ':omz:plugins:eza' 'dirs-first' yes
  zstyle ':omz:plugins:eza' 'icons' yes
  source ${ZSH:-~/.oh-my-zsh}/plugins/eza/eza.plugin.zsh
  alias l='ll'
fi

# Pipe output to fzf, e.g. 'alias F' to fzf through all aliases
if [ "$(command -v fzf)" ]; then
  alias -g F="| fzf"
fi

# Replace grep with ugrep
if [ "$(command -v ug)" ]; then
    alias grep='ug'
    alias egrep='ug -E'
    alias fgrep='ug -F'
    alias xzgrep='ug -z'
    alias xzegrep='ug -zE'
    alias xzfgrep='ug -zF'
fi
