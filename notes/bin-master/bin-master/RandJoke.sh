#!/usr/bin/env bash
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Web version: http://perso.crans.org/besson/bin/RandJoke.sh
# Web version (2): https://bitbucket.org/lbesson/bin/src/master/RandJoke.sh
# Date: 03-02-2021
#
# A small script to do send one random joke (in English), by email, every single day !
# Requires: .jokes.txt (https://perso.crans.org/besson/bin/.jokes.txt)
# Or uses https://github.com/15Dkatz/official_joke_api
#      or https://official-joke-api.appspot.com/jokes/random

sleeptime="${1:-0s}"

echo -e "Printing a random joke, after a short sleep ($sleeptime)...."
echo -e "Date:`date`. User:`whoami`. Calling $0 with time $sleeptime..." >> /tmp/randJoke.log

sleep "$sleeptime"

Jokes="$HOME/.Jokes.txt"

randJoke ()
{
    if [ -f "$Jokes" ]; then
	echo -e "$Jokes is there" >> /tmp/randJoke.log;
        shuf "$Jokes" | head -n 1;
    else
        python3 -c "import json,random; f=open('$HOME/.jokes.json'); line=random.choice(json.load(f)); print('<b>', line['setup'], '</b>'); print('\n<i>', line['punchline'], '</i>')" | tee -a /tmp/randJoke.log
    fi
}

if [ -f "$HOME/.link.ico" ]; then
 icon="$HOME/.link.ico";
else
 icon="info";
fi

Joke=$(randJoke)
content="<big><b>$Joke</b></big>"

echo -e "Notifying with title='Rand Joke'...."
echo -e "Notifying with content='$content'...."

zenity --title="Rand Joke" --timeout=30 \
       --width=250 --height=200 \
       --window-icon="$icon" --info \
       --display=:0.0 --text="$content"

exit 0
# END