#!/usr/bin/env bash
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Web version: http://perso.crans.org/besson/bin/MailExercice.sh
# Web version (2): https://bitbucket.org/lbesson/bin/src/master/MailExercice.sh
# Date: 22-03-2013
#
# A small script to do send one random Maths Exercice, by email, every single day !
# Requires: Exercice.sh (http://perso.crans.org/besson/bin/Exercice.sh)
#
# Options (order matters):
#	cron	to act as if launched with cron
# 	html	to send an HTML email instead of plain text,
#
# FIXED: use mail_html.py rather than mutt, gpg-agent is not available when launched with gnome-schedule
# Requires: Exercice.sh (http://perso.crans.org/besson/bin/mail_html.py)
#
echo -e "${clear}${yellow}.: Lilian Besson presents :."
echo -e "${cyan}Random Maths Exercice, v1.2${reset}"
#echo -e "${DISPLAY}"
( notify-send "MailExercice: starting..." ) || echo -e "${red}Fail using notify-send${white}"

# Exercice.sh télécharge l'exercice, le stocke dans /tmp/num.txt
# FIXME: PATH to Exercice.sh may change !
numexo=$( $HOME/bin/Exercice.sh --static | grep -o "numExo=[0-9][0-9]*" | grep -o "[0-9][0-9]*" )

# Destinataire par défaut
deflt=jarvis
dmin=crans.org
default=${deflt}@${dmin}

SendEmail() {
	echo -e "${reset}SendEmail have been called... Processing the arguments..."
	# MUTT="/usr/bin/mutt-patched -F $HOME/.mutt/ens_nobcc.muttrc"
	MUTT="mail_ghost.py"
	subject="[agreg-a1] Exercice #${numexo}"

	if [ X"$1" = X"--html" ]; then
		shift
		# MUTT="/usr/bin/mutt-patched -F $HOME/.mutt/ens_nobcc_html.muttrc"
		MUTT="mail_html.py"
		subject="${subject} (HTML)"
		echo -e "${red}Sending a HTML email :)"
	fi

	file="$1"
	shift
	to="${@:-$default}"

	# echo -e "${magenta}Mutt Command: $MUTT"
	echo -e "${magenta}Command used to send a mail: $MUTT 'content of the file' 'subject'"

	echo -e "${cyan}Subject: $subject"
	echo -e "${blue}To: $to"
	echo -e "${white}Content: $file${reset}"
	less -f -B -i -J -w -W -~ -K -X -u -r "$file"
	#read

	## $MUTT -s "${subject}" -- "$to" < "$file" \
	for dest in "$to"; do
		$MUTT "$(cat "${file}")" "${subject}" "$dest" \
		&& echo -e "${green}Mail well sent to ${to}${white}..."
	done
}

SendExercice() {
	## HTML (print a nice notification, rather than sending an email)
		echo -e "<big>Exercice aléatoire du jour</big> <small><a href=\"http://mp.cpgedupuydelome.fr/mesexos.php?numExo=${numexo}\">(plus de détails ici)</a></small>\n<big><tt>" > "/tmp/${numexo}.zenity.html"
		cat "/tmp/${numexo}.txt" | grep -v "^$" >> "/tmp/${numexo}.zenity.html"
		echo -e "</tt></big>\n\nVous avez 3 minutes pour le résoudre, après quoi il sera envoyé par courriel\n<small>-- \nAffiché via <tt>zenity --text</tt> et du <a href=\"https://developer.gnome.org/pygtk/stable/pango-markup-language.html\">balisage pango</a> sur <a href=\"http://jarvis.crans.org\">jarvis</a> avec <a href=\"http://perso.crans.org/besson/bin/MailExercice.sh\">MailExercice.sh</a> (script open-source)</small>\n" >> "/tmp/${numexo}.zenity.html"
		echo -e "<small><a href=\"https://bitbucket.org/lbesson/bin/issues/new\">Soumettre un bug ?</a></small>" >> "/tmp/${numexo}.zenity.html"

	## Fake a google analytics call
	wget --quiet "https://ga-beacon.appspot.com/UA-38514290-15/exo/${numexo}/$(date '+%d-%m-%Y')?pixel" -O /dev/null >/dev/null 2>/dev/null

	if [ X"$1" = X"cron" ]; then
		shift
		echo -e "${red}Launched by cron (with gnome-schedule) so not interactive.${white}"
	else
		zenity --title="MailExercice" --timeout=180 --question --text="$(cat "/tmp/${numexo}.zenity.html")"
		## Exit if user have seen and clicked on the notification
		ret=$?
		if [ $ret -eq 5 ]; then
			return 0
		fi
	fi

	if [ X"$1" = X"html" ]; then
		shift
		## HTML (send a nice email)
			echo -e "<h1>Exercice aléatoire du jour</h1><small><a href=\"http://mp.cpgedupuydelome.fr/mesexos.php?numExo=${numexo}\">(plus de détails ici)</a></small><br><pre style=\"font: large;\">" > "/tmp/${numexo}.mail.html"
			cat "/tmp/${numexo}.txt" | grep -v "^$" >> "/tmp/${numexo}.mail.html"
			echo -e "</pre><br>-- <br>Envoyé par <a href=\"http://jarvis.crans.org\">jarvis</a> avec <a href=\"http://perso.crans.org/besson/bin/MailExercice.sh\">MailExercice.sh</a> (script open-source)<br>" >> "/tmp/${numexo}.mail.html"
			## echo -e "<br><img alt=\"GA\" src=\"https://ga-beacon.appspot.com/UA-38514290-15/exo/${numexo}/$(date '+%d-%m-%Y')\" />" >> "/tmp/${numexo}.mail.html"
			echo -e "<small><a href=\"https://bitbucket.org/lbesson/bin/issues/new\">Soumettre un bug ?</a></small>" >> "/tmp/${numexo}.mail.html"
			echo -e "<br><img style=\"display: none; vibility: hidden;\" src=\"https://ga-beacon.appspot.com/UA-38514290-15/exo/${numexo}/$(date '+%d-%m-%Y')?pixel\" />" >> "/tmp/${numexo}.mail.html"

		SendEmail --html "/tmp/${numexo}.mail.html" "$@"

	else
		## PlainText
			echo -e "Exercice aléatoire du jour:\n(plus de détails ici : http://mp.cpgedupuydelome.fr/mesexos.php?numExo=${numexo})" > "/tmp/${numexo}.mail.txt"
			cat "/tmp/${numexo}.txt" >> "/tmp/${numexo}.mail.txt"
			echo -e "-- \nEnvoyé par jarvis avec MailExercice.sh\n(Script open-source: http://perso.crans.org/besson/bin/MailExercice.sh)" >> "/tmp/${numexo}.mail.txt"

		SendEmail "/tmp/${numexo}.mail.txt" "$@"
	fi
}

SendExercice "$@" && ( notify-send "MailExercice: done :)" ) || echo -e "${red}Fail using notify-send${white}"
