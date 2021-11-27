#!/usr/bin/env bash
# Un script pour redémarrer lightdm (en cas de bug du serveur X).
# Copyrights (C) Lilian BESSON 2013
# http://perso.crans.org/besson/bin/restart_unity.sh
# publié sous les termes de la Licence Publique GNU (GPL) version 3
# http://perso.crans.org/besson/LICENSE.html

echo "Redémarrer lightdm ?"
read -p '(oui/Non)' reponse

if [ "$reponse" != "o" ]
then
	echo -e "Exit..."
	exit 10
else
	echo -e "lightdm en cours de relancement..."
fi

sudo service ligthdm restart && (
 sleep 60;
 notify-send "`basename $0`" "Ça marche ?";
 mail_ghost.py "$0 have been called." "`basename $0`" )

echo -e "Done :)"