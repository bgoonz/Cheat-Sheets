#!/usr/bin/env bash

# Ce script a pour but d'automatiser la création de fichier .mli


#ocamlc -i $* > /tmp/tmpgedit.mli && gedit /tmp/tmpgedit.mli

destination="/tmp/tmpgedit.mli"

if [ "$*" = "" ]
then
	exit 1
fi

for fileml in $*
do
	if [ ! -f "$fileml" ]
	then
		echo -e "$fileml : notfound"
		exit 1
	fi
done

echo "(*"
echo " * Ce fichier .mli a ete genere automatiquement par '.ocamli.sh'"
echo " *   A partir des fichiers .ml suivants : $*"
echo " *)"

echo "(*" > $destination
echo " * Ce fichier .mli a ete genere automatiquement par '.ocamli.sh'" >> $destination
echo " *   A partir des fichiers .ml suivants : $*" >> $destination
echo " *)" >> $destination

for fileml in $*
do
	echo "(* *)"
	echo "(* Signature du fichier '$fileml' *)"
	echo "(* *)"
	ocamlc -i "$fileml"

	echo "(* *)" >> $destination
	echo "(* Signature du fichier '$fileml' *)" >> $destination
	echo "(* *)" >> $destination
	ocamlc -i "$fileml" >> $destination
done

#gedit $destination &

#
#
# FIN
