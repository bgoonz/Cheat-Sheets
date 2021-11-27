#! /usr/bin/env /bin/bash
#
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date: 16-04-2020
#
# A small script to make a screenshot, designed to be assigned to a specific button or combinaison of button on Linux (XUbuntu 14+).
#

notify-send "Capture d'écran fenêtre active" "1 seconde d'attente avant la capture d'écran..."
echo -e "Waiting 1s before taking a screenshot (with xfce4-screenshooter, or gnome-screenshot)."
sleep 1s
( xfce4-screenshooter -w -d 2 || gnome-screenshot -w -d 2 ) && \
    notify-send "Capture d'écran fenêtre active" "La capture d'écran de la fenêtre active a bien été effectuée."
clear

