#!/usr/bin/env /bin/bash

# By Lilian BESSON
# http://perso.crans.org/besson/bin/Battery.sh

# A bash script to access /etc/acpi (battery info) through the command line.

########
# Colors
escp="\033["
blue="${escp}01;34m"
red="${escp}01;31m"
green="${escp}01;32m"
yellow="${escp}01;35m"
white="${escp}01;37m"

########################
# Functions to work with.

# Return 'on-line' or 'off-line', if the AC Adaptater is plug in or not.
cable() {
 e=`cat /proc/acpi/ac_adapter/ACAD/state` && echo "${e:25:8}"
}

#
battery_state() {
 cat /proc/acpi/battery/BAT0/state
}

battery_info() {
 cat /proc/acpi/battery/BAT0/info
}

# Return 'open' or 'close', if the computer is open (screen visible) or not.
computer_open() {
 e=`cat /proc/acpi/button/lid/LID0/state` && echo "${e:12:5}"
}

########################
# Wrap them with colors.
cable_color() {
 e=`cable`
 if [ "$e" = "on-line" ]
 then
  echo "${green}$e${white}"
 else
  echo "${red}$e${white}"
 fi
}

computer_open_color() {
 e=`computer_open`
 if [ "$e" = "open" ]
 then
  echo "${green}$e${white}"
 else
  echo "${red}$e${white}"
 fi
}

########################
# To select good icons.
icons() {
# /usr/share/icons/gnome/256x256/status/battery.png
# /usr/share/icons/gnome/256x256/status/battery-caution.png
# /usr/share/icons/gnome/256x256/status/battery-caution-charging.png
# /usr/share/icons/gnome/256x256/status/battery-empty.png
# /usr/share/icons/gnome/256x256/status/battery-full-charged.png
# /usr/share/icons/gnome/256x256/status/battery-full-charging.png
# /usr/share/icons/gnome/256x256/status/battery-good-charged.png
# /usr/share/icons/gnome/256x256/status/battery-good-charging.png
# /usr/share/icons/gnome/256x256/status/battery-low.png
# /usr/share/icons/gnome/256x256/status/battery-low-charging.png
# /usr/share/icons/gnome/256x256/status/battery-missing.png
#echo -e "${blue} Searching for icons${white} : $*.\n\t\$1=$1"
if [ "$*" = "" ]
then
 echo "/usr/share/icons/gnome/256x256/status/battery.png"
else
 echo "/usr/share/icons/gnome/256x256/status/battery-"$1".png"
fi
}


##############################
# Using notify-send and zenity
cable_color_zen() {
 e=`cable`
 if [ "$e" = "on-line" ]; then
  echo "${green}$e${white}"
 else
  notify-send --icon=battery-caution "The AC Adaptater is *$e*." "Take care about your battery, and plug it in, before brutal die !"
  zenity --error --window-icon=`icons caution` --title="The AC Adaptater is *$e*." --text="Take care about your battery, and plug it in, before brutal die !" &
  echo "${red}$e${white}"
 fi
}

value() {
	echo -e "${green}State of the battery : \n${blue}`battery_state`${white}."
	echo -e "${green}Information about the battery : \n${blue}`battery_info`${white}."
	echo -e "The AC Adaptater is `cable_color`, and the computer is `computer_open_color`."
}

value_zen() {
	notify-send --icon=battery-good-charging "The AC Adaptater is *`cable`*." \
	 	"State of the battery : `battery_state`.\n\
		Information about the battery : `battery_info`.\n\
		The computer is `computer_open`."
}

##############################
# Uses of those functions
if [ "$*" = "" ]
then
	# No args
	echo `value_zen`
	exit 0
fi

# Argument testing
for arg in "$*"
do
	case "$arg" in
	-h|--help)
		echo -e "${red}Battery.sh [OPTIONS] [COMMAND]${white}\n\n\
A bash script to access /etc/acpi (battery info) through the command line.\n\
	All command print useful colored infos, and notify the user (use notify-send).\n\
${blue}OPTIONS${white}:\n\
=========\n\
	${yellow}-h, --help${white}	Print this help,\n\
${blue}COMMAND${white}:\n\
=========\n\
	${yellow}value${white}		Return the numerical value of the volume (as a percentage : useful with other scripts),\n\
	${yellow}notify${white}		Print and notify informations about the Main volume (value, percentage, gain, on/off),\n\
===========\n\
	${red}Lilian BESSON (C) 26-09-2013${white}\n\
	 ${green}http://perso.crans.org/besson/bin/Battery.sh${white}"
		exit 0
		;;
	value*)
		echo `value`
		exit 0
		;;
	notify*)
		echo `value_zen`
		exit 0
		;;
	*)
		echo `value`
		exit 0
		;;
	esac
done

# DONE
