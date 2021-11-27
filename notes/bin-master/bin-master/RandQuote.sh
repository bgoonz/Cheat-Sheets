#!/usr/bin/env bash
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Web version: http://perso.crans.org/besson/bin/RandQuote.sh
# Web version (2): https://bitbucket.org/lbesson/bin/src/master/RandQuote.sh
# Date: 10-03-2013
#
# A small script to do send one random quote, by email, every single day !
# Requires: .quotes.txt (http://perso.crans.org/besson/bin/.quotes.txt)

sleeptime="${1:-0s}"

echo -e "Printing a random quote, after a short sleep ($sleeptime)...."
echo -e "Date:`date`. User:`whoami`. Calling $0 with time $sleeptime..." >> /tmp/randquote.log

sleep "$sleeptime"

quotes="$HOME/.quotes.txt"

randquote ()
{
    if [ -f "$quotes" ]; then
	echo -e "$quotes is there" >> /tmp/randquote.log;
        shuf "$quotes" | head -n 1;
    else
        if [ -f "$HOME/motd" ]; then
	    echo -e "$HOME/motd is there" >> /tmp/randquote.log;
            cat "$HOME/motd";
        else
            echo -e "No citation, $HOME/motd is not there, and $quotes is not there either." >> /tmp/randquote.log;
            echo -e "No citation, $HOME/motd is not there, and $quotes is not there either.";
        fi;
    fi
}

if [ -f "$HOME/.link.ico" ]; then
 icon="$HOME/.link.ico";
else
 icon="info";
fi

quote=$(randquote)
content="<big><b>`echo $quote | sed s_'--'_'</b>--\n<i>'_`</i></big>"

echo -e "Notifying with title='Rand Quote'...."
echo -e "Notifying with content='$content'...."

zenity --title="Rand Quote" --timeout=30 \
       --width=200 --height=300 \
       --window-icon="$icon" --info \
       --display=:0.0 --text="$content"

exit 0
# END