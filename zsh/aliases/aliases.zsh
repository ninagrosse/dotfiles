# Some additional aliases
alias src='exec zsh' # reload zsh (e.g. after editing .zshrc)
alias sysupdate='sudo apt update && sudo apt upgrade' # TODO, use ubuntu zsh plugin instead

# replace cat with bat if installed
if [ "$(command -v bat)" ]; then
    alias cat='bat'
fi

# replace ls with eza if installed
if [ "$(command -v eza)" ]; then
    alias ll='eza -l --icons=auto --group-directories-first'
    alias la='eza -la --icons=auto --group-directories-first'
    alias l='eza -l'
    alias l.='eza -d .*'
    alias ls='eza'
    alias l1='eza -1'
fi
