#!/usr/bin/env bash
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Web version: http://perso.crans.org/besson/bin/SMSRandJoke.sh
# Web version (2): https://bitbucket.org/lbesson/bin/src/master/SMSRandJoke.sh
# Date: 03-02-2021
#
# A small script to do send one random quote, by SMS. Can easily be automatized,
# with crontab for example. My computer is sending to myself a random quote every week ;)
#
# Requires: .jokes.txt (http://perso.crans.org/besson/bin/.jokes.txt)
# Requires: FreeSMS.py (http://perso.crans.org/besson/bin/FreeSMS.py)

echo -e "${yellow}.: Lilian Besson presents :."
echo -e "${cyan}SMSRandJoke.sh, v1.0${reset}"

jokes="${jokes:-$HOME/.jokes.txt}"
echo -e "${black}Using $jokes to look for jokes.${reset}"

function RandJoke () {
    if [ -f "$jokes" ]; then
        shuf "$jokes" | head -n 1;
    else
        python3 -c "import json,random; f=open('$HOME/.jokes.json'); line=random.choice(json.load(f)); print(line['setup']); print(); print(line['punchline'])"
    fi
}

quote="$(RandJoke)"
echo -e "${black}I will send '${cyan}${quote}${black}'' as a quote to my mobile..."
$HOME/bin/FreeSMS.py "${quote}"
