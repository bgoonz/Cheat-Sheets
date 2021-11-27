#!/usr/bin/env bash

# Ce script a pour but d'automatiser le renommage des fichiers, notemment pour les séries et les musiques.

#Afficher l'usage :
#echo -e "Usage : Ce script $0 va renommer les fichiers du dossier rentré en troisème argument (ou du dossier courant si il n'y a pas d'argument)."
#echo -e "        Le premier argument est la chaine de base a donner a tous les fichiers."
#echo -e "        Le second argument est l'extension des fichiers qu'on veut renommer."
#echo -e "        Si il y a un troisième argument, le système attendra les confirmations de l'utilisateur pour /*chaque*/ renommage."
#echo -e "                            En espérant avoir pu être utile, Lilian BESSON. ENS de Cachan & LSV & CMLA − 2012 © Naereen Corp."

currentdirectory=`pwd`

morceauAEnlever=""
morceauARemettre=""

if [ "$3" = "-c" ]
then
	if [ "$4" = ""]
	then
		echo -e "Erreur : l'option -c doit etre suivi d'une chaine entre \" non vide."
		exit 10
	fi
	morceauAEnlever="$4"
fi

if [ "$4" = "-c" ]
then
	morceauAEnlever="$4"
fi

dossieroutravailler=`pwd`

#Trouver le bon répertoire :
#if [ $# -le 2 ]
#then
#	dossieroutravailler=`pwd`
#else
	if [ -d "$3" ]
	then
		dossieroutravailler="$3"
		controle_un_a_un="$4"
	else
		dossieroutravailler=`pwd`
		controle_un_a_un="$3"
	fi
#fi

cd "$dossieroutravailler"

if [ "$#" = "0" ]
then
	echo -e "Je ne suis pas encore capable de deviner la chaine de base. Veuillez recommencer. Bonne journée !"
	exit 10
else
	if [ "$1" = "-h" ]
	then
		echo -e "Utilisation : $0 [-h] CHAINE EXTENSION [-i / DIRECTORY] [ -c MORCEAU]"
		echo -e "Renomme tous les fichiers du dossier courant, ou de DIRECTORY, selon le schéma CHAINE-<numero>.EXTENSION"
		echo -e "   -h			Affiche ce message d'aide."
		echo -e "   -i			Demande confirmation avant de renommer."
		echo -e "   DIRECTORY		Si présent, travaille dans le dossier cible et non dans le dossier courant."
		echo -e "   -c MORCEAU		Indique un morceau MORCEAU a supprimer a la fin du fichier."
		echo ""
		echo -e "Signaler les anomalies de «$0» à <lilian.besson[AT]ens-cachan.fr>"
		echo -e "Page d'accueil de la Naereen Corp. : <https://www.facebook.com/pages/Naereen-Corporation/288351714534562>"
	fi
	chainedebase="$1"
fi

if [ "$#" = "1" ]
then
	echo -e "Je ne suis pas encore capable de deviner l'extension de fichier. Veuillez recommencer. Bonne journée !"
	exit 10
else
	extensiondesfichiers="$2"
fi

#if [ "$#" = "2" ] && [ "$3" = "-i" ]
#then
#	controle_un_a_un=""
#else
#	controle_un_a_un="Oui"
#fi

controle_un_a_un="$3"

#Demander confirmation (version test) :
echo -e "\tLes fichiers de type <[ $extensiondesfichiers ]>\n\tdu dossier <[ $dossieroutravailler ]> vont être canoniquement renommés sur la base de\n\t<[ $chainedebase - <numero>.$extensiondesfichiers ]>.\n\tEn supprimant la chaine <[ $morceauAEnlever ]> si il est présent en fin de chaine."
read -p 'Je me lance ? (O/n)' -t 3 reponse

#Quitter si non
if [ "$reponse" = "n" ]
then
	echo -e "*** Je m'arrète donc, puisque tel est ton désir, Ô $USER. Bonne journée !"
	exit 10
else
	echo -e "Je me lance donc, puisque tel est ton désir, Ô $USER. A l'attaque des noms de fichiers hérétiques !	Processus en cours...\n"
fi

#mv -v -u <f> <nouveau_f>
n=0

#if [ "$controle_un_a_un" = "-c" ]
#then
#	morceauAEnlever="$4"
#fi

for fichierencours in *.$extensiondesfichiers
do
	((n += 1))
	reponse="n"
	echo -e "$n : J'ai trouvé le fichier <[ $fichierencours ]> qui correspond au pattern demandé."
	if [ "$controle_un_a_un" = "-i" ]
	then
		read -p 'Je le renomme ? (O/n)' -t 4 reponse
		if [ "$reponse" = "n" ] # || [ "$reponse" = "" ]
		then
			echo "Suite a une réponse négative 'n' a la dernière question, je passe ce fichier."
		fi
	else
		fichierencours="${fichierencours%$morceauAEnlever}$morceauARemettre"
	echo -e "$n : J'ai supprimer le morceau $morceauAEnlever demandé, et j'ai : <[ $fichierencours ]>."
		mv -u -v "$fichierencours" "$chainedebase - $n.$extensiondesfichiers"
	fi
done

#Finit !
cd "$currentdirectory"
echo -e "Voila qui est fait. Bonne journée !"

#####################################################################
#Par Lilian BESSON. © 2012 Naereen Corp.
#########################################################################
