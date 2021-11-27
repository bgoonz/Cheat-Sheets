#! /usr/bin/env bash
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Web version: http://perso.crans.org/besson/bin/GenerateStatsMarkdown.sh
# Web version (2): https://bitbucket.org/lbesson/bin/src/master/GenerateStatsMarkdown.sh
# Date: 07-01-2017
#
# A small script to create a minimalistic Markdown status page for my machine, available locally at http://0.0.0.0/stats.html
#
# Hack: this markdown page is using http://lbo.k.vu/md/ (StrapDown.js) to be a good-looking HTML page !
#
BIN=GenerateStatsMarkdown
version=1.8

# StrapDownJS nicest themes : united
theme="${2:-united}"
dest="${HOME}/Public/stats.html"

# Argument handling
case "$1" in
	bootstrap|cerulean|cosmo|cyborg|darkly|flatly|journal|lumen|paper|readable|sandstone|simplex|slate|spacelab|superhero|united|yeti)
		# cyborg|united|bootstrap|darkly|lumen|paper|simplex)
		echo -e "${red}Using $1 as a theme option...${white}"
		theme="$1"
		shift
		;;
	-h|--help)
		echo -e "${green}${BIN}${white} --help | [options]\n Creates a minimalistic statistics HTML report, to ${u}${black}${dest}${U}${white}.\n It uses ${u}${black}http://lbo.k.vu/md/${U}${white} (${cyan}StrapDown.js${white}) to improve the awesomeness of this mini munin clone."
		echo -e "\n${red}Options:${white}\n 1:\t${yellow}--help${white}\tto print this help,\n 1:\t${yellow}cron${white}\tto change logging behaviour (only if launched by cron),\n 1,2:\t${yellow}theme${white}\t${neg}bootstrap${Neg}, ${neg}cerulean${Neg}, ${neg}cosmo${Neg}, ${neg}cyborg${Neg}, ${neg}darkly${Neg}, ${neg}flatly${Neg}, ${neg}journal${Neg}, ${neg}lumen${Neg}, ${neg}paper${Neg}, ${neg}readable${Neg}, ${neg}sandstone${Neg}, ${neg}simplex${Neg}, ${neg}slate${Neg}, ${neg}spacelab${Neg}, ${neg}superhero${Neg}, ${neg}united${Neg}, ${neg}yeti${Neg} (${cyan}Default and best is ${neg}united${Neg}${white}.)\n\n"
		echo -e "${green}$BIN v$version : Copyleft: (c) Lilian Besson 2014-16.\nReleased under the term of the GPL v3 Licence (more details on http://perso.crans.org/besson/LICENSE.html).${white}\nIn particular, $BIN is provided WITHOUT ANY WARANTY."
		exit 0
		;;
	*)
		;;
esac

echo -e "${yellow}.: Lilian Besson presents :."
echo -e "${cyan}${BIN}, v${version}${reset}"

theme="${theme:-united}"
echo -e "${white}The report will be written to : ${black}${u}${dest}${U}${white}, with the theme ${magenta}${theme}${white}."
if [ -f "$dest" ]; then
	cp -vf "$dest" /tmp/
fi

# Header
hstn="$(hostname)"
echo -e "<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\"/><title>Stats pour ${hstn}</title></head><body><xmp theme=\"${theme}\">" > "$dest"
echo -e "# Informations systèmes pour [*${hstn}*](http://0.0.0.0/)" >> "$dest"
echo -e "> #### Signaler *tout problème* à [jarvis @ crans . org](mailto:jarvisATcransDOTorg) ou via [bitbucket](https://bitbucket.org/lbesson/bin/issues/new).\n> #### Données mises à jour le **$(date "+%c")**." >> "$dest"
echo -e "> #### Consulter [*les rapports munin*](http://0.0.0.0/lns_munin/localdomain/localhost.localdomain/index.html) (plus complets) ? [*les stats uLogMe*](http://localhost:8124/index.html) ? [*les stats WakaTime*](https://wakatime.com/dashboard) ?" >> "$dest"
echo -e "\n\n***\n" >> "$dest"

