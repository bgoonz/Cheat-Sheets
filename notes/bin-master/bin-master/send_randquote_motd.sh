#!/usr/bin/env /bin/bash
#
# A script to daily send an email with motd and a ranquote
# __author__='Lilian BESSON'
# __date__='30-09-2013'

# Be sure $HOSTNAME and $USER are well set
[ X"$HOSTNAME" = X ] && export HOSTNAME=`hostname`
[ X"$USER" = X ] && export USER=`whoami`

mail_ghost.py "Automatically send by the machine $HOSTNAME.crans.org for receiving a motd and a randquote... 1. /home/lilian/motd: `tail -n200 /home/lilian/motd`. 2. Ranquote: `shuf ~/.quotes.txt | head -n 1`." \
 "[LOG] $USER@$HOSTNAME : motd and randquote" \
 && echo -e "Email well sent with a motd and a randquote." \
 && notify-send "$0" "Email well sent with a mort and a randquote."