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
