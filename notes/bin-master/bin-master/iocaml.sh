#!/usr/bin/env bash
#
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date: 08-12-2016
# Web: https://bitbucket.org/lbesson/bin/src/master/iocaml.sh
#
# A small wrapper around the output of ocaml.
# Can be save to ~/bin/iocaml for example.
#
# Licence: GPL v3
#
version='0.2'
LANG='en'

# Détection initiale: à adapter...
#ocaml=$(whereis ocaml | grep -o "/[a-zA-Z/]*bin[a-zA-Z/]*ocaml" | head -n1)
#visual="$PAGER"

# Interpréteur ocaml à utiliser (XXX changer si non standard)
# par exemple 4.0 installé ailleurs que le 3.12
# ocaml="/usr/local/bin/ocaml graphics.cma"
ocaml="ocaml graphics.cma"

# Pager à utiliser (peut être less, nano, pygmentize, emacs, vi ou ...)
visual="less -r"
# visual="/home/lilian/.local/bin/NANO -v -Y ocaml"
visual="nano -v -Y ocaml"
# visual="pygmentize -l ocaml"

# Destinations (à changer si conflit)
ml="/tmp/iocaml_$$.ml"
log="/tmp/iocaml_$$.log"

for i in "$@"; do
	echo -e "(** iOCaml copy '${i}' from '$(pwd -P)' *)" | tee "${ml}"
	cat "${i}" >> "${ml}"
	echo -e "(** iOCaml on ${i}:1:1 from '$(pwd -P)' *)" | tee "${log}"
	$ocaml < "${i}" 2>&1 | tee -a "${log}" | sed s_//toplevel//_"${i}"_
	$visual "${log}"
	# | pygmentize -l ocaml -P encoding=`file -b --mime-encoding "$i"`
done

# END
