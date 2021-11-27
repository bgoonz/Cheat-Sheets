#!/usr/bin/env bash
#
# Launch this script when leaving, so your laptop continuously sends you SMS with data about the weather.
#
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]crans[DOT]org
# Web version: http://perso.crans.org/besson/bin/when-going-out-launch-watch-and-send-SMS-continuously-weather.sh
# Web version (2): https://bitbucket.org/lbesson/bin/src/master/when-going-out-launch-watch-and-send-SMS-continuously-weather.sh
# Date: 2020-04-24 17:48
#
# $ when-going-out-launch-watch-and-send-SMS-continuously-weather.sh 15
#
# will send the current weather and weather forecast every 15 minutes
#

watch_frequency="$(("${1:-15}*60"))"
echo -e "Je surveille la maison pour toi, jeune héros.\nToutes les ${watch_frequency} minutes, je t'envoie des informations sur $(whoami)@$(hostname) par SMS"

watch --interval "${watch_frequency}" 'FreeSMS.py --sleep 300 "Météo actuelle à Rennes :\n\n$(wa_nocolor.sh "Weather in Rennes, France" | tee /tmp/when-going-out-launch-watch-and-send-SMS-continuously-weather.sh_log.txt | head -n13 | tail -n11 | head -n6)\n\nPrédiction météo :\n\n$(cat /tmp/when-going-out-launch-watch-and-send-SMS-continuously-weather.sh_log.txt | head -n13 | tail -n4)\n\n(date : $(date))"'
clear
