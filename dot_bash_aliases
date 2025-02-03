# Some handy .bash_aliases from oh-my-zsh for when using bash

alias ..='cd ..'
alias ...='cd ../..'

# ls, the common ones I use a lot shortened for rapid fire usage
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'
alias lsr='ls -lARFh' #Recursive list of files and directories
alias lsn='ls -1'     #A column contains name of files and directories

# interactive rm, cp, mv
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# colorize grep, egrep, fgrep output
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

alias t='tail -f'  # short for tail -f

alias dud='du -d 1 -h'  # Display the size of files at depth 1 in current location in human-readable form
alias duf='du -sh *'    # Display the size of files in current location in human-readable form

alias h='history'
alias hs='history | grep'       #search in history with grep
alias hsi='history | grep -i'   #search in history with grep (case-insensitive)

alias md='mkdir -p'

# frequent used rsync commands
# all commands include the options
# -a archive mode; preserves owner/group/chmod in destination
# -v verbose output
# -z compression
# --progress detailed progress
# -h human readable (size, transfer rates etc.)
alias rsync-copy="rsync -avz --progress -h"                             # copy file(s) to destination
alias rsync-move="rsync -avz --progress -h --remove-source-files"       # move file(s) to destination (removes them from source)
alias rsync-update="rsync -avzu --progress -h"                          # update file(s) in destination (new and existing files)
alias rsync-synchronize="rsync -avzu --delete --progress -h"            # sync file(s) with destination (deletes files in dest if they are delete
