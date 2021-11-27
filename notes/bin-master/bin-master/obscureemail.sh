#!/usr/bin/env bash
#	__author__='Lilian BESSON'
#	__email__='lilian DOT besson AT normale D O T fr'
#	__version__='2.1b'
#	__date__='21/10/2013 at 02h17m'
#
# A simple script to hide email address on documents hosted on a web server.
#
version='2.1b'

# If possible, use .color.sh (http://perso.crans.org/besson/bin/.color.sh)
[ -f ~/.color.sh ] && ( . ~/.color.sh ; clear )

GREP="grep --color=always --line-buffered"

echo -e "${clear}${reset}${yellow}Starting to hide email addresses (`basename $0` v${version})${reset}\n"

for j in crans ens normale sfr hotmail laposte gmail live jarvis
do
 echo -e "${reset}${magenta}---> For the addresses ${u}*@$j$reset$white"

if [ "$1" = "all" ]; then
  echo -e "${reset}${blue}   \\---> For ${u}all file types$reset$white"
  for i in $(find . -type f -iname '*'); do
   ( GREP_COLOR="4;01;36" $GREP -I @$j "$i" ) &>/dev/null && \
   ( echo -e "${reset}${green}       \\--->$ For the file ${u}$i$reset$white"
     cat "$i" | sed s/@$j/[AT]$j/ > "$i"~ | diff "$i" "$i"~ | grep AT 2>/dev/null
     /bin/mv -vf "$i"~ "$i"
     /bin/rm -vf "$i"~ )
  done
else
 for t in html txt js doctree py sh ml c xml sty tex pl rc; do
  echo -e "${reset}${blue}   \\---> For the file type ${u}$t$reset$white"
  for i in `find . -type f -iname '*'$t`; do
   ( GREP_COLOR="4;01;36" $GREP -I @$j "$i" ) &>/dev/null && \
   ( echo -e "${reset}${green}       \\--->$ For the file ${u}$i$reset$white"
     cat "$i" | sed s/@$j/[AT]$j/ > "$i"~ | diff "$i" "$i"~ | grep AT 2>/dev/null
     /bin/mv -vf "$i"~ "$i"
     /bin/rm -vf "$i"~ )
  done
 done
fi
done
# END