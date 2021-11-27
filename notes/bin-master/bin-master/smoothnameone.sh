#!/usr/bin/env bash
# author: Lilian BESSON
# email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# date: 13-02-2017
# web: https://bitbucket.org/lbesson/bin/src/master/smoothnameone.sh
#
# A small script to smooth filenames in order for my scripts to work more nicely.
# You give the script some line of text, and it returns it smoothed.
#
# Example: smoothnameone.sh "J'aimerai tester voir si ça marche bien comme tu le dis @ trololo ?"
# returns J_aimerai_tester_voir_si_ca_marche_bien_comme_tu_le_dis__trololo_
#
# Licence: GPL v3
#

if [ X"$1" = X"--file" ]; then
    file=true
    shift
fi

i="$*"

# i="${i//\\n/__}"
# i="${i//\\r/__}"
i="${i// \!/}"
i="${i// \?/}"
i="${i// /_}"
i="${i//|/_}"
i="${i//_-_/__}"
i="${i//\~/_}"
i="${i//,/_}"
i="${i//+/_}"
i="${i//:/_}"
i="${i//\!/}"
i="${i//\?/}"
i="${i//é/e}"
i="${i//è/e}"
i="${i//ê/e}"
i="${i//à/a}"
i="${i//ù/u}"
i="${i//ç/c}"
i="${i//\&#39;/_}"
i="${i//\&lt;/_}"
i="${i//\&gt;/_}"
i="${i//\'/_}"
if [ X"$file" = X"true" ]; then
    i="$(echo "${i}" | tr '/' '_')"
fi
i="${i//\(/_}"
i="${i//\)/_}"
i="${i//\[/_}"
i="${i//\]/_}"
i="${i//@/}"
i="${i//\#/}"
i="${i//\&amp\;/and}"
i="${i//\&quot\;/}"
i="${i//\&/and}"
i="${i//-_ /_}"
i="${i//___/_}"
i="${i//\'/_}"
i="${i//\"/_}"

echo -e "$i" | iconv -c -s -t ascii
