#!/usr/bin/env bash
# author: Lilian BESSON
# email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# date: 19-11-2014, updated: 22-01-2021
# web: https://bitbucket.org/lbesson/bin/src/master/yeux.sh
#
# For one short moment, reduce the brightness of the screen to rest your eyes.
# Idea coming from http://askubuntu.com/a/431038
#
# Use it with a crontab, to run every 30 minutes for instance:
#    m h  dom mon dow   command
#    15 *   *   *   *     /home/lilian/bin/yeux.sh
#
# TODO do the same with standing up?
# TODO translate in English and use $LANG to change French or English? ... or write eyes.sh
#
# Licence: GPLv3 (http://perso.crans.org/besson/LICENSE.html)
#
duration=15

date > /tmp/yeux.log
echo "Repose tes yeux, pendant ${duration} secondes. Vas-y, regarde loin de ton écran, n'ai pas peur." | tee -a /tmp/yeux.log
notify-send "Repose tes yeux" "Prends ces ${duration} secondes pour bien reposer tes yeux. Regarde au loin..."

# http://redsymbol.net/articles/bash-exit-traps/
function finish {
  # Your cleanup code here
  # Should we restore to previous brightness?
  # ==> no, its not linked to the keyboard brightness keys, so restore to 1
  xrandr --output "$output" --brightness 1 | tee -a /tmp/yeux.log
}

# be sure to restore full brightness, after duration
sleep $(($duration + 5)) && finish &

# Select your screen automatically
output="LVDS"
output=$(xrandr | grep -o "^.* connected" | head -n1 | awk '{ print $1 }')
output="${output:-eDP-1}"

xrandr --output "$output" --brightness 0.3 | tee -a /tmp/yeux.log

zenity --width=350 --height=150 --info --title="Repose tes yeux" --timeout=$(($duration * 2)) --text="Prends ces ${duration} secondes pour bien reposer tes yeux. Regarde au loin..." &

sleep ${duration}s | tee -a /tmp/yeux.log

# this fails...
trap finish EXIT SIGINT SIGTERM SIGUSR1

echo "Terminé :) C'est bien, tu prends soin de tes yeux." | tee -a /tmp/yeux.log
finish
