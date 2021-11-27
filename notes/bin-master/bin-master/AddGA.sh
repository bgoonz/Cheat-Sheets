#!/usr/bin/env bash
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Website: https://bitbucket.org/lbesson/bin/src/master/AddGA.sh
# Date: 26-04-2016
#
# A small script to add a one-pixel beacon image to a HTML/PHP file
#
# Use it like this :
#  $ AddGA.sh "UA-946516-2" "mywebsite.com/dir/sdir/" "myfile.html"
# Where 'UA-946516-2' is the Google Analytics key for you site 'mywebsite.com'
# and if you are modifying the file 'myfile.html' in the directory 'dir/sdir/'
#
# You can force to add a beacon by passing a "-f" as the first argument :
#  $ AddGA.sh -f "UA-946516-2" "mywebsite.com/dir/sdir/" "myfile.html"
#

if [ X"$1" = "X-f" ]; then
	force=yes
	shift
else
	force=no
fi

key="$1"
c="$2"
c="${c#/}"
f="$3"
f="${f#./}"

echo -e "${black}Key:\t${key}"
echo -e "${magenta}Path:\t${c}${white}"
echo -e "File:\t$u${f}$reset"

# FIXME: maybe detect otherwise ?
if [ X"$force" != "Xyes" ] && (grep --color=always "\(https://ga-beacon.appspot.com\|http://perso.crans.org/besson/beacon\)" "${f}"); then
	echo -e "${f} already contains a Google Analytics Beacon :)" > /dev/stderr
else
	cat "${f}" \
	 | sed s%"<img alt=\"GA|Analytics\" style=\"visibility: hidden; display: none;\" src=\"https://ga-beacon.appspot.com/$key/${c}/${f}?pixel\"/>"%""% \
	 | sed s%"<noscript><img alt=\"GA|Analytics\" style=\"visibility: hidden; display: none;\" src=\"https://ga-beacon.appspot.com/$key/${c}/${f}?pixel\"/></noscript>"%""% \
	 | sed s%"</body>"%"\n<script type=\"text/javascript\" src=\"http://perso.crans.org/besson/_static/ga.js\"></script>\n<noscript><img alt=\"GA|Analytics\" style=\"visibility:hidden;display:none;\" src=\"https://ga-beacon.appspot.com/$key/${c}/${f}?pixel\"/></noscript>\n</body>"% \
	 > "${f}"~
	diff "${f}" "${f}~"
	#read
	if [ $(diff "${f}" "${f}~" | wc -l) -gt 10 ]; then
		echo -e "${red}Too many different line on $u${f}$U: I'm afraid of doing something that might be dangerous..."
	else
		cp -v "${f}" /tmp/
		mv -vf "${f}"~ "${f}"
	fi
fi
