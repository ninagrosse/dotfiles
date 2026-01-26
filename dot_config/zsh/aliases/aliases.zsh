# Reload zsh (e.g. after editing .zshrc or editing plugins)
alias src='exec zsh'

# Edit .zshrc in the chezmoi source directory
alias zshrc='chezmoi edit ${ZDOTDIR:-$HOME}/.zshrc'

# Replace cat with bat
alias cat='bat'

# More eza aliases
alias l='ll'             # make alias l the same as ll (eza -gl)
alias lt='ls --tree'     # tree alias (ls is already aliased to eza)
alias lat='ls -a --tree' # tree alias including hidden folder/files

# Pipe output to fzf with 'command F' instead of 'command | fzf'
alias -g F="| fzf"

# Pipe output to ripgrep with 'command R' instead of 'command | rg'
alias -g R="| rg"

# Replace grep with ugrep
alias grep='ug'
alias egrep='ug -E'
alias fgrep='ug -F'
alias xzgrep='ug -z'
alias xzegrep='ug -zE'
alias xzfgrep='ug -zF'

# lazigit alias
alias lg='lazygit'

# Replace cd with z (zoxide)
alias cd="z"

# Zellij aliases
alias zls='zellij list-sessions'
alias zd='zellij delete-session'
alias zda='zellij delete-all-sessions'
alias zk='zellij kill-session'
alias zka='zellij kill-all-sessions'
alias zj='zellij' # creates a new session regardless of existing ones
alias zla='zellij --layout'

# Alias to load Neovim with the minimal config included in the dotfiles
alias mn='NVIM_APPNAME=minimal-nvim nvim'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# clr+fastfetch
alias clr="clear"
alias c="clr && fastfetch"

# chezmoi aliases
alias cad="chezmoi add"
alias cap="chezmoi apply"
alias ccd="echo \'chezmoi cd\' starts a sub-shell. Don\'t forget to exit when you are done.; chezmoi cd"
alias cdi="chezmoi diff"
alias ced="chezmoi edit"
alias cls="chezmoi list"
alias cra="chezmoi re-add"
alias cst="chezmoi status"
alias cup="chezmoi update"
