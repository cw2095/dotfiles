xrdb -merge ~/.Xresources
# eval $(dbus-launch --sh-syntax --exit-with-session <window_manager>)

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
eval "$(dbus-launch --sh-syntax --exit-with-session)"

# exec i3
