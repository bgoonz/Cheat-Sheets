#!/usr/bin/env bash

# Experimental Bash script to run check_voyages-sncf.py as long as needed.
# to check if a train ticket on www.voyages-sncf.com is available or not.
#
# WARNING: this script is only here to play and experiment with it, and demonstrate what robobrowser can do, NOT to be ran really.
#
# Requirement:
# - RoboBrowser, http://robobrowser.readthedocs.io, pip install robobrowser
#
# - Date: Friday 27 Mai 2016.
# - Author: Lilian Besson, (C) 2016.
# - Licence: MIT Licence (http://lbesson.mit-license.org).
#

temps='30s'
date="$1"
outward="$2"
departure="$3"
villedepart="$4"
villearrive="$4"

echo -e "On va appeler 'check_voyages-sncf.py \"$date\" \"$outward\" \"$departure\" \"$villedepart\" \"$villearrive\" ' toutes les $temps ..."

check_voyages-sncf.py "$date" "$outward" "$departure" "$villedepart" "$villearrive" | tee /tmp/check_voyages-sncf.log
cat /tmp/check_voyages-sncf.log >> /tmp/check_voyages-sncf__full.log
# while [ "$?" != "0" ]; do
grep "Triste" /tmp/check_voyages-sncf.log
while [ "$?" = "0" ]; do
    sleep $temps
    check_voyages-sncf.py "$date" "$outward" "$departure" "$villedepart" "$villearrive" | tee /tmp/check_voyages-sncf.log
    cat /tmp/check_voyages-sncf.log >> /tmp/check_voyages-sncf__full.log
    grep "Triste" /tmp/check_voyages-sncf.log
done

echo -e "\n\n\nDONE DONE DONE\n"
content="J'ai trouve un train ! Pour le ${date} a l'heure ${departure}. $(tail -n2 /tmp/check_voyages-sncf.log)"
FreeSMS.py "${content}" "$(echo $subj)"

if [ -f /usr/bin/notify-send ]; then
    notify-send "check_voyage-sncf.sh : DONE" "${content}"
fi

# FIN
