#!/bin/sh
# By Lilian BESSON
# http://perso.crans.org/besson/bin/ARANDR_resolution_auto.sh
# A simple try to automatize the resizement of my screens.

if [ "$DISPLAY" = "" ]
then
	echo "** ERROR ** The value \$DISPLAY is correctly set. Maybe you are trying to run this script in a tty ?"
	echo "** ERROR ** You can either go to the tty7, or re-launch it by 'sudo service start lightdm'."
	exit 1
fi

grandr

read

simple() {
xrandr --output CRT1 --off --output LVDS --mode 1366x768 --pos 0x0 --rotate normal --output DFP1 --off
}

##xrandr --output CRT1 --mode 1280x1024 --pos 0x0 --rotate normal --output LVDS --mode 1366x768 --pos 1280x0 --rotate normal --output DFP1 --off
##xrandr --output CRT1 --mode 1280x1024 --pos 0x0 --rotate normal --output LVDS --mode 1366x768 --pos 1280x256 --rotate normal --output DFP1 --off
##xrandr --output LVDS --mode 1366x768 --pos 0x800 --rotate normal --output CRT1 --mode 1280x800 --pos 0x0 --rotate normal --output DFP1 --off
##xrandr --output LVDS --mode 1366x768 --pos 0x768 --rotate normal --output CRT1 --mode 1280x1024 --pos 0x0 --rotate normal --output DFP1 --off
dual() {
xrandr --output LVDS --mode 1366x768 --pos 1280x468 --rotate normal --output CRT1 --mode 1280x1024 --pos 0x0 --rotate normal --output DFP1 --off
}

echo "Trying to use the two screens : the LVDS (original HP's screen) and the CRT1 (new Dell scren)..."
dual
answer=$?
echo "answer = $answer"

if [ "$answer" = "0" ] || [ "$answer" = "" ]
then
	echo "The two screens seems to be well initialized."
	notify-send --icon=/home/lilian/.link.png "ARANR Resolution Auto" "The two screens seems to be well initialized."
else
	simple
	echo "The unique HP screen seems to be well initialized. Answer = $?"
	notify-send --icon=/home/lilian/.link.png "ARANR Resolution Auto" "The unique HP screen seems to be well initialized."
fi

# A try
pkill conky

Conky &> /dev/null &

echo "Conky have been relaunched."

# DONE
