#!/usr/bin/env /bin/bash
#
# A script to daily send an email with nginx access data
# __author__='Lilian BESSON'
# __date__='30-09-2013'

# Be sure $HOSTNAME and $USER are well set
[ X"$HOSTNAME" = X ] && export HOSTNAME=`hostname`
[ X"$USER" = X ] && export USER=`whoami`

mail_ghost.py "Automatically send by the machine $HOSTNAME.crans.org for storing nginx logs about whos accessed to the server.\nDifferent accesses:`stats_access_jarvis.nocolor.sh`." \
 "[LOG] ${USER}@${HOSTNAME} : nginx logs" \
 && echo -e "Email well sent with nginx logs about who accessed to the server." \
 && notify-send "$0" "Email well sent with logs about who accessed to the server."