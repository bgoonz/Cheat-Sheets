#!/usr/bin/env bash
#
# __author__ = 'Lilian BESSON'
# __email__ = 'Lilian.BESSON[AT]ens-cachan[DOT]fr'
# __date__ = '21-01-2014'
#
# A small wrapper to automatically produces SVG and PDF graphics
# from a CSV files (which contains notes between 0 and 20).
#
version='.1'
# LANG='en'

datef=$(basename `pwd -P`)

echo -e "${reset}notes.sh: working in $u$black$datef$reset"
echo -e "I found \n${red}`ls ${datef}*e ${datef}*pdf ${datef}*svg ${datef}*asc *~ 2>/dev/null`${white}"
rm -vf ${datef}*e ${datef}*pdf ${datef}*svg ${datef}*asc *~

gpg --armor --detach-sign --yes --no-batch --use-agent "${datef}_notes.csv"

plotnotes.py "${datef}_notes.csv"
## && svg2others.sh "${datef}_notes.svg"

CP "${datef}"_notes.pdf "${datef}"_notes.*e /tmp/
# read

# cp "${datef}.tex" "${datef}.tex~"

echo -e "I read: ${datef}_notes.moyenne : `cat ${datef}_notes.moyenne` : using it :)"
echo -e "I read: ${datef}_notes.minimale : `cat ${datef}_notes.minimale` : using it :)"
echo -e "I read: ${datef}_notes.argminimale : `cat ${datef}_notes.argminimale` : using it :)"
echo -e "I read: ${datef}_notes.maximale : `cat ${datef}_notes.maximale` : using it :)"
echo -e "I read: ${datef}_notes.argmaximale : `cat ${datef}_notes.argmaximale` : using it :)"
echo -e "I read: ${datef}_notes.ecarttype : `cat ${datef}_notes.ecarttype` : using it :)"
echo -e "I read: ${datef}_notes.variance : `cat ${datef}_notes.variance` : using it :)"
echo -e "I read: ${datef}_notes.table : `cat ${datef}_notes.table` : using it :)"
# read

# cat "${datef}.tex" \
#  | sed s/MOYENNE/`cat ${datef}_notes.moyenne`/ \
#  | sed s/MINIMALE/`cat ${datef}_notes.minimale`/ \
#  | sed s/MAXIMALE/`cat ${datef}_notes.maximale`/ \
#  | sed s/ECARTTYPE/`cat ${datef}_notes.ecarttype`/ \
#  | sed s/VARIANCE/`cat ${datef}_notes.variance`/ \
#  # | sed s/TABLE/`cat ${datef}_notes.table`/ \
#  > "${datef}.tex~"

autotex "${datef}.tex"

# mv -vf "${datef}.pdf~" "${datef}.pdf"
# read

if [ -f "${datef}.pdf" ]; then
	PDFCompress --sign "${datef}.pdf"
	echo -e "${green}SUCCESS:${white} ${datef}.pdf well produced :)"
	for i in ${datef}*e ; do
		echo -e "$i : `cat $i`"
	done
else
	echo -e "${red}ERROR:${white} ${datef}.pdf not produced :("
fi