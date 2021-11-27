#!/usr/bin/env bash
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Web version: http://perso.crans.org/besson/bin/SMSRandQuote.sh
# Web version (2): https://bitbucket.org/lbesson/bin/src/master/SMSRandQuote.sh
# Date: 28-12-2013
#
# A small script to do send one random quote, by SMS. Can easily be automatized,
# with crontab for example. My computer is sending to myself a random quote every week ;)
#
# Requires: .quotes.txt (http://perso.crans.org/besson/bin/.quotes.txt)
# Requires: FreeSMS.py (http://perso.crans.org/besson/bin/FreeSMS.py)

echo -e "${yellow}.: Lilian Besson presents :."
echo -e "${cyan}SMSRandQuote.sh, v1.0${reset}"

quotes="${quotes:-$HOME/.quotes.txt}"
echo -e "${black}Using $quotes to look for quotes.${reset}"

function randquote () {
    if [ -f "$quotes" ]; then
        shuf "$quotes" | head -n 1;
    else
        if [ -f "$HOME/motd" ]; then
            cat ~/motd;
        else
            echo -e "No citation, ~/motd is not there, and \$quotes is not set.";
        fi;
    fi
}

quote="$(randquote)"
echo -e "${black}I will send '${cyan}${quote}${black}'' as a quote to my mobile..."
$HOME/bin/FreeSMS.py "${quote}"
