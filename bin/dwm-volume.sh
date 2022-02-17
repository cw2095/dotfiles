#! /bin/sh

mute=$(amixer get Master | tail -n1 | cut -d '[' -f4 | cut -d ']' -f1)
vol=$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')

if [ $mute = 'on' ]; then
	if [ "$vol" -gt "70" ]; then
		icon="🔊"
	elif [ "$vol" -lt "30" ]; then
		icon="🔈"
	else
		icon="🔉"
	fi
else 
	icon="🔇"
fi

echo "$icon$vol%"

