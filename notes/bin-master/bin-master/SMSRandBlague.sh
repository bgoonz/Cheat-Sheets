#!/usr/bin/env bash
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Web version: http://perso.crans.org/besson/bin/SMSRandBlague.sh
# Web version (2): https://bitbucket.org/lbesson/bin/src/master/SMSRandBlague.sh
# Date: 03-02-2021
#
# A small script to do send one random quote, by SMS. Can easily be automatized,
# with crontab for example. My computer is sending to myself a random quote every week ;)
#
# Requires: .blagues.txt (http://perso.crans.org/besson/bin/.blagues.txt)
# Requires: FreeSMS.py (http://perso.crans.org/besson/bin/FreeSMS.py)

echo -e "${yellow}.: Lilian Besson presents :."
echo -e "${cyan}SMSRandBlague.sh, v1.0${reset}"

blagues="${blagues:-$HOME/.blagues.txt}"
echo -e "${black}Using $blagues to look for blagues.${reset}"

function RandBlague () {
    if [ -f "$blagues" ]; then
        shuf "$blagues" | head -n 1;
    else
        if [ -f "$HOME/motd" ]; then
            cat ~/motd;
        else
            echo -e "No joke, ~/motd is not there, and \$blagues is not set.";
        fi;
    fi
}

quote="$(RandBlague)"
echo -e "${black}I will send '${cyan}${quote}${black}'' as a quote to my mobile..."
$HOME/bin/FreeSMS.py "${quote}"
