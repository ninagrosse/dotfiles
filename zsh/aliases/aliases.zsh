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
fi

# replace ls with eza if installed
if [ "$(command -v eza)" ]; then
    alias ll='eza -lg --icons=auto --group-directories-first'
    alias la='eza -lag --icons=auto --group-directories-first'
    alias l='eza -lg'
    alias l.='eza -d .*'
    alias ls='eza'
    alias l1='eza -1'
fi