MY_IP=$(/sbin/ifconfig | awk '/inet adr:/ { print $2 } ' | sed -e s/addr://)

echo -e "## Nom de machine et version du noyau\n> <pre>" >> "$dest"
uname -a | sed s/"x86_64 x86_64 x86_64"/"x86_64"/ >> "$dest"

echo -e "</pre>\n\n## Informations générales\n> <pre>" >> "$dest"
landscape-sysinfo | head --lines=-3 | grep -v "^$" >> "$dest"

echo -e "</pre>\n\n***\n\n## [Utilisateurs connectés](munin/localdomain/localhost.localdomain/users.html)\n- $(w -h | wc -l) utilisateurs, $(w -h | awk '{ print $1 }' | uniq | wc -l) utilisateurs différents...\n- *Normalement*, juste *lilian* ! Liste : $(w -h | awk '{ print $1 }' | uniq)\n> <pre>" >> "$dest"
w -h >> "$dest"

echo -e "</pre>\n\n## Adresse(s) IP locale(s)\n> <pre>" >> "$dest"
echo "${MY_IP:-"Not connected"}" >> "$dest"

echo -e "</pre>\n\n## [Adresse IP externe](http://monip.org)\n> <pre>" >> "$dest"
wget --tries=5 --quiet monip.org -O - | html2text -width 50 | grep -v "^$" >> "$dest"
echo -e "</pre>\n<pre>" >> "$dest"
if type ipinfo.sh &>/dev/null; then ipinfo.sh | sed s/'^'/'- '/; else curl --silent ipinfo.io | python -m json.tool | grep -v "\(\{\|\}\)" | sed s/'"'//g | sed s/'^   '/'-'/; fi | sort >> "$dest"

echo -e "</pre>\n\n## [Météo (forecast.io)](https://forecast.io/)\n<figure>" >> "$dest"
echo -e "<iframe height='400' width='100%' style='border:none;' frameborder='0' scrolling='no' src='https://forecast.io/'><a href='https://forecast.io/'>Go see the forecast.io website.</a> Your browser seems to not be able to display a iframe tag.</iframe></figure>" >> "$dest"

echo -e "\n\n## [Statut NGinx](munin/localdomain/localhost.localdomain/index.html#nginx)\n> <pre>" >> "$dest"
if type nginx_status.sh &>/dev/null; then nginx_status.sh; fi >> "$dest"

echo -e "</pre>\n\n## [Durée d'activité](munin/localdomain/localhost.localdomain/uptime.html) - $(uptime --pretty | sed s/'up '/''/)\n> <pre>" >> "$dest"
uptime >> "$dest"

echo -e "</pre>\n\n***\n\n## [Disques locaux](munin/localdomain/localhost.localdomain/df.html)\n> <pre>" >> "$dest"
df -h -T -l -t ext3 -t ext4 -t fuseblk >> "$dest"

echo -e "</pre>\n\n## [Mémoire RAM et swap](munin/localdomain/localhost.localdomain/memory.html)\n> <pre>" >> "$dest"
free -h >> "$dest"

echo -e "</pre>\n\n## Message du jour\n> <pre>" >> "$dest"
[ -f "${HOME}"/motd ] && cat "${HOME}"/motd | grep -v '^$' >> "$dest"

echo -e "</pre>\n\n## Séries en cours\n> <pre>" >> "$dest"
[ -f "${HOME}"/current ] && head -n 3 "${HOME}"/current >> "$dest"

# Stats CUPS
echo -e "</pre>\n\n## [Documents imprimés](munin/localdomain/localhost.localdomain/printed_docs.html) aujourd'hui\n> <pre>" >> "$dest"
wget --quiet 'http://127.0.0.1:631/jobs?which_jobs=completed' -O /tmp/cups_completed_jogs_log.html
echo "- Nombre de documents : $(html2text -width 1000 /tmp/cups_completed_jogs_log.html | grep -B 1 "$(date "+%a %d %b %Y")" | grep -c "completed")" >> "$dest"
echo "- Nombre de pages : $(html2text -width 1000 /tmp/cups_completed_jogs_log.html | grep -B 1 "$(date "+%a %d %b %Y")" | grep "completed" | awk ' { print $3 }' | grep -o "[0-9]*" | python -c 'import sys; print(sum(map(int, sys.stdin)))')" >> "$dest"

# Stats uLogMe
echo -e "</pre>\n\n## Stats <a href='https://github.com/Naereen/uLogMe/'>uLogMe</a>\n" >> "$dest"
echo -e "\n- [Overview](http://localhost:8124/overview.html)" >> "$dest"
echo -e "\n- [Single-day view](http://localhost:8124/index.html)" >> "$dest"

# Links to other self-statistics
echo -e "\n\n## Autres statistiques\n" >> "$dest"
echo -e "\n- [Monitoring Workstations SCEE](http://monitoring/) & [Munin SCEE](http://ws3/)" >> "$dest"
echo -e "\n- [Suivi conso - Free Mobile](https://mobile.free.fr/moncompte/index.php?page=suiviconso)" >> "$dest"
echo -e "\n- [Google Analytics](https://www.google.com/analytics/web/#home/a38514290w67185072p69122598/)" >> "$dest"
echo -e "\n- [Google URL Shortener (goo.gl)](https://goo.gl/)" >> "$dest"
echo -e "\n- [Bitbucket activity](https://bitbucket.org/lbesson/profile/repositories)" >> "$dest"
echo -e "\n- [GitHub activity](https://github.com/Naereen?tab=activity)" >> "$dest"

# XXX Links to local self-statistics, need https://addons.mozilla.org/firefox/addon/281
echo -e "\n\n## Statistiques locales\n" >> "$dest"
echo -e "\n- <a href='resource://jid0-hynmqxa9zqgfjadreri4n2ahksi-at-jetpack/data/index.html' target='_blank'>Mind the Time</a> (Firefox browsing, local data)" >> "$dest"  # XXX resource:// link does not work from http(s?):// pages
# echo -e "\n- <a href='file:///home/lilian/Public/stats.html' target='_blank'>Local version of this stats.html file</a>" >> "$dest"  # XXX file:// link does not work from http(s?):// pages

# Stats WakaTime.
echo -e "\n\n## Stats <a href='https://wakatime.com/dashboard'>WakaTime</a>\n" >> "$dest"
# wakatime.js -w >> "$dest"  # DEBUG that's not working!
# mywakatime -w >> "$dest"   # DEBUG that's not working!
echo -e "\n<figure><embed style='text_align:center;margin-left:auto;margin-right:auto;' width='680' type='image/svg+xml' src='https://wakatime.com/@lbesson/5d1ec603-73b0-44b9-b61e-5eeda2490e51.svg'></embed></figure>" >> "$dest"
echo -e "\n<figure><embed style='text_align:center;margin-left:auto;margin-right:auto;' width='680' type='image/svg+xml' src='https://wakatime.com/@lbesson/9f6c0b0b-6806-4afa-9a4e-651ee6201be0.svg'></embed></figure>" >> "$dest"

# XXX it was costing too much CPU time
# Optionnal Selfspy visualisation (selfstats, selfspy-vis, cf. https://github.com/Naereen/selfspy-vis))
#type selfstats >/dev/null
#if [ "X$?" = "X0" ]; then
#	echo -e "\n\n## <a href='http://jarvis/selfvis.html'>Ratio clicks/keystrokes</a> (\`selfstats --human-readable --ratios\`)\n> <pre>" >> "$dest"
#	selfstats --human-readable --ratios | sed '/^$/d' >> "$dest"
#
#	echo -e "</pre>\n\n## <a href='http://jarvis/selfvis.html'>Summary of clicks</a> (\`selfstats --human-readable --clicks\`)\n> <pre>" >> "$dest"
#	selfstats --human-readable --clicks | sed '/^$/d' >> "$dest"
#
#	echo -e "</pre>\n\n## <a href='http://jarvis/selfvis.html'>Stats</a> <a href='https://github.com/gurgeh/selfspy#example-statistics'>selfspy</a> (\`selfstats --min-keys 10 --back 1w --human-readable --pactive\`)\n> <pre>" >> "$dest"
#	selfstats --min-keys 10 --back 1w --human-readable --pactive | sed '/^$/d' >> "$dest"
#fi

# Footer
if [ "X$1" = "Xcron" ]; then
	echo -e "</pre>\n\n***\n\n##### Mis-à-jour régulièrement via *cron*, avec [GenerateStatsMarkdown.sh](http://perso.crans.org/besson/bin/GenerateStatsMarkdown.sh) v${version}, un script Bash, [open-source](https://lbesson.mit-license.org/), écrit par et pour [Lilian Besson](http://perso.crans.org/besson/)." >> "$dest"
else
	echo -e "</pre>\n\n***\n\n##### Généré avec [GenerateStatsMarkdown.sh](http://perso.crans.org/besson/bin/GenerateStatsMarkdown.sh) v${version}, un script Bash, [open-source](https://lbesson.mit-license.org/), écrit par et pour [Lilian Besson](http://perso.crans.org/besson/)." >> "$dest"
fi

# XXX add http://perso.crans.org/besson/ before _static/
echo -e "\n</xmp><script type=\"text/javascript\" src=\"_static/md/strapdown.min.js?src=GSM.sh\"></script>\n<noscript><img alt=\"GA|Analytics\" style=\"visibility: hidden; display: none;\" src=\"https://ga-beacon.appspot.com/UA-38514290-1/stats.html/theme_${theme}/?pixel\"/></noscript>\n</body></html>" >> "$dest"


# Notify the user
if [ "X$1" = "Xcron" ]; then
	echo -e "${blue}Tâche lancée via gnome-schedule ou cron ou crontab.${white}"
	notify-send "GenerateStatsMarkdown.sh" "Fichier de statistiques bien généré (<i>$dest</i>).\n<small>(Tâche lancée via gnome-schedule ou cron ou crontab)</small>"
else
	notify-send "GenerateStatsMarkdown.sh" "Fichier de statistiques bien généré (<i>$dest</i>)."
fi

echo -e "${green}Done !${white} (date: $(date))"
# DONE
