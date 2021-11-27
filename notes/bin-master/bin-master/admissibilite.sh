#!/usr/bin/env bash
out="/tmp/publinet.html"
# Download the result page
wget --quiet -O "$out" "http://publinetce2.education.fr/publinet/Servlet/PublinetServlet?_concours=EAE&_page=LISTE_SECTION&_sort=CHRONO"

# state="ADMISSIBILITÉ"
state="ADMISSION"
# state2="admissibilité"
state2="admission"

# matiere="MUSIQUE"
matiere="MATHEMATIQUES"
# matiere2="musique"
matiere2="mathématiques"

# Search through it
cherche=$( cat "$out" | /usr/bin/html2text -width 613 | grep "$matiere" | grep "$state" || cat "$out" | grep "$matiere" | grep "$state" )
minicontent="$cherche"
flag=""

if [ "$cherche" != "" ]; then
    dayOut="$( echo "${cherche}" | egrep -o "[0-9]{2}/[0-9]{2}/[0-9]{4}" )"
    timeOut="$( echo "${cherche}" | egrep -o "[0-9]{2}:[0-9]{2}" )"
    content="$(echo -e "Les résultats d'${state2} pour l'agrégation de ${matiere2} sont sortis le ${dayOut} à ${timeOut} !\n\nJ'ai fouillé sur publinetce2.education.fr pour trouver : \n${cherche}\n\nAllez consulter vos résultats sur http://publinetce2.education.fr/publinet/Servlet/PublinetServlet !\nAu fait, je ne saurais être tenu responsable d'une quelconque information erronée envoyée par ce script (https://bitbucket.org/lbesson/bin/src/master/admissibilite.sh). \n\nCordialement; Lilian Besson.")"
    minicontent="Tombés ${timeOut}@${dayOut}"
    flag="[PushToTel]"

    # Construire le courriel

    # Subject: less than 16 characters are readable
    subj="${minicontent} (admissibilité pour l'agrégation de ${matiere2}) ${flag}"

    # L'envoyer
    # mail_ghost.py "${content}" "$(echo $subj)" && notify-send "Jarvis Mail Daemon : Admissibilité" "${content}"
    FreeSMS.py "${content}" "$(echo $subj)" && notify-send "Jarvis Mail Daemon : Admissibilité" "${content}"

    admissibilite_envoi_mail_thunderbird.sh

    # FIXED J'ai ajouté un code != 0 de sortie, histoire d'arrêter un "watch admissibilite.sh"
    # qui sinon continuerait indéfiniment...
    exit 1
else
    content="$(echo -e "Les résultats d'${state2} pour l'agrégation de ${matiere2} ne sont pas encore sortis !\n\nJ'ai fouillé sur publinetce2.education.fr pour trouver : \nRien :( ...\n\nAu fait, je ne saurais être tenu responsable d'une quelconque information erronée envoyée par ce script (https://bitbucket.org/lbesson/bin/src/master/admissibilite.sh). \n\nCordialement;")"
    echo -e "Content: $content"
fi

# FIN
