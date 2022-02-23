#!/usr/bin/env bash

mktar(){ tar cvf  "${1%%/}.tar" "${1%%/}/"; }
mktgz(){ tar cvzf "${1%%/}.tar.gz" "${1%%/}/"; }
mktbz(){ tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

# ex - archive extractor
# usage: ex <file>
ex ()
{
    if [[ "$#" -lt 1 ]]; then
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
        return 1 #not enough args
    fi

    DESTDIR="."

    if [ -f $1 ] ; then
        case $1 in
            *.tar)
                echo -e "Extracting $1 to $DESTDIR: (uncompressed tar)"
                tar xf "$1" -C "$DESTDIR"
                ;;
            *.tar.bz2)
                echo -e "Extracting $1 to $DESTDIR: (bzip compressed tar)"
                tar xjf "$1" -C "$DESTDIR"
                ;;
            *.tar.gz)
                echo -e "Extracting $1 to $DESTDIR: (gip compressed tar)"
                tar xzf "$1" -C "$DESTDIR"
                ;;
            *.bz2)
                echo -e "Extracting $1 to $DESTDIR: (bzip compressed tar)"
                tar xjf "$1" -C "$DESTDIR"
                ;;
            *.gz)
                echo -e "Extracting $1 to $DESTDIR: (gip compressed tar)"
                tar xfz "$1" -C "$DESTDIR"
                ;;
            *.tgz)
                echo -e "Extracting $1 to $DESTDIR: (gip compressed tar)"
                tar xfz "$1" -C "$DESTDIR"
                ;;
            *.xz)
                echo -e "Extracting  $1 to $DESTDIR: (gip compressed tar)"
                tar xf -J "$1" -C "$DESTDIR"
                ;;
            *.tbz2)
                echo -e "Extracting $1 to $DESTDIR: (tbz2 compressed tar)"
                tar xjf "$1" -C "$DESTDIR"
                ;;
            *.zip)
                echo -e "Extracting $1 to $DESTDIR: (zip compressed file)"
                unzip "$1" -d "$DESTDIR"
                ;;
            *.rar)
                echo -e "Extracting $1 to $DESTDIR: (rar compressed file)"
                unrar x "$1" "$DESTDIR"
                ;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1      ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Easy extract
function q-extract
{
    if [ -f $1 ] ; then
        case $1 in
        *.tar.bz2)   tar -xvjf $1    ;;
        *.tar.gz)    tar -xvzf $1    ;;
        *.tar.xz)    tar -xvJf $1    ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       rar x $1       ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar -xvf $1     ;;
        *.tbz2)      tar -xvjf $1    ;;
        *.tgz)       tar -xvzf $1    ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# easy compress - archive wrapper
function q-compress
{
    if [ -n "$1" ] ; then
        FILE=$1
        case $FILE in
        *.tar) shift && tar -cf $FILE $* ;;
        *.tar.bz2) shift && tar -cjf $FILE $* ;;
        *.tar.xz) shift && tar -cJf $FILE $* ;;
        *.tar.gz) shift && tar -czf $FILE $* ;;
        *.tgz) shift && tar -czf $FILE $* ;;
        *.zip) shift && zip $FILE $* ;;
        *.rar) shift && rar $FILE $* ;;
        esac
    else
        echo "usage: q-compress <foo.tar.gz> ./foo ./bar"
    fi
}

function q-weather {
    local city="${1:-suzhou}"
    if [ -x "$(which wget)" ]; then
        wget -qO- "wttr.in/~${city}"
    elif [ -x "$(which curl)" ]; then
        curl "wttr.in/~${city}"
    fi
}

# View most commonly used commands. depends on your history output format
used(){
if [ $1 ]
then
    history | awk '{print $4}' | sort | uniq -c | sort -nr | head -n $1
else
    history | awk '{print $4}' | sort | uniq -c | sort -nr | head -n 10
fi
}

fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages --hidden "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, either remove the "export" as in:
    #    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    #    (or, to a custom path: NNN_TMPFILE=/tmp/.lastd)
    # or, export NNN_TMPFILE after nnn invocation
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}
