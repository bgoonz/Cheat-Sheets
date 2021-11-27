#!/usr/bin/env bash
#
# Launch this script to play Pokémon, version Jaune (yellow), gen #1
# See https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Version-Jaune
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

cd ~/publis/Pokemon-via-GitHub/fr/Version-Jaune.git && make play
