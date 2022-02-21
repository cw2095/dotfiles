#!/bin/sh

# In the X Window System, the X resources are parameters of computer programs such as the name of the font used in the buttons, the background color of menus, etc. 
# They are used in conjunction with or as an alternative to command line parameters and configuration files.

# Xmodmap is a utility for modifying keymaps and pointer button mappings in Xorg.

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

eval "$(dbus-launch --sh-syntax --exit-with-session)"

fcitx &

setxkbmap -option ctrl:nocaps
xcape -e 'Control_L=Escape'

if [ -x "/home/cw/bin/fastgithub" ]; then
    sudo ~/bin/fastgithub &
    export proxy="http://127.0.0.1:38457"
    export http_proxy=$proxy
    export https_proxy=$proxy
fi

greenclip daemon &

picom -b

xfce4-power-manager &

while true
do 
   feh --recursive --randomize --bg-fill ~/Pictures
   sleep 15m
done &

exec slstatus &
exec dwm
# exec jwm
