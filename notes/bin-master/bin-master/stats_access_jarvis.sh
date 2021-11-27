#!/usr/bin/env /bin/bash
#
# Display IP addresses of every access to jarvis.crans.org with nginx

[ -x ~/.color.sh ] && . ~/.color.sh ## http://perso.crans.org/besson/bin/.color.sh

LOG="/var/log/nginx/access.log"
USER="besson"
HOSTNAME="zamok.crans.org"

echo -e "${white}Looking in $u$LOG$U ...${reset}"
echo -e "`/bin/ls --color=auto -larth ${LOG}`"

ret=`grep --color=never -o "[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}" "$LOG" 2>&1| uniq | sort | uniq`

for ad in $ret; do
 echo -e "${green}Access from ${white}${u}$ad${U} :"
 echo -e  "${cyan}            \\---> ${reset}`ssh -C  -x ${USER}@${HOSTNAME} \"whos $ad | grep --color=always \\\"\(Machine\|Propriétaire\)\\\" \"`$white"
done

