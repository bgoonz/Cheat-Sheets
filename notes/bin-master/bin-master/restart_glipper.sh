#!/usr/bin/env bash
# author: Lilian BESSON
# email: Lilian.BESSON[AT]crans[DOT]org
# date: 23-01-2018
# web: https://bitbucket.org/lbesson/bin/src/master/restart_glipper.sh
#
# A small script to easily pkill and restart glipper
#
# Licence: GPL v3
#

# Information
echo -e "$0 launched at $(date)"
echo -e "pidof glipper : $(pidof glipper)"  # Fails
echo -e "pgrep glipper : $(pgrep glipper)"  # Works
/usr/bin/pstree -a -h -s -c -U -p | grep --color=auto glipper
# Killing
i=$(pgrep glipper)
echo -e "pkill glipper..."
pkill glipper
echo -e "kill ${i}..."
kill "$i"
# Restarting
echo -e "Restarting glipper... ('glipper &')"
glipper &
echo -e "Done. pidof glipper : $(pgrep glipper)"
