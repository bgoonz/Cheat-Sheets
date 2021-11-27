#!/usr/bin/env bash
#!/usr/bin/env bash
# author: Lilian BESSON
# email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# date: 15-03-2018
# web: https://bitbucket.org/lbesson/bin/src/master/random-vrun-next.sh
#
# Continuously loop 1 and 2:
#  1. Wait a random time, from a Poisson distribution of lambda = "$1" (arg#1)
#  2. and then call "vrun next" (default, or command "$2"), and quit as soon as vlc is not running anymore
#
# Licence: MIT License, https://lbesson.mit-license.org/
#

# About: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

mean_time="${1:-3}"
mean_time=$(( mean_time * 60 ))
next_command="${2:-vrun next}"

# Start the loop
echo -e "${yellow}Starting${white} '${black}${0}${white}' ..."
while true; do
    echo -e "Waiting a random time ~ 'Poisson(${magenta}${mean_time}${white})' seconds ... Then calling '${black}${next_command}${white}' ...\n"
    sleep-poisson-time.py "$mean_time"
    if pidof vlc > /dev/null; then
        $next_command
    else
        echo -e "${red}Warning, vlc appears to not be running ... quitting now.${white}"
        exit 1
    fi
done
