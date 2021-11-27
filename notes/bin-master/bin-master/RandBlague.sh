#!/usr/bin/env bash
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Web version: http://perso.crans.org/besson/bin/RandBlague.sh
# Web version (2): https://bitbucket.org/lbesson/bin/src/master/RandBlague.sh
# Date: 03-02-2021
#
# A small script to do send one random joke (in English), by email, every single day !
# Requires: .blagues.txt (https://perso.crans.org/besson/bin/.blagues.txt)

sleeptime="${1:-0s}"

echo -e "Printing a random joke, after a short sleep ($sleeptime)...."
echo -e "Date:`date`. User:`whoami`. Calling $0 with time $sleeptime..." >> /tmp/randBlague.log

sleep "$sleeptime"

Blagues="$HOME/.blagues.txt"

randBlague ()
{
    if [ -f "$Blagues" ]; then
	echo -e "$Blagues is there" >> /tmp/randBlague.log;
        shuf "$Blagues" | head -n 1;
    else
        if [ -f "$HOME/motd" ]; then
	    echo -e "$HOME/motd is there" >> /tmp/randBlague.log;
            cat "$HOME/motd";
        else
            echo -e "No citation, $HOME/motd is not there, and $Blagues is not there either." >> /tmp/randBlague.log;
            echo -e "No citation, $HOME/motd is not there, and $Blagues is not there either.";
        fi;
    fi
}

if [ -f "$HOME/.link.ico" ]; then
 icon="$HOME/.link.ico";
else
 icon="info";
fi

Blague=$(randBlague)
content="<big><b>$Blague</b></big>"

echo -e "Notifying with title='Rand Blague'...."
echo -e "Notifying with content='$content'...."

zenity --title="Rand Blague" --timeout=30 \
       --width=250 --height=200 \
       --window-icon="$icon" --info \
       --display=:0.0 --text="$content"

exit 0
# END