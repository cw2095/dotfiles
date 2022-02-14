xrdb -merge ~/.Xresources

eval "$(dbus-launch --sh-syntax --exit-with-session)"

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

fcitx &

setxkbmap -option ctrl:nocaps
xcape -e 'Control_L=Escape'

exec dwm
