#!/usr/bin/env bash
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Website: https://bitbucket.org/lbesson/bin/src/master/fakega.sh
# Date: 28-02-2013
#
# A small hack to generate random visit on any website which is monitored by Google Analytics.
# Specifically designed to be run on zamok:~/www/ for perso.crans.org/besson,
# but it might be useful elsewhere !
#

clear
h="localhost"
c="/"
key="UA-38514290-15"

case "$HOSTNAME" in
	*jarvis*)
		h="jarvis/"
		c="/"
		;;
	*zamok*)
		h="perso.crans.org/besson/"
		h=""
		c="${PWD#/home/besson/}"
		c="${c#www/}"
		key="UA-38514290-1"
		;;
	*ssh*)
		h="www.dptinfo.ens-cachan.fr/~lbesson/"
		c="${PWD#/import/lbesson/}"
		c="${c#public_html/}"
		key="UA-38514290-2"
		;;
	esac;

echo -e ".: Lilian Besson presents :."
echo -e "Playing with Google Analytics, v0.1"

echo -e "Working on the domain '$h' with default path '$c',"

force=no
if [ X"$1" = X"-f" ]; then
	force=yes
	shift
fi
n=`find . "$@" | wc -l`

echo -e "There is '$n' readable file(s) in the current dir, is that ok ? (it might take some time...)"
if [ X"$force" != X"yes" ]; then
	read -e -p "Continue ? [Ctrl+C to cancel now or after]"
fi

## time find . "$@" -exec curl --compressed -s -w "{} ('%{url_effective}')\n" "https://ga-beacon.appspot.com/$key/${h}${c}/{}" -o /dev/null \; 2>&1 \
## time find . "$@" -exec curl -s "https://ga-beacon.appspot.com/$key/${h}${c}/{}" -o /dev/null \; \

#time
find . "$@" -exec wget -nv "https://ga-beacon.appspot.com/$key/${h}${c}/{}" -O /dev/null \;
# \
# && echo -e "DONE :)"