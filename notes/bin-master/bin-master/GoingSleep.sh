#!/usr/bin/env /bin/bash

# By Lilian BESSON
# http://perso.crans.org/besson/bin/GoingSleep.sh

# A try
[ -f ~/.color.sh ] && . ~/.color.sh

user=$USER
notify-send -i "~/.link.ico" "Locked" "The current session is going asleep... (launched by $user using $0 $*)."

echo -e "The user $user is asking to going asleep.\n\t I need the sudo right, please can I ? For the next time, if you just want to lock, type '$0 no'."

mail_ghost.py "Automatically send by the machine $HOSTNAME when fall asleep." "[LOG] $USER@$HOSTNAME : going asleep." &>> /tmp/mail_ghost.log
if [ "X$?" = "X0" ]
then
	echo -e "  ${green}An email have been sent (automatically) to log this action..."
else
	echo -e "  ${red}No email sent. Maybe you are not connected to the a local SMTP network, or maybe there was an other problem. See /tmp/mail_ghost.log for more infos. ${white}"
fi

# Going asleep : ask sudo automatically.
if [ ! "$1" = "no" ]
then
	sudo xset dpms force standby && sudo /etc/acpi/sleep.sh force 2> /dev/null
	if [ ! "W$?" = "W0" ] && [ ! "X$DISPLAY" = "X" ]
	then
		# A try
		gksudo "/etc/acpi/sleep.sh force 2> /dev/null"
		xset dpms force standby
	fi
else
	echo -e "A 'no' arg has been found, no going asleep, but locking everything...."
	xset dpms force standby
fi

# Use an already turned on GnomeScreenSaver session, to lock the screen
gnome-screensaver-command --lock

# ScreenSaver for the terminal.
cmatrix -b -f -s -u 9
clear
# Lock the terminal
if [ "X$DISPLAY" = "X" ]
then
	vlock --current
fi

notify-send --icon="~/.link.ico" "$0" "Back on line. The computer was asleep, using GoingSleep.sh script. ($0 $*)."

echo -e "${blue} Back on line${white}. The computed was ${Black}${yellow}asleep${reset}${white}, using $0 script."

# DONE
