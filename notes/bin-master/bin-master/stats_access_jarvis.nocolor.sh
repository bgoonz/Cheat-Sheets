#!/usr/bin/env bash
#
# Display IP addresses of every access to jarvis.crans.org with nginx

LOG="/var/log/nginx/access.log"
USER="besson"
HOSTNAME="zamok.crans.org"

echo -e "Looking in $LOG ..."
echo -e "`/bin/ls --color=never -larth ${LOG}`"

ret=`grep --color=never -o "[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}" "$LOG" 2>&1| uniq | sort | uniq`

for ad in $ret; do
 echo -e "Access from $ad :"
 echo -e  "            \\---> `ssh -C  -x ${USER}@${HOSTNAME} \"whos $ad | grep --color=never \\\"\(Machine\|Propriétaire\)\\\" \"`"
done

