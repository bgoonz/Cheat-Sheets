#!/usr/bin/env /bin/bash

# By Lilian BESSON
# http://perso.crans.org/besson/bin/GoingSleep_noDisplay.sh

# A try
[ -f ~/.color.sh ] && . ~/.color.sh

echo -e "${green} You want to put your machine asleep"

xtitle "Asleep :)"

user=$USER
echo -e "The user $user is asking to going asleep.\n\t I need the sudo right, please can I ?"

mail_ghost.py "Automatically send by the machine $HOSTNAME when fall asleep." "[LOG] $USER@$HOSTNAME : going asleep." &>> /tmp/mail_ghost.log
if [ "X$?" = "X0" ]
then
	echo -e "  ${green}An email have been sent (automatically) to log this action..."
else
	echo -e "  ${red}No email sent. Maybe you are not connected to a local SMTP network, or maybe there was an other problem. See /tmp/mail_ghost.log for more infos. ${white}"
fi

# Going asleep : ask sudo automatically.
sudo /etc/acpi/sleep.sh force

# Lock the terminal
vlock --current

echo -e "${blue} Back on line${white}. The computed was ${Black}${yellow}asleep${reset}${white}, using $0 script."

# DONE
