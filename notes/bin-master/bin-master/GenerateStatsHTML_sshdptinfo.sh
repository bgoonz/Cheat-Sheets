#!/usr/bin/env bash
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Web version: http://perso.crans.org/besson/bin/GenerateStatsHTML.sh
# Web version (2): https://bitbucket.org/lbesson/bin/src/master/GenerateStatsHTML.sh
# Date: 26-03-2013
#
# A small script to create a minimalistic HTML status page for my machine,
# available with zamok proxying at http://perso.crans.org/besson/stats.html (private ONLY)
# or locally at http://127.0.0.1/stats.html
#
# NOTE: ssh.dptinfo.ens-cachan.fr version
#
# FIXME: zamok proxying not yet available
#
echo -e "${yellow}.: Lilian Besson presents :."
echo -e "${cyan}GenerateStatsHTML, v0.1${reset}"

dest="${HOME}/www/dl/stats.html"
echo -e "${cyan}Fichier de destination: ${dest}${white}"

# Header
echo -e "<html><head><meta charset=\"UTF-8\"><title>Stats pour ssh.dptinfo.ens-cachan.fr</title></head><body>" > "$dest"
echo -e "<h1>Informations systèmes pour <a href=\"http://www.dptinfo.ens-cachan.fr/~lbesson/\">ssh.dptinfo.ens-cachan.fr</a></h1>" >> "$dest"
echo -e "<small>Signaler tout problème à <a href=\"mailto:jarvisATcransDOTorg\">jarvisATcransDOTorg</a> ou via <a href=\"https://bitbucket.org/lbesson/bin/issues/new\">bitbucket</a>.<br>Données mises à jour le $(date "+%c").<br>Accès restreint, privé uniquement !</small><hr>" >> "$dest"

MY_IP=$(/sbin/ifconfig | grep 'inet')

echo -e "<h3>Nom de machine et version du noyau (<tt>uname -a</tt>)</h3><pre>" >> "$dest"
uname -a | sed s/"x86_64 x86_64 x86_64"/x86_64/ >> "$dest"

echo -e "</pre><hr><h3>Utilisateurs connectés (<tt>w -h</tt>)</h3><pre>" >> "$dest"
w -h >> "$dest"

echo -e "</pre><h3>Adresses IP</h3><pre>" >> "$dest"
echo ${MY_IP:-"Not connected"} >> "$dest"

echo -e "</pre><h3>Durée d'activité (<tt>uptime</tt>)</h3><pre>" >> "$dest"
uptime >> "$dest"

# FIXME on dptinfo22 this fails badly
## echo -e "</pre><hr><h3>Disques (<tt>df -h -l -t ext3 -t fuseblk</tt>)</h3><pre>" >> "$dest"
## $(df -kTh >> "$dest") || echo "df -kTh fails :("

echo -e "</pre><h3>Mémoire RAM et swap (<tt>free</tt>)</h3><pre>" >> "$dest"
free >> "$dest"

# # FIXME remove this ugly pstree -U !
# echo -e "</pre><h3>Arbre des processus (<tt>pstree -U</tt>)</h3><pre>" >> "$dest"
# pstree -U >> "$dest"

# Footer
echo -e "</pre><br><hr><footer><small>Généré régulièrement via cron avec <a href=\"http://perso.crans.org/besson/bin/GenerateStatsHTML.sh\">GenerateStatsHTML.sh</a>, un script Bash écrit par <a href=\"http://perso.crans.org/besson/\">Lilian Besson</a>.</small></footer>" >> "$dest"
echo -e "<script async type=\"text/javascript\" src=\"http://perso.crans.org/besson/_static/ga.js?s=AddGA.sh\"></script><img style=\"visibility: hidden; display: none;\" src=\"https://ga-beacon.appspot.com/UA-38514290-1/stats.html?pixel\"/></body></html>"  >> "$dest"

echo -e "${green}Done !${white} (date: $(date))"

# Notify the user
if [ "X$1" = "Xcron" ]; then
	echo -e "${blue}Tâche lancée via gnome-schedule.${white}"
	notify-send "GenerateStatsHTML.sh" "Fichier de statistiques bien généré ($dest).\n<small>(Tâche lancée via gnome-schedule)</small>"
else
	notify-send "GenerateStatsHTML.sh" "Fichier de statistiques bien généré ($dest)."
fi

# DONE