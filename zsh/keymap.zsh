#! /usr/bin/env zsh

bindkey '^v' edit-command-line
# Bind C+Space to accept the current suggestion
bindkey ',' autosuggest-accept

# pabloariasal/zfm
bindkey -r '^P'
bindkey -r '^O'

bindkey -s '^\' 'n\n'
