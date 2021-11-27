#!/usr/bin/env /bin/bash
# A graphical utility to manipulate daily the ~/motd message
# and a non graphical try (with dialog).

##########
# README #
##########
#  If you wanna to use it, you can add one of those two entries on "Start up application":
# (to set a new one each day, this work well with "echo -e \"$HOME/motd\"" in your $HOME/.bashrc !)
#   Name:		Message of the Day
#   Commande:		sleep 25; path_to_this_script/changemotd.sh --new
#   Commentary:		Change the message of the day at each new graphical connection !
#
# (to print the old one each day, and before logging out you can manually change it to your next connection)
#   Name:		Message of the Day
#   Commande:		sleep 25; path_to_this_script/changemotd.sh --display
#   Commentary:		Display the message of the day at each new graphical connection !
#
# Don't forget to ajust the "path_to_this_script" to the real value.
#

#######
#FIXME#
#######
# User interface is in french.
# TODO: Make a translation
# TODO: interface with dialog to be used in a terminal

##
ARG_all="$*"
arg1="$1"

# Colors
escp="\033["
blue="${escp}01;34m"
red="${escp}01;31m"
green="${escp}01;32m"
bright_blue="${escp}36m"
yellow="${escp}01;35m"
white="${escp}01;37m"

# echo -e "${white}"

#####################
### Create a new motd
makenew_zenity() {
	# save the ancient
	dateTD=`date "+  %d−%m - %Hh:%Mm:%Ss"`
	echo -e "\n## $dateTD daily backup of $HOME/motd" >> $HOME/.motd.backup
	cat $HOME/motd >> $HOME/.motd.backup
	old="`cat $HOME/motd`"

	echo -e "Votre ${red}vieux${white} message du jour est :"
	echo -e "${green}${old}${white}"

	# pick the new one (with Zenity)
	new=`zenity --entry --title="${USER}@${HOSTNAME} : nouveau message du jour ?" --window-icon=question --text="Renseignez un nouveau message du jour.\n\
 L'ancien est : \n<\b>${old}." --entry-text="$old $1"`
	# Erase the old one
	echo -e "$new" > $HOME/motd

	echo -e "Votre ${green}nouveau${white} message du jour est :"
	echo -e "${green}`cat $HOME/motd`${white}"
	mail_ghost.py "Automatically sent by the machine $HOSTNAME.crans.org when changing the motd. The new one is `cat $HOME/motd`." "[LOG] $USER@$HOSTNAME : new motd"

}

#####################
### Create a new motd
makenew_dialog() {
	# save the ancient
	dateTD=`date "+  %d−%m - %Hh:%Mm:%Ss"`
	echo -e "\n## $dateTD daily backup of $HOME/motd" >> $HOME/.motd.backup
	cat $HOME/motd >> $HOME/.motd.backup
	old="`cat $HOME/motd`"

	echo -e "Votre ${red}vieux${white} message du jour est :"
	echo -e "${green}${old}${white}"

	# pick the new one (with dialog)
	dialog --backtitle "Naereen CORP. (c) 23-12-2012" --title "${USER}@${HOSTNAME} : Message of the Day toolbox" --inputbox "Please, enter a *new* message of the day.\n\
 The old one is [${old}]." 0 0 "$old $1" 2> ~/motd

	echo -e "Votre ${green}nouveau${white} message du jour est :"
	echo -e "${green}`cat $HOME/motd`${white}"
	mail_ghost.py "Automatically sent by the machine $HOSTNAME.crans.org when changing the motd. The new one is `cat $HOME/motd`." "[LOG] $USER@$HOSTNAME : new motd"
}

######################
### Print the old one
printold() {
	echo -e " Votre message du jour ${green}courant${white} est :"
	echo -e "${blue}`cat $HOME/motd`${white}"
#	cat $HOME/motd
}

########################
### Display the old one
displayold() {
	zenity --info --title="${USER}@${HOSTNAME} : message du jour." --window-icon=info --text="`cat $HOME/motd`"
}

########################
### Notify the old one
notifyold() {
	notify-send --icon=info --urgency=low "${USER}@${HOSTNAME} : message du jour." "`cat $HOME/motd`"
}

#######################
### Erase the old one
eraseold() {
	echo -e "$*" > $HOME/motd
}

# Argument testing
case "$arg1" in
print*|-p*|--p*)
	printold
	;;
display*|-d*|--d*)
	displayold
	;;
new*d*|-new*d*|--new*d*|-N*d*|--N*d*)
	shift
	makenew_dialog "$*"
	;;
new*z*|-new*z*|--new*z*|-N*z*|--N*z*)
	shift
	makenew_zenity "$*"
	;;
edit|--edit)
	nano ~/motd -Y rst
	shift
	;;
notify*|-notify*|--notify**|-n*|--n*)
	notifyold
	;;
help*|-help*|--help*|*)
	printold
	echo -e "\n${red}.change_motd.sh [OPTIONS]${white}\n\
	An utility tool to operate over the __motd__ : the Message Of The Day.\n\n\
	Warning : If possible, this script use mail_ghost.py to log about the motd.\n\
${blue}OPTIONS${white}:\n\
=========\n\
	${yellow}--help${white}		Print this help (default comportement),\n\
	${yellow}--print${white} 	Print the Message of the Day,\n\
	${yellow}--display${white} 	Display the Message of the Day on a pop-up window,\n\
	${yellow}--notify${white} 	Notify the Message of the Day,\n\
	${yellow}--newd ${blue}[MESSAGE]${white}	Change the Message of the Day, starting with the value MESSAGE, using Dialog.\n\n\
	${yellow}--newz ${blue}[MESSAGE]${white}	Change the Message of the Day, starting with the value MESSAGE, using Zenity.\n\n\
${blue}COPYRIGHTS${white}:\n\
===========\n\
	 ${red}Lilian Besson (C) 01-12-2013${white}\n\
		${green}http://perso.crans.org/besson/bin/changemotd.sh"
esac
