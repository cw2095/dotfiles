#!/user/bin/env bash

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias d='dirs -v | head -10'

# File handling
# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -I --preserve-root'
alias rmr='rm -ivr'
alias mv='mv -iv'
alias cp='cp -iv'
alias cpr='cp -ivr'
alias ln='ln -iv'
alias mkdir='mkdir -pv'
alias mkcd='_(){ mkdir -p $1; cd $1; }; _'

alias chmod='chmod --preserve-root -v'
alias chown='chown --preserve-root -v'
alias chgrp='chgrp --preserve-root -v'

alias df='df -h'
alias du='du -h'
alias dud='du -ch -d 1'

# Listing files inside a packed file
alias zip='unzip -l'
alias rar='unrar l'
alias tar='tar tf'

alias c='clear'
alias ping='ping -c 5'
alias root='sudo -i'
alias su='sudo -i'
# repeating the last command but using sudo
alias please='sudo $(fc -ln -1)'
alias wl='wc -l'
alias tree='tree -C'

# zfm
alias of='vi $(zfm select --files --multi)'
alias od='cd $(zfm select --dirs --multi)'
