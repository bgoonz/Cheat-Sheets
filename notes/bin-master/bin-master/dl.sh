#!/usr/bin/env bash
#
# (C) Lilian BESSON, 2013
#
# Un script changeant au besoin, pour télécharger tous les liens
# d'un certain type d'une page web.
# Expérimental, à n'utiliser qu'en connaissance de cause !
#
# Utilisation: dl.sh URL options
# Options: -d pour debug (en premier), compress pour compresser (si PDF)
#
# Exemple: pour dumper les PDFs de dynamaths, j'ai fait:
# $ dl.sh http://agreg-cachan.fr/analyse/ compress

# Utilise http://perso.crans.org/besson/bin/.color.sh si possible.
[ -f "$HOME/.color.sh" ] && . "$HOME/.color.sh"

#wget "$1" -O /tmp/dl.html

ECHO="echo -e"
# Debug
shift
args="${@:-no}"
if [ "$1" = "-d" ]; then
 $ECHO "Debug :)"
 READ="read"
else
 $ECHO "Pas debug :) Ta confiance me réjouis ..."
 READ="echo -e"
fi

# Un exemple :
##tolookfor=`grep -o href=[^ ]*pdf /tmp/dl.html`

#tolookfor=`grep -o "href=\"[^ ]*pdf.*server=.*\">.*</a>" /tmp/dl.html | uniq | tr ' ' %20 | uniq`

tolookfor=`grep -o "href=\"[^\"]*pdf\".*</a>" /tmp/dl.html | uniq`
tolookfor=${tolookfor// /%20}

#tolookfor=`grep -o "href=.*pdf" /tmp/dl.html | uniq | tr ' ' %20 | uniq`
# | sort | uniq`

$ECHO "tolookfor=$tolookfor"
$READ

for i in $tolookfor
do
 $ECHO "i=$i"
 i=${i#href=\"}
 #i=${i#href=}
 i=${i%\"}
 $ECHO "i=$i"
 $READ

 url="$i"
 url=`$ECHO "$i" | grep -o "/wiki/[^\"]*pdf"`
 #url=${url%\"}
 #url=https://${url#http://}
 #url=${url%\">}
 url=${url//&amp;/&}
 url=http://agregatif:kchan13@agreg-cachan.fr/${url}
 # url=http://agreg.org/${url}
 # url=http://perso.ens-lyon.fr/benjamin.hellouin_de_menibus/Developpements/${url}
 # url=http://minerve.bretagne.ens-cachan.fr/images/${url}
 $ECHO "url=$url"
 $READ

 # Tente de trouver un nom de destination
 dest0=`$ECHO "$i" | grep -o ">.*</a>" | tr ' ' _`
 # dest0=`basename "$i"`
 # dest0=${dest0:-`basename "$i" | grep -o [-a-zA-Z0-9_]\+\.pdf`}
 dest0=${dest0#>}
 # dest0=${dest0//index\.php\?title=Fichier:/}
 # dest0=${dest0//_FB/}
 # dest0=${dest0//Lecon_/}
 dest0=${dest0%</a>}
 dest0=${dest0%.pdf}.pdf
 $ECHO "dest0=$dest0"
 $READ

 # Converti les caractère spéciaux en _ (au cas par cas, à adapter)
 dest0="${dest0//%20/_}"
 dest0="${dest0//_-_/_}"
 dest0="${dest0//%28/_}"
 dest0="${dest0//%C3%A8/è}"
 dest0="${dest0//%C3%A9/é}"
 dest="${dest0//%29/__}"
 $ECHO "dest=$dest"

 #$READ
 if [ -f "$dest" ]; then
  $ECHO "File $u$dest$U is already there."
 else
  $ECHO "Downloading the file $green$dest$white from ${url}..."
  wget --no-check-certificate "$url" -O "$dest" || mv -fv "$dest" /tmp/
  if [ -f "$dest" ]; then
   # Afficher le fichier (utile pour débogguer)
   #less "$dest"
   # Tente de compresser le PDF. Enlever si dl.sh récupère autre chose que des PDFs !
   a=`echo $args | grep -o compress`
   $ECHO "a=$a"
   if [ "$a" = "compress" ]; then
    $READ
    PDFCompress --no-zenity "$dest"
   fi
   $ECHO "$dest : ok"
   pdfinfo "$dest" | grep itle
  else
   $ECHO "${red}Error: file $dest not downloaded :($white"
   $READ
  fi
 fi
done

exit 0

#PDFCompress *.pdf
