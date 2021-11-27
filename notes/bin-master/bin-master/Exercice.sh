#!/usr/bin/env bash
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Web version: http://perso.crans.org/besson/bin/Exercice.sh
# Web version (2): https://bitbucket.org/lbesson/bin/src/master/Exercice.sh
# Date: 10-03-2013
#
# A small script to do one random Maths Exercice, every single day !
#
echo -e "${clear}${yellow}.: Lilian Besson presents :."
echo -e "${cyan}Random Maths Exercice, v1.2${reset}"

# Quicker if you keep this value up-to-date here
# n=$(wget -O - --quiet "http://mp.cpgedupuydelome.fr/index.php" | html2text | grep Exercice | grep -o [0-9]*)
n=5303
echo -e "${reset}Choix aléatoire parmi ${neg}${n}${Neg} exercices de maths (niveau MPSI et MP)..."

# Formule de Bill Gradwohl, merci à http://abs.traduc.org/abs-5.3-fr/ch09s06.html
# rnumber=$(((RANDOM%(max-min+divisiblePar))/divisiblePar*divisiblePar+min))
numexo=$((1+RANDOM%n))
# numexo=3095
case "$1" in
	[0-9][0-9]*)
		numexo="$1"
		echo -e "Premier argument: numéro d'exercice (${blue}${numexo}${reset})."
		shift
		;;
esac

echo -e "Numéro ${magenta}${numexo}${reset}. On va vers ${u}\"http://mp.cpgedupuydelome.fr/mesexos.php?numExo=${numexo}\"${U}${white}"

wget -O - --quiet "http://mp.cpgedupuydelome.fr/mesexos.php?numExo=${numexo}" \
 | html2markdown --ignore-links --ignore-images -b ${COLUMNS:-78} | uniq \
 | sed s_"^(\([0-9][.0-9]*\))$"_"(difficulté: \1 / 5)"_ \
 | grep -v "\(\&\|Prépas\|Accueil\)" | uniq \
 | tee "/tmp/${numexo}.txt" \
 | less -B -i -J -w -W -~ -K -X -u -r

# To use it with an other script, simply call --static and search for the exercice number
# Example: numexo=$(Exercice.sh --static | grep -o "numExo=[0-9]*" | grep -o [0-9]*)
if [ X"$1" = "X--static" ]; then
	exit
fi

# FIXME: la suite est VRAIMENT a améliorer :(
# FIXME: pas réussi à bien dumper les codes LaTeX

# | html2text -utf8 -nobs -width ${COLUMNS:-78} | uniq \
# | html2markdown --ignore-links --ignore-images -b ${COLUMNS:-78} | uniq \
# | grep -v "URL" \
# | tail -n +5 | head -n -3 \
# | html2text -utf8 -nobs | uniq \

read

echo -e "${blue}Code LaTeX de l'exercice :"
wget -O - --quiet "http://mp.cpgedupuydelome.fr/mesexos.php?idTex=${numexo}" \
 | html2text | uniq \
 | tail -n +6 | head -n -7 \
 | grep -v "\(Template\|document\)" \
 | tee "/tmp/${numexo}.tex"

less "/tmp/${numexo}.tex"

echo -e "${white}"

# firefox "http://mp.cpgedupuydelome.fr/mesexos.php?numExo=${numexo}" &>/dev/null&
elinks "http://mp.cpgedupuydelome.fr/mesexos.php?numExo=${numexo}"

echo -e "${green}Succès :)"
