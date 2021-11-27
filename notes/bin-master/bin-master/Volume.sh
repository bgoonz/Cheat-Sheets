#!/usr/bin/env bash
# Author: Lilian BESSON, (C) 2018-oo
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date: 01-05-2018.
# Web: https://bitbucket.org/lbesson/bin/src/master/Volume.sh
#
# A bash script to control amixer volume through the command line.
# Run '$ Volume.sh --help' to see the help.
#
# License: MIT Licence (http://lbesson.mit-license.org).

# Colors
escp="\033["
blue="${escp}01;34m"
red="${escp}01;31m"
green="${escp}01;32m"
yellow="${escp}01;35m"
white="${escp}01;37m"
[ -f ~/.color.sh ] && . ~/.color.sh

volume() {
 e=$(amixer sget -- 'Master',0 | grep 'Mono:' | grep -o '[0-9]*%')
 echo "${e}"
}

volume_value() {
 e=$(volume)
 echo "${e%\%}"
}

if [ "$*" = "" ]; then
	# Simply print the volume !
	echo -e "${green}Information about the volume : ${blue}$(amixer sget -- 'Master',0 | grep 'Mono:')${white}.\n\tVolume=${red}$(volume)${white}"
	notify-send --icon=sound "Volume.sh" "Information about the volume : $(amixer sget -- 'Master',0 | grep 'Mono:')."
	exit 0
fi

# Argument testing
for arg in "$@"; do
	case "$arg" in
	-h|--help)
		echo -e "${red}Volume.sh [OPTIONS] [COMMAND]${white}\n\n\
A bash script to control the volume (with amixer) through the command line.\n\
	All command, except for value, print useful colored infos, and notify the user (use notify-send).\n\
${blue}OPTIONS${white}:\n\
=========\n\
	${yellow}-h, --help${white}	Print this help,\n\
${blue}COMMAND${white}:\n\
=========\n\
	${yellow}value${white}		Return the numerical value of the volume (as a percentage : useful with other scripts),\n\
	${yellow}notify${white}		Print and notify informations about the Main volume (value, percentage, gain, on/off),\n\
	${yellow}up${white}		Increase the volume by 5%,\n\
	${yellow}down${white}		Decrease the volume by 5%,\n\
	${yellow}mute${white}		Mute (turn off),\n\
	${yellow}unmute${white}		Unmute (turn on) ${red} FIXME : doesn't work yet ${white},\n\
	${yellow}VALUE|PER${white}		Set the volume to VALUE, or to the percentage PER (example: 'Volume.sh 30%', or 'Volume.sh 20'),\n\
${blue}COPYRIGHTS${white}:\n\
===========\n\
	${red}Lilian BESSON (C) 11-01-2013${white}\n\
	Check out the last version online : ${green}http://perso.crans.org/besson/bin/Volume.sh${white}"
		exit 0
		;;
	value*)
		volume_value
		exit 0
		;;
	notify*)
		echo -e "${green}Information about the volume : ${blue}$(amixer sget -- 'Master',0 | grep 'Mono:')${white}.\n\tVolume=${red}$(volume)${white}"
		notify-send --icon=sound "Volume.sh" "Information about the volume : $(amixer sget -- 'Master',0 | grep 'Mono:')."
		exit 0
		;;
	mute*)
		echo -e "${green}Mutting the volume${white} (command mute)..."
		amixer sset -- 'Master',0 0% # | grep "Mono:"
		notify-send --icon=sound "Volume.sh" "Information about the volume : $(amixer sget -- 'Master',0 | grep 'Mono:') (after mutting)."
		;;
	unmute*)
		echo -e "${green}Unmutting the volume${white} (command unmute)..."
		#vol=$(volume_value)
		#amixer sset -- 'Master',0 unmute 2> /dev/null > /dev/null
		#amixer sset -- 'Master',0 on 2> /dev/null > /dev/null
		amixer sset -- 'Master',0 20% # | grep "Mono:"
#		amixer sset -- 'Master',0 -- -42.75dB | grep "Mono:"
		notify-send --icon=sound "Volume.sh" "Information about the volume : $(amixer sget -- 'Master',0 | grep 'Mono:') (after unmutting)."
		;;
	down*|-|moins*)
		vol=$(volume_value)
		newvol=$((vol-5))
		if [ "$newvol" -lt 0 ]; then
			echo -e "${red}Volume negative...${white}"
			newvol=0
		fi
		echo -e "${green}Decreasing the volume${white} by 5% ($vol -> $newvol) (command down)..."
		amixer sset -- 'Master',0 $newvol%  | grep "Mono:"
		#notify-send --icon=sound "Volume.sh" "Information about the volume : $(amixer sget -- 'Master',0 | grep 'Mono:') (after decreasing by 5%)."
		;;
	up*|+*|plus*)
		vol=$(volume_value)
		newvol=$((vol+5))
		if [ "$newvol" -gt 100 ]; then
			echo -e "${red}Volume larger than 100%...${white}"
			newvol=100
		fi
		echo -e "${green}Increasing the volume${white} by 5% ($vol -> $newvol) (command up)..."
		amixer sset -- 'Master',0 $newvol%  | grep "Mono:"
		#notify-send --icon=sound "Volume.sh" "Information about the volume : $(amixer sget -- 'Master',0 | grep 'Mono:') (after increasing by 5%)."
		;;
	*)
		echo -e "${green}Setting the volume to ${blue}$arg${white} (command PER% or VAL)..."
		amixer sset -- 'Master',0 "$arg" | grep "Mono:"
		notify-send --icon=sound "Volume.sh" "Information about the volume : $(amixer sget -- 'Master',0 | grep 'Mono:') (after running $arg)."
		;;
	esac
done

# DONE
