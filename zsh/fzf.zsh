#!/usr/bin/env zsh

export FZF_DEFAULT_OPTS="--height 90% --layout=reverse --border"
export FZF_DEFAULT_COMMAND="fd --exclude={.wine,.git,.idea,.vscode,.sass-cache,node_modules,build,.local,.steam,.m2,.rangerdir,.ssh,.ghidra,.mozilla} --hidden --follow . /etc /home"

_fzf_fpath=${0:h}/fzf
fpath+=$_fzf_fpath
autoload -U $_fzf_fpath/*(.:t)
unset _fzf_fpath

fzf-redraw-prompt() {
	local precmd
	for precmd in $precmd_functions; do
		$precmd
	done
	zle reset-prompt
}
zle -N fzf-redraw-prompt

zle -N fzf-find-widget
bindkey '^f' fzf-find-widget

fzf-cd-widget() {
	local tokens=(${(z)LBUFFER})
	if (( $#tokens <= 1 )); then
		zle fzf-find-widget 'only_dir'
		if [[ -d $LBUFFER ]]; then
			cd $LBUFFER
			local ret=$?
			LBUFFER=
			zle fzf-redraw-prompt
			return $ret
		fi
	fi
}
zle -N fzf-cd-widget
bindkey '^t' fzf-cd-widget

fzf-history-widget() {
	local num=$(fhistory $LBUFFER)
	local ret=$?
	if [[ -n $num ]]; then
		zle vi-fetch-history -n $num
	fi
	zle reset-prompt
	return $ret
}
zle -N fzf-history-widget
bindkey '^h' fzf-history-widget

vim_fzf() {
    local fzf_result=$(fd --exclude={.wine,.git,.idea,.vscode,.sass-cache,node_modules,build,.local,.steam,.m2,.rangerdir,.ssh,.ghidra,.mozilla} --type f --hidden --follow . /etc /home | fzf)
    echo $fzf_result
    if [ -z "$fzf_result" ]
    then
        echo "No file specific, Interupt the vim command"
    else
        nvim  $fzf_result
    fi
}
bindkey -s '^e' 'vim_fzf\n'

cd_fzf() {
    local fzf_result=$(fd --exclude={.wine,.git,.idea,.vscode,.sass-cache,node_modules,build,.local,.steam,.m2,.rangerdir,.ssh,.ghidra,.mozilla} --type d --hidden --follow . /etc /home | fzf)
    echo $fzf_result
    if [ -z "$fzf_result" ]
    then
        echo "No directory specific, Interupt the cd command"
    else
        cd  $fzf_result
    fi
}
bindkey -s '^a' 'cd_fzf\n'
