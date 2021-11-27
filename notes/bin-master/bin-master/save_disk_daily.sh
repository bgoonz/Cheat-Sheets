#!/usr/bin/env bash
#
# Un script pour sauver facilement ses données.
# Il est conçu pour être utilisé sur Ubuntu (10.04+), installé sur Windows via WUBI
#
# Écrit par Lilian Besson (C)
# https://bitbucket.org/lbesson/bin/src/master/save_disk_daily.sh
# v3.2 04-05-2016
# MIT Licensed (http://lbesson.mit-license.org/)

message=$(date "+%d-%m, et il est %Hh:%Mm-%Ss")
echo "$USER, vous avez demandé une sauvegarde de votre installation d'Ubuntu, nous sommes le $message."

directory_to_save="/host/ubuntu/disks/"
# TODO : choisir ICI son disque dur externe !

directory_where_save="/media/lilian/Disque Dur - Naereen/.SAVE/Save_disks_$(date +%d_%m_%y)/"
# directory_where_save="/media/lilian/Elements/save_jarvis/save_disks_$(date +%d_%m_%y)/"

echo -e "La sauvegarde va commencer entre le répertoire : \n $directory_to_save\n et le répertoire situé sur votre DDE :\n$directory_where_save"

read -p "[o]ui/[N]ON ? " ok

case "$ok" in
       Non*|""|non*)
          echo -e "$ok : réponse négative. Ciao !"
          exit 1
       ;;
       *)
          echo -e "$ok : réponse positive. Je me lance : en utilisant rsync pour vous informer de l'avancée de la sauvegarde en 'temps réel'"
       ;;
esac

# CP="cp -vi"
CP="/usr/bin/rsync --verbose --human-readable --progress --archive"

time $CP -r "$directory_to_save" "$directory_where_save" && \
	notify-send --urgency=critical --icon=alert "Sauvegarde" "Sauvegarde de votre installation d'Ubuntu effectuée, dans le dossier $directory_where_save."

# DONE