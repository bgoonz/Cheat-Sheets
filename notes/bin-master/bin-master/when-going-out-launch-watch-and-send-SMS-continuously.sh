#!/usr/bin/env bash
#
# Launch this script when leaving, so your laptop continuously sends you SMS with data about itself.
#
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]crans[DOT]org
# Web version: http://perso.crans.org/besson/bin/when-going-out-launch-watch-and-send-SMS-continuously-weather.sh
# Web version (2): https://bitbucket.org/lbesson/bin/src/master/when-going-out-launch-watch-and-send-SMS-continuously-weather.sh
# Date: 2020-04-24 17:48
#
# $ when-going-out-launch-watch-and-send-SMS-continuously.sh 15
#
# will send the current state of the laptop every 15 minutes
#

watch_frequency="$(("${1:-15}*60"))"
echo -e "Je surveille la maison pour toi, jeune héros.\nToutes les ${watch_frequency} minutes, je t'envoie des informations sur $(whoami)@$(hostname) par SMS"

watch --interval "${watch_frequency}" 'FreeSMS.py --sleep 300 "Utilisation actuelle de $(whoami) @ $(hostname) :\n\n$(/bin/df -h -l -t ext3 -t ext4 -t fuseblk -t vfat)\n\n$(uptime)\n\n$(free -h)\n\n(date : $(date))"'
clear
