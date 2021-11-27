#!/usr/bin/env /bin/bash
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Web version: http://perso.crans.org/besson/bin/caml2htmlAuto.sh
# Web version (2): https://bitbucket.org/lbesson/bin/src/master/caml2htmlAuto.sh
# Date: 11-05-2013
#
# A small script to create an HTML version of every OCaml file on the current directory
# (recursively). Works with .ml and .mli files ONLY.
# Useful to quickly "send to the web" a small OCaml project.
#

for i in $(find . -type f -iname *.ml -o -iname *.mli); do
	echo caml2html -charset utf-8 -ln -t -ie7 -tab 4 "$i"
	echo /bin/cp -vf "${i%.ml*}".html /tmp/
	echo /bin/mv -vf "$i".html "${i%.ml*}".html
done

echo -e "Sur ? [Ctrl+C si pas sur]."
read

for i in $(find . -type f -iname *.ml -o -iname *.mli); do
	caml2html -charset utf-8 -ln -t -ie7 -tab 4 "$i"
	/bin/cp -vf "${i%.ml*}".html /tmp/
	/bin/mv -vf "$i".html "${i%.ml*}".html
done
