#!/usr/bin/env bash
# author: Lilian BESSON
# email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# date: 03-11-2015
# web: https://bitbucket.org/lbesson/bin/src/master/restart_volti.sh
#
# A small script to easily pkill and restart volti
# More detail at https://github.com/gen2brain/volti/issues/52
#
# Licence: GPL v3
#

# Information
echo -e "$0 launched at $(date)"
echo -e "pidof volti : $(pidof volti)"  # Fails
echo -e "pgrep volti : $(pgrep volti)"  # Works
/usr/bin/pstree -a -h -s -c -U -p | grep --color=auto volti
# Killing
i=$(pgrep volti)
echo -e "pkill volti..."
pkill volti
echo -e "kill ${i}..."
kill "$i"
# Restarting
echo -e "Restarting volti... ('volti &')"
volti &
echo -e "Done. pidof volti : $(pgrep volti)"