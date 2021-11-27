#!/usr/bin/env bash
#
# __author__ = 'Lilian BESSON'
# __email__ = 'Lilian.BESSON[AT]ens-cachan[DOT]fr'
# __date__ = '31-08-2013'
#
# A first try to automatically create a quotes.txt with all Kaamelott citations
# from https://fr.wikiquote.org/wiki/*
#
# Find the more recent version here
# http://perso.crans.org/besson/bin/quotes.sh
#
version='0.1'

# en -> https://en.wikiquote.org/wiki/
# LANG='en'
# fr -> https://fr.wikiquote.org/wiki/
LANG='fr'

# If possible, use .color.sh (http://perso.crans.org/besson/bin/.color.sh)
[ -f ~/.color.sh ] && . ~/.color.sh

#
# Starting....
#
echo -e "${yellow}.: Lilian Besson presents :.$white$reset"
echo -e "Automatic quotes.txt generator, v${version}.$white$reset"

output="quotes.txt"
[ -f "$output" ] && ( echo -e "File $output already there, moving to /tmp/"; mv "$output" "/tmp/quotes_`date \"+%d_%M__%H_%m_%S\"`.txt" )

# One target
target="$1"

tg="/tmp/$target.html"
wget "https://fr.wikiquote.org/wiki/$target" -O "$tg"

# All sub targets
subtargets=`grep recueil "$tg" | grep -o "$target"[^\ ]*\" | uniq | sed s/\"//`

echo -e "The target $target gave these sub targets:"
echo -e "$subtargets"

echo pause
read

#for l in Kaamelott Kaamelott/Arthur Kaamelott/Loth Kaamelott/Gauvain Kaamelott/Kadoc
for l in "$target" $subtargets
do
 echo -e "For file $l..."

# for i in `seq 1 1000`; do
#  out="/tmp/quote_${l//'/'/'_'}_${i}.txt"

  out="/tmp/quote_${l//'/'/_}_${i}.txt"
  quotes.sh -o "$out" -q -a "$l"

#  quotes.sh -o /tmp/quote_$l_$i.txt -q -n $i "$l" >/dev/null \
#  || break

   cat "$out" | sed s/@/\n/ >> "$output"
   cat "$out" >> "$output"
   wc "$output"

# done

done