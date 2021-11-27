#! /usr/bin/env /bin/bash
# clear
echo -e "${white}Monte ${u}/dev/sdb1${U} sur ${u}/media/lilian/Disque Dur - Naereen${U} avec les droits d'exécution."

# On créé le dossier cible (/!\ il doit ne pas être déjà là)
ls -larth "/media/lilian/Disque Dur - Naereen/"
echo -e "${WARNING}: ${red} Si ce dossier est déjà là et non vide, il ${u}ne faut pas${U} le créer (ie. annuler maintenant).${white}"
echo -e \$ sudo mkdir -p "/media/lilian/Disque Dur - Naereen"
echo -e "Besoin des droits root ? Confirmez-vous cette commande ?"
read ok
sudo mkdir -p "/media/lilian/Disque Dur - Naereen"
ls -larth "/media/lilian/Disque Dur - Naereen/"

# On monte
echo -e \$ sudo mount -o umask=000 /dev/sdb1 "/media/lilian/Disque Dur - Naereen"
echo -e "Besoin des droits root ? Confirmez-vous cette commande ?"
read ok
sudo mount -o umask=000 /dev/sdb1 "/media/lilian/Disque Dur - Naereen"

echo -e "Utilisez DDE_unmount.sh pour le démonter ${red}AVANT DE L'ENLEVER${white}."
echo -e "Appuyer la touche <Entrée> pour fermer la fenêtre..."
read touche
