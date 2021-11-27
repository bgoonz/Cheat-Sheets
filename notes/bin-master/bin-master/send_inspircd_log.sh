#!/usr/bin/env /bin/bash
#
# A script to daily send an email with inspircd logs
# __author__='Lilian BESSON'
# __date__='30-09-2013'

# Be sure $HOSTNAME and $USER are well set
[ X"$HOSTNAME" = X ] && export HOSTNAME=`hostname`
[ X"$USER" = X ] && export USER=`whoami`

mail_ghost.py "Automatically send by the machine $HOSTNAME.crans.org for storing inspircd logs.\n/home/lilian/.local/inspircd/logs/startup.log: `tail -n200 /home/lilian/.local/inspircd/logs/startup.log`.\n/home/lilian/.local/inspircd/ircd.log: `tail -n200 /home/lilian/.local/inspircd/ircd.log`." \
 "[LOG] $USER@$HOSTNAME : inspircd logs" \
 && echo -e "Email well sent with inspircd logs." \
 && notify-send "$0" "Email well sent with inspircd logs."