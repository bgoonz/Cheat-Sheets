#!/usr/bin/env bash
#
# __author__ = 'Lilian BESSON'
# __email__ = 'Lilian.BESSON[AT]ens-cachan[DOT]fr'
# __date__ = '18-11-2013'
#
# A first try to automatize the following process:
#  n people, add1,..pn, known with their email addresses
#  want to offer gifts to each other
#  (the email addresses are stored in the file addresses.txt
#	in the format "Surname FirstName <surname.firstname@domain.ext>" or "surname.first@domain.ext")
#  This script will send ONE email to each person, saying for who she have to find a gift.
#
# Example
# * addresses.txt:
#  <jarvis_crans.org>
#  <naereen_crans.org>
#  <besson_crans.org>
#
# * the script decides jarvis>naereen, naereen>besson, besson>jarvis
#   so the script will send an email to jarvis saying "offer a gift to naereen"
#   to naereen saying "offer a gift to besson" and so on.
#
version='1.1'
#LANG='en'

# If possible, use .color.sh (http://perso.crans.org/besson/bin/.color.sh)
[ -f ~/.color.sh ] && ( . ~/.color.sh ; clear )

GREP="grep --color=never --line-buffered"
BIN=`basename "$0"`
ECHO="echo -e"

############################# Argument handling ################################
for i in "$@"
do
 case "$i" in
 -V|--version)
   $ECHO "$BIN $version"
   exit 0
  ;;
 -h|--help)
   $ECHO "$green$BIN$white --help | [options]"
   $ECHO ""
   $ECHO "Random gift names picker."
   $ECHO "Help:"
   $ECHO "    ${yellow}--help$white           to print this help message (and quit)."
   $ECHO "    ${yellow}--version$white           to print just the version of $BIN (and quit)."
   $ECHO ""
   $ECHO "Options:"
   $ECHO ""
   $ECHO "    ${yellow}--verbose$white	 increase verbosity (not yet implemented)."
   $ECHO ""
   $ECHO "$BIN v$version : Copyrights: (c) Lilian Besson 2011-2013."
   $ECHO "Released under the term of the GPL v3 Licence (more details on http://perso.crans.org/besson/LICENSE.html)."
   $ECHO "In particular, $BIN is provided WITHOUT ANY WARANTY."
   exit 0
  ;;
 -v|--verbose)
   $ECHO "${cyan} option verbose found.${white}"
   shift
  ;;
 *)
   $ECHO "${white} Argument $i may have been NOT used.${white}" > /dev/null
   ## FIXME
  ;;
 esac
done


########################## Copyrights and options ##############################
$ECHO "${green}$BIN v$version : Copyright (C) 2013 Lilian BESSON"
$ECHO "This is free software, and you are welcome to redistribute it under certain conditions."
$ECHO "This program comes with ABSOLUTELY NO WARRANTY; for details see http://perso.crans.org/besson/LICENSE ${white}"

$ECHO "${yellow}.: Lilian BESSON presents :.$white$reset"
$ECHO "Automatic gift shuffle, v${version}.$white$reset"

#
# Check if the file is there, or use $1
#
file="$HOME/bin/addresses.txt"
add="/tmp/addresses.txt"
if [ ! -f "$file" ]; then
	file="$1"
fi
if [ -f "$add" ]; then
	mv -fv "$add" "${add}~"
fi
$ECHO "${blue}Working with the file $u$file$U${white}"
cat "$file"

cat "$file" | $GREP -o "[-_\.a-Z]*@[-a-z]*\.[a-z]*" > "$add"
$ECHO "${blue}Working with the file $u$add$U to store email addresses${white}"
cat "$add"

#
# First, try to make it work with $add, a file with just email addresse
#
add2="${add}.shuffle"
$ECHO "${blue}First try...${white}"
tab1=( $(cat "$add") )
n=`cat "$add" | wc -l`

MakeAShuffle() {
	cat "$add" | shuf > "$add2"
	# Number of line
	tab2=( $(cat "$add2") )

	for (( i = 0; i < n; i++ )); do
		#$ECHO "${tab1[i]} will find a gift for ${tab2[i]}"
		if [ "${tab1[i]}" = "${tab2[i]}" ]; then
			$ECHO "${red}Error: double found, try again...${white}" > /dev/stderr
			return 1
		fi
	done
	$ECHO "${green}A good permutation (without cycle) has been found :)${white}"
}

MakeAGoodShuffle() {
	MakeAShuffle
	ans=$?
	while [[ "$ans" = 1 ]]; do
		MakeAShuffle
		ans=$?
	done
}

MakeAGoodShuffle
tab2=( $(cat "$add2") )

FindName() {
	name1=`$GREP "$1" "$file" | $GREP -o \".*\"`
	name1=${name1:-$1}
	name1=${name1#\"}
	name1=${name1%\"}
	echo "$name1"
}

deflt=jarvis
dmin=crans.org
default=${deflt}@${dmin}

SendEmail() {
	#clear
	to=${2:-$default}
	#$ECHO "${blue}To: $to"
	#$ECHO "Content: $1${default}"
	#cat "$1"
	#read
#	cat "$1" | /usr/bin/mutt-patched  -F $HOME/.mutt/ens_nobcc.muttrc \
	cat "$1" | /usr/bin/mutt-patched  -F $HOME/.mutt/crans.muttrc \
	 -s "[Ens-agreg-a1-2014] Attribution de cadeaux de Noël !" \
	 -- $to && \
	 $ECHO "${green}Mail well sent to ${to}${white}..."
}

template=$HOME/bin/randomgifts.template.txt

for (( i = 0; i < n; i++ )); do
	add1=${tab1[i]}
	add2=${tab2[i]}

	name1=`FindName $add1`
	name2=`FindName $add2`
	#$ECHO "${magenta}$add1${white} is also called ${black}$name1${white}"
	#$ECHO "${magenta}$add2${white} is also called ${black}$name2${white}"

	#$ECHO "${black}$name1${white} will find a gift for ${black}$name2${white}"

	# Send the mail with its content on $template
	tmadd2=`tempfile`
	cat "$template" \
	| sed s/'NAME1'/"$name1"/ \
	| sed s/ADD1/"$add1"/ \
	| sed s/NAME2/"$name2"/ \
	| sed s/ADD2/"$add2"/ \
	| sed s/NBPERSONNE/"$n"/ \
	> "$tmadd2"
	SendEmail "$tmadd2" "$add1"
	rm -vf "$tmpadd2"
done

$ECHO "${yellow} .: Contact naereen[@]crans[.]org for any questions :.$reset$white"
## END ##