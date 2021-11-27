#!/usr/bin/env bash
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Web version: http://perso.crans.org/besson/bin/GenerateStatsMarkdown.sh
# Web version (2): https://bitbucket.org/lbesson/bin/src/master/GenerateStatsMarkdown.sh
# Date: 28-03-2013
#
# A small script to create a minimalistic Markdown status page for my machine,
# available with zamok proxying at http://perso.crans.org/besson/stats.html (private ONLY)
# or locally at http://127.0.0.1/stats.html
#
# Hack: this markdown page is using http://strapdownjs.com to be a good-looking HTML page !
#
# NOTE: ssh.dptinfo.ens-cachan.fr version
#
# FIXME: zamok proxying not yet available
#
BIN=GenerateStatsMarkdown
version=1.0

# StrapDownJS nice themes : cyborg united
theme="${2:-united}"
## dest="${HOME}/Public/stats.html"
dest="${HOME}/www/dl/stats.html"

# Argument handling
case "$1" in
	amelia|cerulean|cosmo|custom|cyborg|darkly|flatly|journal|lumen|readable|shamrock|simplex|slate|spacelab|spruce|superhero|united|yeti)
		echo -e "${red}Using $1 as a theme option...${white}"
		theme="$1"
		shift
		;;
	-h|--help)
		echo -e "${green}${BIN}${white} --help | [options]\n Creates a minimalistic statistics HTML report, to ${dest}.\n It uses StrapDownJS to improve the awesomeness of this mini munin clone."
		echo -e "\nOptions:\n 1:\t${yellow}--help${white}\tto print this help,\n 1:\t${yellow}cron${white}\tto change logging behaviour (only if launched by cron),\n 1,2:\t${yellow}theme${white}\tin the list 'amelia', 'cerulean', 'cosmo', 'custom', 'cyborg', 'darkly', 'flatly', 'journal', 'lumen', 'readable', 'shamrock', 'simplex', 'slate', 'spacelab', 'spruce', 'superhero', 'united', 'yeti' (${cyan}Default and best is 'united', 'cyborg' is cool too${white}.)\n\n"
		echo -e "$BIN v$version : Copyrights: (c) Lilian Besson 2014.\nReleased under the term of the GPL v3 Licence (more details on http://perso.crans.org/besson/LICENSE.html).\nIn particular, $BIN is provided WITHOUT ANY WARANTY."
		exit 0
		;;
	*)
		;;
esac
echo -e "${yellow}.: Lilian Besson presents :."
echo -e "${cyan}${BIN}, v${version}${reset}"

theme="${theme:-united}"
echo -e "${cyan}The report will be written to : ${dest}${white}, with the theme ${magenta}${theme}${white}."
if [ -f "$dest" ]; then
	cp -vf "$dest" /tmp/
fi

# Header
echo -e "<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\"/><title>Stats pour ssh.dptinfo.ens-cachan.fr</title></head><body><xmp theme=\"${theme}\" style=\"display:none;\">" > "$dest"
echo -e "# Informations systèmes pour [ssh.dptinfo.ens-cachan.fr](http://www.dptinfo.ens-cachan.fr/~lbesson/)" >> "$dest"
echo -e "> #### Signaler tout problème à [jarvisATcransDOTorg](mailto:jarvisATcransDOTorg) ou via [bitbucket](https://bitbucket.org/lbesson/bin/issues/new).\n#### Acces restreint via mot de passe.\n#### Données mises à jour le **$(date "+%c")**.\n\n***\n" >> "$dest"

## MY_IP=$(/sbin/ifconfig | awk '/inet adr:/ { print $2 } ' | sed -e s/addr://)
MY_IP=$(/sbin/ifconfig | grep 'inet')

echo -e "## Nom de machine et version du noyau (\`uname -a\`)\n> <pre>" >> "$dest"
uname -a | sed s/"x86_64 x86_64 x86_64"/x86_64/ >> "$dest"

## echo -e "</pre>\n\n## Informations générales (\`landscape-sysinfo | head --lines=-2 | grep -v \"^$\"\`)\n> <pre>" >> "$dest"
## landscape-sysinfo | head --lines=-3 | grep -v "^$" >> "$dest"

echo -e "</pre>\n\n***\n\n## Utilisateurs connectés (\`w -h\`) *Normalement*, juste *lilian* !\n> <pre>" >> "$dest"
w -h >> "$dest"

echo -e "</pre>\n\n## Adresses IP\n> <pre>" >> "$dest"
echo ${MY_IP:-"Not connected"} >> "$dest"

echo -e "</pre>\n\n## Durée d'activité (\`uptime\`)\n> <pre>" >> "$dest"
uptime >> "$dest"

# FIXME on dptinfo22 this fails badly
## echo -e "\n\n***\n\n## Disques (\`df -kTh\`)\n> <pre>" >> "$dest"
## df -kTh >> "$dest"

echo -e "</pre>\n\n## Mémoire RAM et swap (\`free\`)\n> <pre>" >> "$dest"
free >> "$dest"

# Footer
echo -e "</pre>\n\n***\n\n##### Généré régulièrement via cron avec [GenerateStatsMarkdown.sh](http://perso.crans.org/besson/bin/GenerateStatsMarkdown.sh), un script Bash écrit par [Lilian Besson](http://perso.crans.org/besson/). Utilise [StrapDownJS](http://strapdownjs.com/) avec le thème [${theme}](http://bootswatch.com/${theme})." >> "$dest"

## FIXME add http://www.dptinfo.ens-cachan.fr/~lbesson/ before _static/
echo -e "\n</xmp><script type=\"text/javascript\" src=\"http://www.dptinfo.ens-cachan.fr/~lbesson/_static/md/strapdown.js?1\"></script>\n<img style=\"visibility: hidden; display: none;\" src=\"https://ga-beacon.appspot.com/UA-38514290-1/stats.html/theme=${theme}/?pixel\"/>\n</body></html>" >> "$dest"

# Notify the user
if [ "X$1" = "Xcron" ]; then
	echo -e "${blue}Tâche lancée via gnome-schedule.${white}"
	notify-send "GenerateStatsMarkdown.sh" "Fichier de statistiques bien généré ($dest).\n<small>(Tâche lancée via gnome-schedule)</small>"
else
	notify-send "GenerateStatsMarkdown.sh" "Fichier de statistiques bien généré ($dest)."
fi

echo -e "${green}Done !${white} (date: $(date))"
# DONE