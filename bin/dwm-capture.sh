#! /bin/sh

mute=$(amixer get Capture | tail -n1 | cut -d '[' -f4 | cut -d ']' -f1)
vol=$(amixer get Capture | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')

icon="🎤"
if [ $mute = 'on' ]; then
	echo "$icon$vol%"
else
	echo "$icon off"
fi


