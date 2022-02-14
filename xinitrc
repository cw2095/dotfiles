xrdb -merge ~/.Xresources

eval "$(dbus-launch --sh-syntax --exit-with-session)"

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

fcitx &

setxkbmap -option ctrl:nocaps
xcape -e 'Control_L=Escape'

if [ -x "/home/cw/bin/fastgithub" ]; then
    sudo ~/bin/fastgithub &
    export proxy="http://127.0.0.1:38457"
    export http_proxy=$proxy
    export https_proxy=$proxy
fi

picom &

exec dwm
