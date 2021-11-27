#! /bin/bash
# clear
echo -e "${white}Démonte ${u}/dev/sdb1${U} depuis ${u}/media/lilian/Disque Dur - Naereen${U}."

# On démonte
echo -e \$ sudo umount "/media/lilian/Disque Dur - Naereen"
echo -e "Besoin des droits root ? Confirmez-vous cette commande ?"
read ok
# umount "/media/lilian/Disque Dur - Naereen"
sudo umount "/media/lilian/Disque Dur - Naereen"

# On supprime le dossier qui devrait être vite !
ls -larth "/media/lilian/Disque Dur - Naereen/"
echo -e "${WARNING}: ${red} Si ce dossier n'est pas vide, il ${u}ne faut pas${U} le supprimer.${white}"
echo -e \$ sudo rm -rvi "/media/lilian/Disque Dur - Naereen"
echo -e "Besoin des droits root ? Confirmez-vous cette commande ?"
read ok
sudo rm -rvi "/media/lilian/Disque Dur - Naereen"
ls -larth "/media/lilian/Disque Dur - Naereen/"

echo -e "Utilisez DDE_mount.sh pour le remonter ${cyan}plus tard${white}."
echo -e "Appuyer la touche <Entrée> pour fermer la fenêtre..."
read touche
