#!/bin/bash
# .bash_aliases for GNU Bash v4+
# (c) 2011-2021 Lilian BESSON
# GPLv3 Licensed
# Cr@ns: https://perso.crans.org/besson
# On Bitbucket:   https://bitbucket.org/lbesson/bin/

# A try with erase line.
function LS_ECHO() {
    printf " ${blue}${u} Listing${reset} \$*..."
    sleep 0.5
    printf "${el}..."
    for i in "$@"; do
        printf "${green}$i${reset}..."
        sleep 0.05
        printf "${el}..."
    done
    printf "${red}Done !${reset}"
}
# Commandes mv :
alias mv='/bin/mv -i'

# Commandes ls avec diverses options :
# The 'ls' family (this assumes you use the GNU ls)
alias sl='ls'

function la() {
    arg=$(history | tail -n1 | sed s/'^.*la '/''/)
    if [[ X"$@" = X ]]; then
        echo -e "Contenu du dossier $reset${u}$(pwd)$U$white ${magenta}[option -A]$white"
    else
        echo -e "Liste des fichiers pour $reset$u$arg$U$white ${magenta}[option -A]$white"
    fi
    /bin/ls --color=auto -A "$@"
}
function l() {
    arg="$(history | tail -n1 | sed s/'^.*l '/''/)"
    if [[ X"$@" = X ]]; then
        echo -e "Contenu du dossier $reset${u}$(pwd)$U$white ${magenta}[option -hCF]$white"
    else
        echo -e "Liste des fichiers pour $reset$u$arg$U$white ${magenta}[option -hCF]$white"
    fi
    /bin/ls --color=auto -hCF "$@"
}
function lnc() {
    arg="$(history | tail -n1 | sed s/'^.*l '/''/)"
    if [[ X"$@" = X ]]; then
        echo -e "Contenu du dossier $(pwd) [option -hCF]"
    else
        echo -e "Liste des fichiers pour $arg [option -hCF]"
    fi
    /bin/ls --color=never -hCF "$@"
}

alias lD='find . -maxdepth 1 -type d | sort'  # To print directory
alias ll='/bin/ls --color=auto -larth'        # all in the current dir
alias lsnocolor='/bin/ls --color=no'          # the lnc function is better
alias lt='/bin/ls --color=auto -lSrha'        # print all, sorted by size
alias lx='/bin/ls --color=auto -lXB'          # sort by extension
alias lk='/bin/ls --color=auto -lSr'          # sort by size
alias lc='/bin/ls --color=auto -lcr'          # sort by change time
alias lu='/bin/ls --color=auto -lur'          # sort by access time
alias lr='/bin/ls --color=auto -lR'           # recursive ls
alias lm='/bin/ls --color=auto -al | less'    # pipe through 'more'
alias tree='tree -Csuh'                       # nice alternative to 'ls'

# Shortcuts on cp
alias cp='/bin/cp -iv'
alias h='history'
alias which='type -all'
alias ..='cd ..'
alias .1='cd ..'
alias ...='cd ../..'
alias ....='cd ../..'
alias .2='cd ../..'
alias .....='cd ../../..'
alias .3='cd ../../..'
alias ......='cd ../../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias .6='cd ../../../../../..'
alias path='echo -e ${PATH//:/\\n}'
function up() { DEEP=$1; cd "$(python -c "print('../'*${DEEP})")"; }

# Commande dut : 'du' Trie. dush : total du dossier courant.
alias dut='/usr/bin/du -kx | egrep -v "\./.+/" | sort -n'
alias dush='/usr/bin/du -sh'
alias du='/usr/bin/du -khc'
alias df='/bin/df -h -l -t ext3 -t ext4 -t fuseblk -t vfat'
alias free='/usr/bin/free -h'

# Commandes avec GNU-Nano :
alias nano='xtitle "($(date)<$USER@$HOSTNAME>:[$(pwd)]> { GNU Nano 2.9.3 (/bin/nano) }" ; /bin/nano --tabsize=8 --softwrap --suspend --const --boldtext --multibuffer  --preserve --backup --historylog --nonewlines --quickblank --wordbounds'

alias MAKE="/usr/bin/make -w"
# alias make='mymake.sh'

# XXX Experimental function that adds shortcuts :
# If 'make foo' worked, then 'alias foo="make foo"' is added to the CURRENT bash session
# I got the idea on Saturday 27-08-16 at Lausanne, and I find it pretty awesome
function make() {
    mymake.sh "$@"
    returncode="$?"
    if [ X"${returncode}" = X"0" -a X"${#@}" = X"1" -a X"${1:0:1}" != X"-" ]; then
        # XXX We only add an alias for make commands with one argument, to avoid capturing the options
        if alias -p | grep -o "^alias $1='mymake.sh $1'$" &>/dev/null; then
            echo -e "The previous make command ('${black}make ${1}${white}') ${green}worked${white}, but ${blue}${1}${white} has already been aliased : ${green}nothing to do :-)${white}\n(mymake.sh does not override existing aliases...)"
        else
            echo -e "The previous make command ('${black}make ${1}${white}') ${green}worked${white}, and ${blue}${1}${white} has not been aliased yet..."
            alias $1="mymake.sh $1"
            echo -e "  '${blue}${1}${white}' is now registered as a ${yellow}new alias${white} for '${black}make ${1}${white}' ..."
        fi
    fi
    # Cf. https://stackoverflow.com/questions/10448160/ddg#10457902
    if [ X"${returncode}" = X"0" ]; then
        echo  # empty line, does nothing
    else
        ( exit "${returncode}" )  # propagate the 'make' error code
    fi
}

# Ajout de securite sur la commande 'rm' :
alias delete='echo -e "Supression avec une seule confirmation ?"; /bin/rm -I'
alias rm='/bin/rm -vi'

alias _cd_old='cd'  # Does not work
function CD() {
    p="$(pwd)"
    p2="$(pwd -P)"
    if [ "X$@" = "X" ]
    then
        args="$HOME"
    else
        args="$*"
    fi
    if [ "X$p" = "X$p2" ]
    then
        echo -e "Vous ${yellow}quittez${white} le dossier ${blue}'$p'${white}.\n\tDirection ==> ${green}$args${white}"
        _cd_old "$args"
    else
        echo -e "Vous ${red}quittez${white} le dossier ${yellow}'$p'${white}.\n\t/!\\ Chemin ${red}relatif${white}, car le vrai est ${blue}'$p2'${white}.\n\tDirection ==> ${green}$args${white}"
        _cd_old "$args"
    fi
}

# Magie noire
alias cd..="CD .."
alias cdBack='CD "${OLDPWD:=$PWD}"'  # Nul : cd - fait la même chose !
alias -- -='cd -'  # Cf. http://askubuntu.com/a/146034/
alias cdP='cd "$(pwd -P)"'
alias cd="CD"

# ----------------------------------------------------------------------
# Options for a better cd command, cf. https://github.com/mrzool/bash-sensible#sensible-bash

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
# CDPATH=".:~/publis/:~/ownCloud/cloud.openmailbox.org/"

# Commandes avec SSH :
#alias ssh='/usr/bin/ssh -X -C'  # don't send X server, see http://www.hackinglinuxexposed.com/articles/20040705.html
alias ssh='/usr/bin/ssh -C'

# Des commandes auxquelles on rajoute des messages inutiles :
function mkdir() {
    echo -e "Le système va essayer de créer le dossier $*..."
    /bin/mkdir -p "$@"
}

# Une commande geek pour afficher une video en ASCII ... en console !
alias VideoAscii='mplayer -vo caca'

# Pour convertir des fichiers textes :
alias dos2unix='recode dos/CR-LF..l1'
alias unix2win='recode l1..windows-1250'
alias unix2dos='recode l1..dos/CR-LF'

# Pour installer directement :
alias Installer='echo -e "Recherche des paquets demandés... Veuillez rentrer votre mot de passe :"; sudo apt install'

# Pour prononcer un son :
alias Prononcer='espeak -s 170 -v french --stdin'

# Avec nautilus
alias nautici='echo -e "Ouverture de Nautilus dans le repertoire courant [${blue}$(pwd)${white}]... en cours de traitement..." && nautilus "$(pwd)" &> /dev/null &'

# Support de l'outil LEDIT pour un meilleur toplevel ocaml.
alias leditocaml='ledit -x -h ocaml_history.ml ocaml'
alias leocaml='rlwrap -t dumb --file=/home/lilian/keyword_mocaml_rlwrap.txt --renice --remember -Acm -aPassword: -pGreen --break-chars "() {}[],+-=&^%$#@\"" --histsize 3000000 -H ocaml_history.ml ledit -x -u -l $COLUMNS -h ocaml_history.ml ocaml'
alias rlocaml='rlwrap -t dumb -z count_in_prompt --file=/home/lilian/keyword_mocaml_rlwrap.txt --renice --remember -Acm  -aPassword: -pGreen --break-chars "() {}[],+-=&^%$#@\"" --histsize 3000000 ocaml'

alias mocaml='rlwrap -t dumb --file=/home/lilian/keyword_mocaml_rlwrap.txt --renice --remember -Acm -aPassword: -pGreen --break-chars "() {}[],+-=&^%$#@\"" --histsize 3000000 -H mocaml_history.ml  ledit -x -u -l $COLUMNS -h mocaml_history.ml ocaml'
alias mocaml_noANSI='rlwrap -t dumb --file=/home/lilian/keyword_mocaml_rlwrap.txt --renice --remember -Acm -aPassword: -pGreen --break-chars "() {}[],+-=&^%$#@\"" --histsize 3000000 -H mocaml_history.ml ledit -x -u -l $COLUMNS -h mocaml_history.ml /home/lilian/.mocaml/launch_noANSI.sh'

# Interpréter les fichiers. Bien mieux que 'ocaml file1.ml file2.ml'.
function ocamls() {
    for i in "$@"; do
        cat "${i}" >> /tmp/iocaml.ml
        echo -e "(** OCaml on ${i}:1:1 *)" >> /tmp/iocaml.log
        /usr/bin/ocaml graphics.cma < "${i}" 2>&1 | tee -a /tmp/iocaml.log | sed s_//toplevel//_"${i}"_ | pygmentize -l ocaml -P encoding="$(file -b --mime-encoding "${i}")"
    done
}
# TODO this requires https://github.com/andrewray/iocaml/#installation (and maybe some local hack to make it work)
# alias jupyter-iocaml='DYLD_LIBRARY_PATH=/home/lilian/.opam/4.04.2/lib/stublibs/ && eval $(opam config env) && jupyter notebook --Session.key="b\"\""'

# Convert Jupyter notebooks
alias j='jupyter-notebook'  # might be changed
alias ju='jupyter-notebook'
# alias j2html='jupyter-nbconvert --to html'
function j2html() {
    for old in "$@"; do
        jupyter-nbconvert --to html "$old"
    done
}
# alias j2pdf='jupyter-nbconvert --to pdf'
function j2pdf() {
    for old in "$@"; do
        jupyter-nbconvert --to pdf "$old"
        # new="${old%.ipynb}__fix-iocaml-notebook-exports-to-pdf.ipynb"
        # [ -f "$new" ] && mv -vf "$new" /tmp/
        # fix-iocaml-notebook-exports-to-pdf.py "$old" "$new"
        # if [ $? = 0 ]; then
        #     jupyter-nbconvert --to pdf "$new"
        #     [ -f "${old%.ipynb}.pdf" ] && mv -vf "${old%.ipynb}.pdf" /tmp/
        #     mv -vf "${new%.ipynb}.pdf" "${old%.ipynb}.pdf"
        #     mv -vf "$new" /tmp/
        # else
        #     jupyter-nbconvert --to pdf "$old"
        # fi
    done
}
alias j2webpdf='jupyter-nbconvert --to webpdf'

alias j2script='jupyter-nbconvert --to script'
alias j2py='jupyter-nbconvert --to python'
alias j2ml='jupyter-nbconvert --to ocaml'  # With https://github.com/Naereen/Jupyter-NBConvert-OCaml/
alias j2ju='jupyter-nbconvert --to julia'
function j2ja() {
    for old in "$@"; do jupyter-nbconvert --to script "$old"; mv "${old%.ipynb}.jshell" "${old%.ipynb}.java" ; done
}
function j2pyhtml() {
    for old in "$@"; do jupyter-nbconvert --to html "$old"; jupyter-nbconvert --to python "$old"; done
}
function j2htmlpy() {
    for old in "$@"; do jupyter-nbconvert --to html "$old"; jupyter-nbconvert --to python "$old"; done
}
complete -f -X '!*.ipynb' -o plusdirs j j2html j2pdf j2webpdf j2script j2py j2ml j2ju j2ja j2pyhtml j2htmlpy

function show_imported_from_python_module() {
    python3 -c "from $1 import *; g=dict(globals()); print([s for s in g if s[0]!='_'])"
}

alias iocaml='jupyter-console --kernel=ocaml-jupyter'

# Reference for this is https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion-Builtins.html
complete -f -X '!*.ml' -o plusdirs ocaml ocamlc ocamlopt leocaml leditocaml rlocaml mocaml mocaml_noANSI ocamls iocaml iocaml.sh jupyter-iocaml

########################################################################
# Outil pygmentize : permet une coloration syntaxique dans la console
case $TERM in
    *dumb*|*term*)
        CAT_COLOR="terminal256"
        export CAT_COLOR="terminal256"
        ;;
    *)
        CAT_COLOR="terminal"
        export CAT_COLOR="terminal"
        ;;
esac
alias catColor='pygmentize -f $CAT_COLOR -g'
function ExportColorLaTeX() {
    pygmentize -f latex -P encoding=utf8 -o "$1.tex" "$1"
}
function ExportColorLaTeXFull() {
    pygmentize -f latex -P encoding=utf8 -O full -o "$1.full.tex" "$1"
}

########################################################################
export RLWRAP_HOME='/home/lilian/'
export RLWRAP_EDITOR='/home/lilian/bin/nano.last --autoindent --tabsize=8 --softwrap --suspend --const --smooth --rebindkeypad --boldtext --multibuffer  --preserve'

function voirImage() {
    for image in "$@"; do
        echo -e "L'image '${image}' va etre affichee en ASCII."
        if [ -f "${image}" ]; then
            convert "${image}" jpg:- | jp2a -b -f --colors -
        fi;
    done
}
# Ajout d'une bash complétion comme ça, en une ligne !
complete -f -X '!*.@(gif|GIF|jpg|jpeg|pn[gm]|PN[GM]|ico|ICO)' -o plusdirs voirImage
complete -f -X '!*.@(png|PNG)' -o plusdirs advpng
complete -f -X '!*.@(jpg|jpeg|JPG|JPEG)' -o plusdirs cjpeg djpeg jpegexiforient jpegoptim jpegtopnm jpegtran
complete -f -X '!*.@(gif|GIF)' -o plusdirs gifcompress gifcurry gifdiff gifsicle giftopnm gifview gif2mp4.sh

function xtitle() {
    echo -e "${reset}Setting title to $@..." >> /tmp/xtitle.log
    echo -e "${cyan}Setting title to ${white}${u}$*${U}...${reset}${white}"
    if [ -x /usr/bin/xtitle ]; then
       /usr/bin/xtitle "$@"
    fi
}

# Autre outils pratiques
function Regler_son() {
    xtitle "$(date)<$USER@$HOSTNAME> { AlsaMixer v1.0.25 }" || true
    clear ; alsamixer; clear
}

function Wavemon() {
    xtitle "$(date)<$USER@$HOSTNAME> { Wavemon v0.7.6 }" || true
    clear ; wavemon; clear
}
function t() {
    xtitle "$(date)<$USER@$HOSTNAME> { htop 1.0.3 }" || true
    htop || alert
    clear
}

function captureEcran() {  # now the Alt+$ shortcut does the same!
    sleep 3s
    xfce4-screenshooter -r -d 5 || gnome-screenshot -i
    clear
}

alias manH='man -Helinks'
alias Byobu='echo -e "You should rather use TMUX instead"; byobu -A -D -RR -fa -h 150000 -l -O -U'  # TMUX is better
alias Byobu-tmux='byobu-tmux -2 -q -u'
# http://unix.stackexchange.com/a/1098
alias byobu='TERM=xterm-256color /usr/bin/byobu-tmux -2 -q -u'

alias py2html='pyhtmlizer --stylesheet=https://perso.crans.org/besson/pyhtmlizer.css'
complete -f -X '!*.@(py|py3)' -o plusdirs py2html pylint flake8 pep8

# Ecrans de veilles
alias MatrixVeille='cmatrix -b -f -s -u 9'

# Screensaver (very CPU expensive) in texts mods, using libcaca examples (cacademo or cacafire)
alias cacademoTerminal='OLDDISPLAY=$DISPLAY; DISPLAY=""; cacademo; DISPLAY=$OLDDISPLAY'
alias cacafireTerminal='OLDDISPLAY=$DISPLAY; DISPLAY=""; cacafire; DISPLAY=$OLDDISPLAY'

function lessColor() {
    for i in "$@"; do
        pygmentize -P encoding="$(file -b --mime-encoding "${i}")" -f $CAT_COLOR -g "${i}" | less -r || \
        echo -e "${ERROR} LessColor failed to read ${u}${i}${U} ...${white}" > /dev/stderr
    done
}

## Emuler l'appuis sur les touches de volumes (ne fonctionne temporairement plus)
alias SoundMute='echo -e KeyStrPress XF86AudioMute KeyStrRelease XF86AudioMute | xmacroplay $DISPLAY > /dev/null >& /dev/null'
alias SoundUp='echo -e KeyStrPress XF86AudioRaiseVolume KeyStrRelease XF86AudioRaiseVolume | xmacroplay $DISPLAY > /dev/null >& /dev/null'
alias SoundDown='echo -e KeyStrPress XF86AudioLowerVolume KeyStrRelease XF86AudioLowerVolume | xmacroplay $DISPLAY > /dev/null >& /dev/null'
alias RaiseSound='echo -e KeyStrPress XF86AudioRaiseVolume KeyStrRelease XF86AudioRaiseVolume | xmacroplay $DISPLAY > /dev/null >& /dev/null'
alias LowerSound='echo -e KeyStrPress XF86AudioLowerVolume KeyStrRelease XF86AudioLowerVolume | xmacroplay $DISPLAY > /dev/null >& /dev/null'

# Variable utiles pour faire des scp et des rsync facilement
export SDPT='lbesson@ssh.dptinfo.ens-cachan.fr'
export SZAM='besson@zamok.crans.org'
export Sdpt='lbesson@ssh.dptinfo.ens-cachan.fr:~/public_html/'
export Szam='besson@zamok.crans.org:~/www/'
export toprint="${Szam}dl/.p/toprint/"
export Sjarvis=~/"Public/"
export SWS3='lilian_besson@ws3'
export Sw='lilian_besson@ws3:~/'
export SFORGE='lbesson@scm.gforge.inria.fr'
export Sforge='lbesson@scm.gforge.inria.fr:/home/groups/banditslilian/htdocs/'

# For http://besson.link/ and https://besson.link/
export FOVH='ftp://bessonlihy@ftp.cluster028.hosting.ovh.net:21'
export SOVH='bessonlihy@ftp.cluster028.hosting.ovh.net'
export Fovh='ftp://bessonlihy@ftp.cluster028.hosting.ovh.net:~/www/'
export Sovh='bessonlihy@ftp.cluster028.hosting.ovh.net:~/www/'

# Play an ASCII version of Star Wars, A new hope
alias telnet_starwars='telnet towel.blinkenlights.nl'

# Un outil pour les messages du jour
alias motd='changemotd.sh --print'
function chmotd() {
    if [ "X$DISPLAY" = "X" ]; then
        echo -e "Using : dialog."
        changemotd.sh --new-dialog
    else
        echo -e "Using : zenity."
        changemotd.sh --new-zenity
    fi
}
function SMSmotd() {
    FreeSMS.py "$(tail -n +2 ~/motd)"
}

function LessColor() { pygmentize -f $CAT_COLOR -g "$@" | less -r; }

# Un meilleur 'scp'. Ne fonctionne pas avec tous les serveurs, car la cible doit avoir rsync aussi.
# NOTE: fonctionne aussi en local (et donne un avancement et propose une compression, meme en local).
alias rsync='/usr/bin/rsync --verbose --times --perms --compress --human-readable --progress --archive'
# Deprecated: use http://besson.qc.to/bin/CP instead (with colours!)

function DOCXtoPDF() { for i in "$@"; do echo -e "${i} ----[abiword]----> ${i%.docx}.pdf"; abiword "${i}" --to="${i%.docx}.pdf"; echo -e "$?"; done }

# Netoyer les fichiers temporaires (sauvegarde, python, ou emacs)
alias rmPyc='rm -vrI ./*.py[co] ./__pycache__/ && echo "Local Python compiled files (*.pyc and *.pyo) have been deleted..."'
alias rmt='rm -vrI ./*~ ./.*~ ./*.py[co] ./__pycache__/ ./\#*\#'

function rmTilde() {
    if [ X"$1" != X"" ]; then
        for i in "$@"; do
            # d="$(basename \"$i\")" # ? inutile ?
            d="$i"
            echo -e "rm -vrI" "$d"/*~ "$d"/.*~ "$d"/*.py[co] "$d"/__pycache__/ "$d"/\#*\#
            rm -vrI "$d"/*~ "$d"/.*~ "$d"/*.py[co] "$d"/__pycache__/ "$d"/\#*\#
        done
        echo -e "Fichiers temporaires (*~ .*~) bien supprimes."
    else
        echo -e "rm -vrI" ./*~ ./.*~ ./*.py[co] ./__pycache__/ ./\#*\#
        rm -vrI ./*~ ./.*~ ./*.py[co] ./__pycache__/ ./\#*\# && \
            echo "Fichiers temporaires (*~ .*~) bien supprimes."
    fi
}

alias rmt=rmTilde
alias rm~="rmTilde *"

# Netoyer les fichiers temporaires crees par LaTeX (pdflatex et hevea)
function rmLaTeX() {
    echo -e "# ${blue}rmLaTeX:${white}"
    for i in ./*.tex; do
        echo -e "# For the file ${yellow}${u}$i${U}${white}:"
        for j in "${i%tex}dvi" "${i%tex}htoc" "${i%tex}frompdf[0-9]*.png" "${i%tex}bbl" "${i%tex}blg" "${i%tex}brf" "${i%tex}tms" "${i%tex}tid" "${i%tex}lg" "${i%tex}idv" "${i%tex}vrb" "${i%tex}toc" "${i%tex}snm" "${i%tex}nav" "${i%tex}htmp" "${i%tex}synctex.gz" "${i%tex}synctex.gz(busy)" "${i%tex}aux" "${i%tex}fdb_latexmk" "${i%tex}fls" "${i%tex}log" "${i%tex}tmp" "${i%tex}idx" "${i%tex}aux" "${i%tex}out" "${i%tex}haux" "${i%tex}hidx ${i%tex}thm"; do
            mv -vf "$j" /tmp/ 2>/dev/null
        done
    echo -e "Fichiers $(ls --color=always --format=horizontal ${i%tex}html ${i%tex}pdf) : conserves..."
    done
}

# A super pdflatex
function tex2pdf() {
    for i in "$@"; do
        i="${i//.pdf/.tex}"
        ( pdflatex "$i" && pdflatex "$i" && mv -f "${i%tex}log" "${i%tex}aux" "${i%tex}synctex.gz" "${i%tex}out" "${i%tex}vrb" /tmp/ 2>/dev/null ) || (clear ; chktex "$i" ; alert )
        mv -f "${i%tex}snm" "${i%tex}nav" "${i%tex}toc" /tmp/ 2>/dev/null
    done
}
function TEX2PDF() {
    for i in "$@"; do
        i="${i//.pdf/.tex}"
        ( pdflatex "$i" && pdflatex "$i" && mv -f "${i%tex}log" "${i%tex}aux" "${i%tex}synctex.gz"* "${i%tex}out" "${i%tex}vrb" /tmp/ 2>/dev/null ) || (clear ; chktex "$i" ; alert )
        mv -f "${i%tex}snm" "${i%tex}nav" "${i%tex}toc" /tmp/ 2>/dev/null
        PDFCompress "${i%tex}pdf"
    done
}
complete -f -X '!*.@(tex|pdf)' -o plusdirs tex2pdf TEX2PDF qpdf

# A small alias to convert .md to .pdf with Pandoc
function md2pdf() {
    for i in "$@"; do
        i="${i//.pdf/.md}"
        pandoc --verbose --to=latex --output="${i%md}pdf" "$i"
        # [ -f "{i%md}pdf" ] && PDFCompress "${i%md}pdf"
        # [ -f "{i%md}pdf" ] && evince "${i%md}pdf" &>/dev/null&
    done
}
complete -f -X '!*.@(md|pdf)' -o plusdirs md2pdf

# A better and smaller bibtex2html command, with good options
alias bib2html='bibtex2html -u -charset utf-8 -linebreak -debug'
complete -f -X '!*.@(bib)' -o plusdirs bibtex2html bib2html

# N'afficher que les processus lances par l'utilisateur courant dans htop.
alias Htop='htop -u $USER'

# Pour afficher la temperature.
alias TempDisk='echo -e "Hard drive temperature : ${green}$(($(sudo hddtemp --numeric --wake-up /dev/disk/by-label/SYSTEM)))${white} °C."'

# Affiche la taille du repertoire courant. Peut etre long a calculer !
alias TailleCourante='LS_ECHO -e "*"; echo -e "${el}Taille du repertoire ${u}courant${U} : \033[01;31m`du -sh \"\`pwd -P\`\"`\033[01;37m"'

# Simply shutdown the main screen (force it to be black!)
alias VeilleEcranNoir='xset dpms force standby'
alias VeilleEcranNoirContinue='watch --interval=1 "echo -e \"Screen is sleeping, Ctrl+C, ^C to cancel.\" ; xset dpms force standby"'

alias IpAdresses='ifconfig | grep "inet"'
alias SpeedTest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test100.zip"

# Get Linux kernel versions and informations
alias version='cat /proc/version ; lsb_release -a'

# Check today content of Google Calendar
alias CheckGoogleCalendar='gcalcli agenda today tomorrow'
alias CalendarRandQuote='gcalcli --calendar "amelia"."noreen"@"gmail"."com" quick "$(randquote)"'

# Gobby Server
alias SOBBY='sobby -p 6522 --password 120193 --autosave-file=/home/lilian/.gobby.savefile --autosave-interval=10'
# Via monip.org
alias AdressIP='echo -e "# From http://monip.org/ :" ; wget --tries=5 -q -O - http://monip.org/ | html2text ; echo -e "\n# From http://ipinfo.io/ :" ; (type ipinfo.sh &>/dev/null && ipinfo.sh || curl http://ipinfo.io/) '

# Efface les fichiers temporaires dus à un Mac qui a monté le disque
alias EffacePresenceAPPLE='find -type d -name *Apple* -exec rm -vrI {} \;'
# Affiche tous les programmes dans le $PATH.
alias LS_PATH='ls ${PATH//:/ }'

function LOG_Colored() {
    "$@" 2> /tmp/LOG_Colored.log
    printf "${reset}${el}\a"
    catColor /tmp/LOG_Colored.log
}

# Shortend to git
alias GitChanged='clear ; git status | grep --color=always "\(modified\|modifié\)" | less -r'
alias GitDeleted='clear ; git status | grep --color=always "\(deleted\|supprimé\)" | less -r'
alias GitAdded='clear ; git status | grep --color=always "\(added\|nouveau\)" | less -r'
alias GitSize='clear ; echo -e "\n ==> ${white}Ce dépôt git « ${green}$(basename $(pwd))${white} » pèse ${red}$(git count-objects -v -H | grep "size-pack" | sed s/"size-pack: "//)${white} sur ${u}https://BitBucket.org/lbesson/$(basename $(pwd))${U}${white}."'

# Run all test embedded in docstring, in the module $1
alias DocTest='python -m doctest -v'
alias DocTest3='python3 -m doctest -v'

# Make colorgcc an remplacement for GCC (all makefiles use CC usually)
export CC="colorgcc"
alias diff="colordiff"

alias CowThink='cowthink -W 160 -f /usr/share/cowsay/cows/moose.cow'

# For zip compression (by default, DO NOT FOLLOW symlinks!)
alias zip='/usr/bin/zip -r -9 -y'
# For tar compression
alias TarXZ='tar -Jcvf'
alias TarGZ='tar -zcvf'
alias TarBZ2='tar -jcvf'
# For tar un-compression (see extract for a better commad)
alias untar='echo -e "Desarchivage du fichier archive tar en cours ..." && tar xfv'
alias untar_gz='echo -e "Desarchivage du fichier archive tar.gz en cours ..." && tar xzfv'
alias untar_bz2='echo -e "Desarchivage du fichier archive tar.bz2 en cours..." && tar xjfv'
alias untar_xz='echo -e "Desarchivage du fichier archive tar.xz en cours..." && tar xJfv'
alias unTarXZ='tar -Jxvf'
alias unTarGZ='tar -zxvf'
alias unTarBZ2='tar -jxvf'
alias unTarTBZ='tar -xjvf'

#  Use grep to look for TODO or FIXME or FIXED or HOWTO or XXX or DEBUG, or WARNING balises in code
function GrepBalises() {
    echo -e "GrepBalises >>> Looking for specials developpement balises in files ${blue}$@${white}."
    notfound=""
    for balise in 'TODO' 'FIXME' 'FIXED' 'HOWTO' 'XXX' 'DEBUG' 'WARNING'; do
        res=$(grep --color=always -n "$balise" $@)
        if [ "m$?" != "m1" ]; then
            echo -e "${magenta}  For the balise $balise :${default}"
            echo -e "${res}" # | pygmentize -f terminal256 -g # -l
        else
            notfound="${notfound}${balise}, "
            echo -e "${red} $balise not found in files..." >> /tmp/GrepBalises.log
        fi
    done
    if [ "X$notfound" = "X" ]; then
        echo -e "${white}GrepBalises >>> ${green} Done${white}. (on files $*)."
    else
        echo -e "${white}GrepBalises >>> ${red} Balises ${notfound} not found :("
        echo -e "${white}GrepBalises >>> Done. (on files $*)."
    fi
}

# Better grep command, using ack-grep, cf. http://beyondgrep.com/
#alias agrep='ack-grep -ri -H --sort-files'
# Even better grep command, using ripgrep, cf. https://github.com/BurntSushi/ripgrep
alias agrep='rg --color=auto'
#alias grep='rg --color=auto'   # XXX aggressive!

# Other aliases, from http://abs.traduc.org/abs-5.3-fr/apk.html
# tailoring 'less'
export PAGER=less
export LESSCHARSET='latin1'
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'

## Use this if lesspipe.sh exists.
##export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'
export LESS=' -r -F -B -i -J -w -W -~ -K -d -w -W -m -X -u -r'
###-P"%t?%f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-..." -e'

#-----------------------------------
# File & strings related functions:

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'"$@"'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe() { find . -type f -iname '*'"$1"'*' -exec "${2:-file}" {} \;  ; }

# find pattern in a set of files and highlight them:
function fstr() {
        OPTIND=1
        local case=""
        local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
        while getopts :it opt; do
            case "$opt" in
            i) case="-i " ;;
            *) echo "$usage"; return;;
            esac
        done
        shift $(( $OPTIND - 1 ))
        if [ "$#" -lt 1 ]; then
            echo "$usage"
            return;
        fi
        local SMSO=$(tput smso)
        local RMSO=$(tput rmso)
        find . -type f -name "${2:-*}" -print0 |
        xargs -0 grep -sn "${case}" "$1" 2>&- | \
        sed "s/$1/${SMSO}\0${RMSO}/gI" | more
}

function lowercase() {  # move filenames to lowercase
    for file ; do
        filename="${file##*/}"
        case "$filename" in
            */*) dirname==${file%/*} ;;
            *) dirname=.;;
        esac
        nf="$(echo $filename | tr '[:upper:]' '[:lower:]')"
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
        else
            echo "lowercase: $file not changed."
        fi
    done
}

function capitalize() {  # move filenames to Capitalize
    for file ; do
        filename="${file##*/}"
        case "$filename" in
            */*) dirname==${file%/*} ;;
            *) dirname=.;;
        esac
        premierelettre="${filename:0:1}"
        pl="$(echo $premierelettre | tr '[:lower:]' '[:upper:]')"
        nf="${pl}${filename:1}"
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "capitalize: $file --> $newname"
        else
            echo "capitalize: $file not changed."
        fi
    done
}

alias titlecase="python -c \"from sys import argv; from titlecase import titlecase; print(titlecase('\n'.join(argv[1:])))\""

function titlecase_all() {  # move filenames to Title Case
    for file ; do
        filename="${file##*/}"
        case "$filename" in
            */*) dirname==${file%/*} ;;
            *) dirname=.;;
        esac
        nf="$(titlecase "$filename")"
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "titlecase_all: $file --> $newname"
        else
            echo "titlecase_all: $file not changed."
        fi
    done
}

function swap() {        # swap 2 filenames around
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

function my_ps() { ps "$@" -u "$USER" -o pid,%cpu,%mem,bsdtime,command ; }

function pp() { my_ps f | awk '!/awk/ && $0~var' var="${1:-".*"}" ; }

function my_ip() {  # get IP adresses
    MY_IP=$(/sbin/ifconfig | awk '/inet adr:/ { print $2 } ' | sed -e s/addr://)
}

function ii() {   # get current host related info
    echo -e "\nYou are logged on ${blue}$HOSTNAME ($HOSTNAME_WIFI)"
    echo -e "\nAdditionnal information:${reset}${white} " ; uname -a
    echo -e "\n${blue}Users logged on:${reset}${white} " ; w -h
    echo -e "\n${blue}Current date :${reset}${white} " ; date
    echo -e "\n${blue}Machine stats :${reset}${white} " ; uptime
    echo -e "\n${blue}Memory stats :${reset}${white} " ; free
    my_ip 2>&- ;
    echo -e "\n${blue}Local IP Address :${reset}${white}" ; echo "${MY_IP:-"Not connected"}"
}

# For Python (2.7)
export PYTHONSTARTUP="$HOME/.pythonrc"
#export PYTHONWARNINGS="ignore"
#export PYTHONOPTIMIZE= # no optimization.
#export PYTHONVERBOSE=  # no verbose adds.
# export PYTHONPATH="/usr/local/lib/python2.7/":"/usr/local/lib/python2.7/dist-packages/":"/usr/lib/python2.7/":"/usr/lib/python2.7/dist-packages"

# Avoid a painful bug, as explained here http://stackoverflow.com/a/230780/5889533, see https://docs.python.org/2/using/cmdline.html#envvar-PYTHONUNBUFFERED
export PYTHONUNBUFFERED="yes"

# For PyLint (see http://docs.pylint.org/)
export PYLINTHOME="$HOME/.pylint.d/"

# Supprimer les meta-données des images JPEG et PNG, et PDF
alias CleanPicturesR='echo "Erasing EXIF infos...." && exiftool -v2 -recurse -fast -overwrite_original_in_place -all= ./* | tee "exiftool__$$_$(date "+%H_%M_%S")".log && echo "All EXIF infos have been erased :)"'
alias CleanPictures='echo "Erasing EXIF infos...." && exiftool -v2 -fast -overwrite_original_in_place -all= ./* | tee "exiftool__$$_$(date "+%H_%M_%S")".log && echo "All EXIF infos have been erased :)"'
alias CleanPNG='echo "Cleaning and compressing PNG images..." && exiftool -v2 -fast -overwrite_original_in_place -all= ./*.png && advpng -z -2 ./*.png && M'
alias CleanPDF='echo "Cleaning and compressing PDF images..." && exiftool -v2 -fast -overwrite_original_in_place -all= ./*.pdf && PDFCompress --no-keep ./*.pdf && M'

## A less for PDF files (useless)
function lessPDF() {
    for f in "$@"; do
        pdftotext -r 200 -layout -eol unix -enc UTF-8 -raw "$f" && less -f -J "${f%.pdf}.txt"
    done
}

eval "$(/bin/lesspipe)"
# Man visual
function Man() { yelp "man:$@" ; }

#  Le script suivant permet de decompresser un large eventail de types de fichiers compresses. Il vous suffira juste de taper quel que soit le type d'archive :
function extract() {
    echo -e "${reset}${neg}Extracting $1...${reset}"
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)   tar xvjf "$1"    ;;
            *.tar.gz)    tar xvzf "$1"    ;;
            *.tar.xz)    tar xvJf "$1"    ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xvf "$1"     ;;
            *.tbz2)      tar xvjf "$1"    ;;
            *.tbz)       tar xvjf "$1"    ;;
            *.tgz)       tar xvzf "$1"    ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *.xz)        unxz "$1"        ;;
            *.exe)       cabextract "$1"  ;;
            *)           echo "'$1': unrecognized file compression" ;;
        esac
    else
        echo "'$1' seems to not be a valid archive file, sorry."
    fi
}

# Experimental
function LatexFormula() {
    out="/tmp/LatexFormula_$$.jpg"
    # tente d'afficher les arguments interpretes comme une formule LaTeX, via le bon service web.
    wget --quiet 'http://s0.wp.com/latex.php?bg=ffffff&fg=1c1c1c&s=0&zoom=10&latex=\displaystyle'"${@// /+}" -O "${out}" \
    || wget --quiet 'http://numberempire.com/equation.render?'"${@// /%20}" -O "${out}"
    display -title "Image for the LaTeX formula: '${@//\\/\\\\}'   (thanks to an awesome webservice)" "${out}"
}

alias CheckHomePage_crans='wget -q https://perso.crans.org/besson/index.fr.html -O - | grep "Mis.*jour"'
# alias CheckHomePage_dpt='wget -q http://www.dptinfo.ens-cachan.fr/~lbesson/index.fr.html -O - | grep "Mis.*jour"'
alias CheckHomePage_jarvis='wget -q http://localhost/index.fr.html -O - | grep "Mis.*jour"'

alias GenP="base64 < /dev/urandom | tr -d +/ | head -c 18; echo"

# Pour checker les soucis de droits.
alias MoinsOwner='chmod -vR o-w ./ | tee /tmp/.script_droit_owner.log'
alias MoinsGroup='chmod -vR g-w ./ | tee /tmp/.script_droit_group.log'
alias MOINS='( MoinsOwner ; MoinsGroup) | grep -v symbolique | grep modif'
alias M='MOINS'
alias CheckPerms='find ./ -type d -perm /022'
alias PlusROwner='chmod -vR o+r ./ | tee /tmp/.script_droit_Rowner.log'
alias PlusRGroup='chmod -vR g+r ./ | tee /tmp/.script_droit_Rgroup.log'
alias PLUS='( PlusROwner ; PlusRGroup) | grep -v symbolique | grep modif'

function ViewHTML() {
    for i in "$@"; do
        echo -e "Trying to see the file at the address ${yellow}'${i}'${white}"
        curl --insecure "$i" 2> /tmp/ViewHTML.$$.log | html2text | pygmentize -f terminal -l rst
    done
}

alias MacAddress='ifconfig | grep "HWaddr [0-9a-f:]*"'

# --- For Git only ---
alias g='git'
# Thanks to http://stackoverflow.com/a/4529147/5889533
function pushall() {
    for i in $(git remote | sort -r); do
        echo -e "git push $i ${1}" "..."
        git push "$i" "${1}"
    done;
}
function pullall() {
    for i in $(git remote | sort -r); do
        echo -e "git pull $i ${1}" "..."
        git pull "$i" "${1}"
    done;
}
alias ori='git pull origin main'

# --- For Git and subversion ---
function Push() {
    clear
    (git push "$@" && git gc) || svn update "$@"
}
function p() {
    clear
    git push "$@" || svn update "$@"
}

function Pull() {
    clear
    (pullall "$@" && git gc && [ -x git-blame-last-commit.sh ] && git-blame-last-commit.sh) || svn update "$@"
}

function s() {
    clear
    ( git status "$@" || svn status "$@" ) | less -r
}
alias Status='s'

function wd() {
    clear
    git wdiff "$@" || svn diff "$@"
}

function c() {
    clear
    git commit -m "$@" || svn commit -m "$@"
}
alias Commit='c'

function a() {
    git add "$@" || svn add "$@"
}
alias Add='a'
function add_modified() { git add $(git status --porcelain | grep '^ M' | awk '{ print $2}'); }

alias Aggressive='git gc --aggressive'
alias Sync='clear ; echo -e "Synchronizing (git push, gc, send_zamok)..."; git push; git gc --aggressive; make send_zamok; alert'

# For gmusicbrowser
alias Get_vrun_Uri="vrun status | grep file | sed s/'( new input: '/''/ | sed s/' )'/''/"
alias Next='gmusicbrowser -cmd NextSong'  # && clear ; tmp1=$(vrun get_title); tmp2=$(vrun status|head -n1); echo -e "$u$tmp2$reset${white}\n${green} (→) Playing${white}: $neg$tmp1$Neg"'
alias Prev='gmusicbrowser -cmd PrevSong'  # && clear ; tmp1=$(vrun get_title); tmp2=$(vrun status|head -n1); echo -e "$u$tmp2$reset${white}\n${green} (←) Playing${white}: $neg$tmp1$Neg"'
alias Pause='gmusicbrowser -cmd PlayPause'  # && clear ; tmp1=$(vrun get_title); tmp2=$(vrun status|head -n1); echo -e "$u$tmp2$reset${white}\n${green} (:) Was Playing${white}: $neg$tmp1$Neg"'
alias Play='gmusicbrowser -cmd Play'  # && clear ; tmp1=$(vrun get_title); tmp2=$(vrun status|head -n1); echo -e "$u$tmp2$reset${white}\n${green} (>) Now Playing${white}: $neg$tmp1$Neg"'

# Irssi
alias irc='screen irssi'

# TMUX create a new session ONLY if no other session is already running
alias tmux='TERM=xterm-256color /usr/bin/tmux -2 -q -u'
alias TMUX='/usr/bin/tmux -2 -q -u attach-session || /usr/bin/tmux -2 -q -u'

# For GPG
GpgSign()    { gpg --armor --detach-sign --yes --no-batch --use-agent "$@"; }
GpgVerify()  { gpg --verify --no-batch --use-agent "$@"; }
function GpgEncrypt() { gpg --encrypt --yes --no-batch --use-agent -r "$EMAIL" "$@"; }
function GpgDecrypt() { gpg --decrypt --yes --no-batch --use-agent "$@"; }

# Pour que ssh-add ne memorise la passphrase que pendant 30 minutes
alias ssh-add='ssh-add -t 1800'

# youtube-dl shortcuts (there is also youtube-playlist.sh and youtube-albums.sh)
function youtube() {
    for i in "$@"; do
        arg="$(echo -e "$i" | grep -o v%3D[a-zA-Z0-9_-]*%26 | sed s/v%3D// | sed s/%26// )"
        if [ "X$arg" = "X" ]; then arg="$i"; fi
        echo -e "${green}Launching youtube-dl on ${white}${u}${arg}${U} ${black}(with the good options to download ${cyan}video${black} and ${cyan}mp3${black}).${white}"
        youtube-dl --restrict-filenames --youtube-skip-dash-manifest --output "%(title)s.%(ext)s" --extract-audio --console-title --keep-video --audio-format=mp3 --no-overwrites -- "$arg"
    done
}
function youtube-mp3() {
    for i in "$@"; do
        arg="$(echo -e "$i" | grep -o v%3D[a-zA-Z0-9_-]*%26 | sed s/v%3D// | sed s/%26// )"
        if [ "X$arg" = "X" ]; then arg="$i"; fi
        echo -e "${green}Launching youtube-dl on ${white}${u}${arg}${U} ${black}(with the good options to download just the ${cyan}mp3${black}).${white}"
        youtube-dl --restrict-filenames --youtube-skip-dash-manifest --format worst --output "%(title)s.%(ext)s" --extract-audio --console-title --audio-format=mp3 --no-overwrites -- "$arg"
    done
}
alias y='youtube-mp3'
function youtube-video() {
    for i in "$@"; do
        arg="$(echo -e "$i" | grep -o v%3D[a-zA-Z0-9_-]*%26 | sed s/v%3D// | sed s/%26// )"
        if [ "X$arg" = "X" ]; then arg="$i"; fi
        echo -e "${green}Launching youtube-dl on ${white}${u}${arg}${U} ${black}(with the good options to download just the ${cyan}video${black}).${white}"
        youtube-dl --restrict-filenames --youtube-skip-dash-manifest --output "%(title)s.%(ext)s" --console-title --no-overwrites -- "$arg"
    done
}

alias getmod='/usr/bin/stat -c "%a"'
alias watch='watch -b -d -e'

# Do a job, only for a certain amount of time
# Exemple : DoForATime 60 my-very-long-command-that-can-never-terminate
function DoForATime() {
    log="/tmp/DoForATime$(date "+%Hh-%Mm-%Ss").log"
    TIMEOUT="$1"
    shift
    echo -e "${reset}Launching $@, in $PWD, for $TIMEOUT seconds only." | tee "$log"
    echo -e "$white"
    "$@" & { sleep "${TIMEOUT}"; eval 'kill -9 $!' &>> "$log"; }
}

function pstree() { /usr/bin/pstree -a -h -s -c -U "$@"; }

function sshtmux() {
    if [ "Z$TMUX" = "Z" ]; then
        echo -e "${blue}Using tmux on remote server.$white"
        ( /usr/bin/ssh -X -C -t "$@" "tmux -2 -q -u attach-session || byobu || tmux -2 -q -u" ) || ( alert ; echo -e "${red}Error, connection to $@ closed." )
    else
        echo -e "${red}Not using tmux on remote server. Unset \$TMUX to force this.$white"
        /usr/bin/ssh -X -C -t "$@" || ( alert ; echo -e "${red}Error, connection to $@ closed." )
    fi
}

# ssh shortcuts
alias sshzamok='sshtmux besson@zamok.crans.org'
alias sz='sshzamok'
alias sshvo='sshtmux besson@vo.crans.org'
alias sshdpt='sshtmux lbesson@ssh.dptinfo.ens-cachan.fr'
alias sd='sshdpt'
alias s22='sshtmux 03.dptinfo.ens-cachan.fr'
alias s04='sshtmux 04.dptinfo.ens-cachan.fr'
alias s05='sshtmux 05.dptinfo.ens-cachan.fr'
alias s06='sshtmux 06.dptinfo.ens-cachan.fr'
alias sshws3='sshtmux lilian_besson@ws3'
alias sw='sshws3'
alias sshforge='ssh lbesson@scm.gforge.inria.fr'
alias forge='sshforge'

# Navigateur en console
alias elinks='/usr/bin/elinks -verbose 0'

function Lock() {
    echo -e "New use of Lock from $(w).\n\n Last: $(last).\n Date: $(date).\n\n" >> ~/.Lock.log
    if [ "X$(pidof gnome-screensaver)" != "X0" ]; then
        gnome-screensaver-command --lock
        xset dpms force standby
    else
        cmatrix -b -f -s -u 9
        clear
        vlock --current
        xset dpms force standby
    fi
}

function randquote() {
    if [ -f "$quotes" ];  then
        shuf "$quotes" | head -n 1
    elif [ -f "$HOME/motd" ];  then
        cat ~/motd
    else
        echo -e "No citation, ~/motd is not there, and \$quotes is not set."
    fi
}

function blague() {
    if [ -f "$HOME/.blagues.txt" ];  then
        echo -e "${blue}$(shuf "$HOME/.blagues.txt" | head -n 1)${reset}"
    else
        echo -e "T'es dans la campagne, tu vois un âne. « Et l'âne, tu t'appelles comment ? », « Bob », dit l'âne."
    fi
}

function joke() {
    python3 -c "import json,random; f=open('$HOME/.jokes.json'); line=random.choice(json.load(f)); print('$blue', line['setup']); print('$green', line['punchline'], '$reset')"
}

# With nginx
function Nginx_Access() { watch tail -n 10 /var/log/nginx/access.log || alert; }
function Nginx_Error() { watch tail -n 10 /var/log/nginx/error.log || alert; }
function Nginx_Start() {
    #destination="/etc/nginx/nginx.conf"
    destination="/usr/local/nginx/conf/nginx.conf"
    echo -e "${blue} Last changes on ~/nginx.conf on local git repository :${reset}"
    git diff ~/nginx.conf
    echo -e "${blue} Last changes on ~/nginx.conf compared with ${destination} :${reset}"
    diff ~/nginx.conf "${destination}"
    echo -e "${red} Copying ~/nginx.conf to ${destination} ...${reset}"
    sudo cp -i ~/nginx.conf "${destination}"
    p="$(pidof nginx)"
    if [ "X$p" = "X" ]; then
        echo -e "${red} Starting nginx...${reset}"
        sudo nginx
    else
        echo -e "${red} Restarting nginx...${reset}"
        sudo nginx -s reload
    fi
    echo -e "${red} PIDs or command line of ${cyan}${u}nginx${U}${reset} :"
    pidof nginx
}

# With Munin
function Munin_Start() {
    echo -e "${blue} Last changes on ~/munin.conf on local git repository :${reset}"
    git diff ~/munin.conf
    echo -e "${blue} Last changes on ~/munin.conf compared with /etc/munin/munin.conf :${reset}"
    diff ~/munin.conf /etc/munin/
    echo -e "${red} Copying ~/munin.conf to /etc/munin ...${reset}"
    sudo cp -i ~/munin.conf /etc/munin/
    p="$(ps aux |grep "[a-z/]*perl.*munin[a-z-]*$")"
    if [ "X$p" = "X" ]; then
        echo -e "${red} Starting munin...${reset}"
        sudo service munin start
        sudo service munin-node start
    else
        echo -e "${red} Restarting munin...${reset}"
        sudo service munin restart
        sudo service munin-node restart
    fi
    echo -e "${red} PIDs or command line of ${cyan}${u}munin${U}${reset} :"
    ps aux | grep "[a-z/]*perl.*munin[a-z-]*$"
}

# Shortcut : long command &>$null& is shorten that &>/dev/null& :)
export null="/dev/null"

# Use it like 'send_.. ${Szam}bin/' or 'send_.. ~/Dropbox/'
alias send_bashrc_bashalias='CP ~/.bashrc ~/.bash_aliases ~/.bashrc.asc ~/.bash_aliases.asc'

alias n=nano
export EDITOR="/bin/nano"

# Get the latest QC strip ;)
alias GetQC='wget "$(wget http://questionablecontent.net/ -O - | grep -o "http://www.questionablecontent.net/comics.*[0-9]*.*\(png\|jpg\|jpeg\|gif\)")"'

# Print the current read/watched TV shows or movies ('series.sh list' now does the same)
function Currents() {
    clear
    for i in ~/current*; do
            dir="$(cat "$i")"
            echo -e "\n$u$black~/$(basename "$i")$U$white\t ---> \t$blue${dir}$white"
            serie="$(basename "${dir}")"
            cu=$( find "${dir}" -type f -iname current'*' 2>/dev/null || echo -e "Disque Dur Externe ['${u}/media/lilian/Disque Dur - Naereen/${U}']: ${red}pas branché${white}." >/dev/stderr)
            cu2="$(echo "$(basename "$cu")" | tr '[:upper:]' '[:lower:]')"
            cu2="${cu2#current_}"
            # echo -e "sSSeEE  ---> $u$cu2$U"
            d="${cu2#s}"
            d="${d%e[0-9]*}"
            # echo -e "Season :  $d"
            e="${cu2#s[0-9]*e}"
            e="${e#0*}"
            if [[ "${d}${e}" != "" ]]; then
                echo -e "For « ${u}${cyan}${serie}${white}${U} », the last watched episode is ${Black}${red}Season ${d:-?}${white}, ${magenta}Episode ${e:-?}${Default}${white}."
            fi
    done
}

alias UPDATE='( clear ; echo -e "You used the UPDATE alias: updating apt cache, upgrading, auto-removing and cleaning..."; sudo apt update ; sudo apt upgrade ; sudo apt autoremove ; sudo apt clean ; sudo apt autoclean ) || alert | tee /tmp/apt.log'

# To avoid painfull &>$null& at the end of some commands that *should* be detached by default
function evince() { ( /usr/bin/evince "$@" || /usr/bin/firefox "$@" ) &> /dev/null & }
function okular() { ( /usr/bin/okular "$@" || /usr/bin/firefox "$@" ) &> /dev/null & }
function eog() { ( /usr/bin/eog "$@" || /usr/bin/ristretto "$@" ) &> /dev/null & }
function firefox() { ( /usr/bin/firefox "$@" || /usr/bin/elinks "$@" ) &> /dev/null & }

function vlc() {
	if type gmusicbrowser &>/dev/null; then
		echo -e "${blue}Pausing GMusicBrowser (with the 'gmusicbrowser -cmd' CLI tool)...${white}"
		pidof gmusicbrowser &>/dev/null && gmusicbrowser -cmd Pause || echo -e "${red}Warning: GMusicBrowser not playing.${white}"
	fi
	echo -e "${green}Playing the argument file '$@' with /usr/bin/vlc (with --random)${white}"
	/usr/bin/vlc --random "$@" &> /dev/null &
}

# function linphone() { /usr/bin/linphone "$@" &> /dev/null & }
function libreoffice() { ( /usr/bin/libreoffice "$@" || /usr/bin/abiword "$@" ) &> /dev/null & }

#function butterfly() {  # From 'pip install butterfly'
#    butterfly.server.py --logging=none --unsecure &> /dev/null &
#    echo -e "Butterfly running... Open your browser at http://127.0.0.1:57575/ to use the Butterfly terminal in your browser"
#    o http://127.0.0.1:57575/
#}

# Better .rst → .html and .md → .html (simpler)
alias rst2html='rst2html -v -t --no-generator -l fr --cloak-email-addresses '
complete -f -X '!*.@(rst|txt|rST)' -o plusdirs rst2html rst2latex rst2man rst2odt rst2odt_prepstyles rst2pdf rst2pseudoxml rst2s5 rst2xetex rst2xml rst2pdf

alias markdown='python -m markdown -e utf8 -v '
complete -f -X '!*.@(md|mdown|markdown|mkdown|txt)' -o plusdirs markdown markdown2 markdown_py markdown.py

alias bd='. bd -s'

# The best way to use it is by typing a command, canceling it, and then with 'ExplainShell !!'
# Or directly: 'ExplainShell grep -C 2 -n -m 10 grep .bash_history' for example
function ExplainShell() { /usr/bin/firefox http://explainshell.com/explain?cmd="${*// /%20}" &>/dev/null & }

alias Tor='cd ~/.local/tor-browser ; ./start-tor-browser & ; cd -'

function poisson() { python -c "from numpy.random import poisson; print(poisson(int($1)))"; }
#function uniform() { python -c "from random import randint; print(randint(int($1), int($2)))"; }
function uniform() { echo $(($1 + RANDOM%($2-$1+1))); }

# Quickly play my favorite TV series
alias kaamelott='/usr/bin/vlc --random ~/Séries/Kaamelott/ >/dev/null 2>/dev/null &'
#alias kaamelott-parole='parole --fullscreen ~/Séries/Kaamelott/ >/dev/null 2>/dev/null &'
function random_kaamelott() {
    /usr/bin/vlc --random --start-time=$(poisson $((10 * 3 * 60)) ) ~/Séries/Kaamelott/ >/dev/null 2>/dev/null &
    random-vrun-next.sh "${1:-3}"
}

alias scrubs='/usr/bin/vlc --random ~/Séries/Scrubs/ >/dev/null 2>/dev/null &'
#alias scrubs-parole='parole --fullscreen ~/Séries/Scrubs/ >/dev/null 2>/dev/null &'
function random_scrubs() {
    /usr/bin/vlc --random --start-time=$(poisson $((3 * (1 + RANDOM%5) * 60)) ) ~/Séries/Scrubs/ >/dev/null 2>/dev/null &
    random-vrun-next.sh "${1:-5}"
}

alias scrubs-vo='/usr/bin/vlc --random "/media/lilian/Disque Dur - Naereen/Multimedia/Séries/Sitcoms/Scrubs_VO" >/dev/null 2>/dev/null &'
#alias scrubs-vo-parole='parole --fullscreen "/media/lilian/Disque Dur - Naereen/Multimedia/Séries/Sitcoms/Scrubs_VO" >/dev/null 2>/dev/null &'
function random_scrubs_vo() {
    /usr/bin/vlc --random --start-time=$(poisson $((3 * (1 + RANDOM%6) * 60)) ) "/media/lilian/Disque Dur - Naereen/Multimedia/Séries/Sitcoms/Scrubs_VO" >/dev/null 2>/dev/null &
    random-vrun-next.sh "${1:-5}"
}

alias tbbt='/usr/bin/vlc --random "/media/lilian/Disque Dur - Naereen/Multimedia/Séries/Sitcoms/The_Big_Bang_Theory" >/dev/null 2>/dev/null &'
function random_tbbt() {
    /usr/bin/vlc --random --start-time=$(poisson $((3 * (1 + RANDOM%6) * 60)) ) "/media/lilian/Disque Dur - Naereen/Multimedia/Séries/Sitcoms/The_Big_Bang_Theory" >/dev/null 2>/dev/null &
    random-vrun-next.sh "${1:-5}"
}

alias friends='/usr/bin/vlc --random "/media/lilian/Disque Dur - Naereen/Multimedia/Séries/Sitcoms/Friends" >/dev/null 2>/dev/null &'
#alias friends-parole='parole --fullscreen "/media/lilian/Disque Dur - Naereen/Multimedia/Séries/Sitcoms/Friends" >/dev/null 2>/dev/null &'
function random_friends() {
    /usr/bin/vlc --random --start-time=$(poisson $((3 * (1 + RANDOM%6) * 60)) ) "/media/lilian/Disque Dur - Naereen/Multimedia/Séries/Sitcoms/Friends" >/dev/null 2>/dev/null &
    random-vrun-next.sh "${1:-5}"
}

alias himym='/usr/bin/vlc --random "/media/lilian/Disque Dur - Naereen/Multimedia/Séries/Sitcoms/How_I_Met_Your_Mother" >/dev/null 2>/dev/null &'
#alias himym-parole='parole --fullscreen "/media/lilian/Disque Dur - Naereen/Multimedia/Séries/Sitcoms/How_I_Met_Your_Mother" >/dev/null 2>/dev/null &'
function random_himym() {
    /usr/bin/vlc --random --start-time=$(poisson $((3 * (1 + RANDOM%6) * 60)) ) "/media/lilian/Disque Dur - Naereen/Multimedia/Séries/Sitcoms/How_I_Met_Your_Mother" >/dev/null 2>/dev/null &
    random-vrun-next.sh "${1:-5}"
}

function random_sitcoms() {
    /usr/bin/vlc --random --start-time=$(poisson $((3 * (1 + RANDOM%6) * 60)) ) ~/Séries/Kaamelott/ ~/Séries/Scrubs/ "/media/lilian/Disque Dur - Naereen/Multimedia/Séries/Sitcoms/Scrubs_VO" "/media/lilian/Disque Dur - Naereen/Multimedia/Séries/Sitcoms/The_Big_Bang_Theory" "/media/lilian/Disque Dur - Naereen/Multimedia/Séries/Sitcoms/Friends" "/media/lilian/Disque Dur - Naereen/Multimedia/Séries/Sitcoms/How_I_Met_Your_Mother" "/media/lilian/Disque Dur - Naereen/Multimedia/Séries/Sitcoms/Mr_Bean" "/media/lilian/Disque Dur - Naereen/Multimedia/Séries/Sitcoms/The.IT.Crowd" "/media/lilian/Disque Dur - Naereen/Multimedia/Séries/Sitcoms/Bref" >/dev/null 2>/dev/null &
    random-vrun-next.sh "${1:-5}"
}

alias dropbox.start='( /usr/bin/dropbox start ; alert ) &>/dev/null&'

# Put your laptop in Suspend (veille)
alias veille2h='date >> /tmp/veille.log ; sleep 2h ; pm-suspend'
alias veille4='date >> /tmp/veille.log ; ( gnome-session-quit --power-off || xfce4-session-logout || systemctl suspend || (Lock ; gksudo pm-suspend) )'
alias reboot.systemctl='date >> /tmp/veille.log ; systemctl reboot'
alias poweroff.systemctl='date >> /tmp/veille.log ; systemctl poweroff'
alias suspend.systemctl='date >> /tmp/veille.log ; systemctl suspend'
alias veille2='date >> /tmp/veille.log ; ( gnome-session-quit --power-off || xfce4-session-logout || (Lock ; gksudo pm-suspend) )'
alias veille3='date >> /tmp/veille.log ; Lock ; dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Suspend' # does not work
alias veillesudo='sudo dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Suspend' # works

# With Linphone - it's not working anymore
num="XX922026YY"; num="${num/XX/04}"; num="${num/YY/27}"
alias ETTelephoneMaison='linphone -c ${num}@crans.org'
function Appeler() {
    echo -e linphone -c "$1"@crans.org
    echo -e "Confirmez-vous l'appel au numéro $1 ?"
    read && linphone -c "$1"@crans.org
}

function PROXY () {
    case $1 in
        off)
            if pidof firefox >/dev/null; then
                echo -e "Opening 'about:preferences#advanced' in firefox, you should now disable the SOCKS v5 proxy ..."
                /usr/bin/firefox "about:preferences#advanced"
            else
                echo -e "Firefox is not running, I won't open it, but you should go to 'about:preferences#advanced'"
            fi
            rm -vf /tmp/startSocksProxy.list && echo -e "${green}PROXY is off.${white}"
            ;;
        on)
            startSocksProxy.sh && echo -e "${green}PROXY is on.${white}"
            ;;
        help|*)
            echo -e "PROXY on to activate the proxy, PROXY off to turn it off, PROXY help to print this help message."
            ;;
    esac
}

# Short shortcuts with hand-written Bash completions
complete -f -X '!*.@(html|md|mdown|markdown|mkdown|txt)' -o plusdirs strapdown2pdf strapdown2html.py
alias ax='autotex'
complete -f -X '!*.@(tex|pdf|PDF)' -o plusdirs autotex
alias P='PDFCompress'
complete -f -X '!*.@(pdf|PDF)' -o plusdirs P
function pdfinfo() { for i in "$@"; do echo -e "\n${green}# For '${red}${u}$i${U}${white}':"; /usr/bin/pdfinfo "$i"; done }
complete -f -X '!*.@(pdf|PDF)' -o plusdirs pdfinfo pdftk pdfgrep pdftohtml pdftotext

function f() { echo -e "Opening args '$@' in firefox..."; firefox "$@" || alert; }
function C() { echo -e "Opening args '$@' in chromium-browser..."; chromium-browser "$@" || alert; }
# Default to Python 3
function i2() { echo -e "Executing args '$@' with ipython2..."; ipython2 "$@" || alert; }
function i() { echo -e "Executing args '$@' with ipython3..."; ipython3 "$@" || alert; }
function i3() { echo -e "Executing args '$@' with ipython3..."; ipython3 "$@" || alert; }

function e() { echo -e "Opening args '$@' in evince..."; evince "$@" || alert; }
complete -f -X '!*.@(pdf|djvu|PDF|DJVU)' -o plusdirs e

alias m='clear ; make'
alias mB='clear ; make -B'
alias pdf='make pdf'        # special alias for Makefile-powered LaTeX projects
alias clean='make clean'    # special alias for Makefile-powered LaTeX projects
alias send_zamok='make send_zamok'
alias send_ws3='make send_ws3'
alias send_ovh='make send_ovh'

# Meta fonction experimentale pour ouvrir un fichier avec l'application appropriee.
function o() {
    if [ X"$1" == X"--help" ] || [ X"$1" == X"-h" ] || [ X"$1" == X"-?" ] || [ X"$1" == X"" ]; then
        echo -e "Use the alias o to open any file : o FILE1 [FILE2 [...]], or directory. mimeopen is used by default if my hand-made rules fail."
    else
        echo -e "${reset}Opening ${neg}${@}${Neg}...${reset}"
        for i in "$@"; do
            printf -- "- ${reset}For ${u}${i}${U}...${reset}"
            if [ -f "$i" ] ; then
                case "$(echo "$i" | tr '[:upper:]' '[:lower:]')" in
                    *.png|*.jpg|*.jpeg)
                        printf " using ${magenta}eog${reset} (alias ${cyan}eog${reset}) ... "
                        eog "$i";;
                    *.pdf)
                        printf " using ${magenta}evince${reset} (alias ${cyan}e${reset}) ... "
                        e "$i";;
                    *.mp3|*.ogg|*.mp4|*.avi|*.mkv)
                        printf " using ${magenta}mplayer${reset} ... "
                        mplayer "$i";;
                    *.html|*.svg|*.htm|*.php)
                        printf " using ${magenta}firefox${reset} (alias ${cyan}f${reset}) ... "
                        f "$i";;
                    *.txt|*.md|*.rst|*.py|*.ml|*.m|*.sh|*.tex|*.sty|*.log|.bash*|Makefile)
                        printf " using ${magenta}subl${reset} ... "
                        subl "$i";;
                    *)
                        printf " using ${red}mimeopen${reset} (${red}default${reset}) ... "
                        mimeopen "$i";;
                esac
            else
                echo "'$i' seems to not be a valid file, sorry."
            fi
        done;
        echo -e "${reset}Done opening ${black}${@}${reset}...${reset}"
    fi
}

alias RoupiesCourse='echo -e "${black}Requête à Wolfram|Alpha en cours..."; echo -e "${white}Le ${cyan}$(date)${white}, 1€ donne ${red}${u}$(wa.sh "1 EUR in INR" | grep -o "₹.*$" )${U}${white}." | tee -a /tmp/RoupiesCourse.log'
alias CHF_Course='echo -e "${black}Requête à Wolfram|Alpha en cours..."; echo -e "${white}Le ${cyan}$(date)${white}, 1€ donne ${red}${u}$(wa.sh "1 EUR in CHF" | grep -o "CHF[0-9.]*" | sed s/CHF// ) CHF${U}${white}." | tee -a /tmp/CHF_Course.log'

alias brigthness='xrandr --output LVDS --brightness '

alias FilesLog='find | tee find.log ; du | tee du.log ; dut | tee dut.log'
alias mario='vba --filter-lq2x ~/Public/roms/gba/mario.gba'

# flag to remove warning in 'sudo pip install [..]' and 'sudo pip3 install [..]'
alias sudo='sudo -H'

alias impressive='impressive.py --nologo --clock --tracking --transtime 0'
# alias slides='impressive'
alias slides='pdfpc'
complete -f -X '!*.@(pdf|djvu|PDF|png|PNG|jpg|JPG|jpeg|JPEG)' -o plusdirs impressive slides pdfpc

alias todo_message='for i in $(seq 1 1000); do figlet -w ${COLUMNS} ">  T O D O ,  T O D O ,  T O D O" | lolcat ; sleep 10s ; done'
alias timake='time make && alert'

# Shortcut for fast edit of .htaccess or .gitignore files (very common situation)
alias nhtaccess='nano .htaccess -Y sh'
alias ngitignore='nano .gitignore -Y sh'
alias ngitconfig='nano .git/config'

alias SHUTDOWN='mail_ghost.py "Automatically sent by the machine $HOSTNAME.crans.org when shutdown." "[LOG] ${USER}@${HOSTNAME} : shutdown"; mail_tel.py "Automatically sent by the machine $HOSTNAME.crans.org when shutdown." "[LOG] ${USER}@${HOSTNAME} : shutdown"; sudo shutdown now'
alias REBOOT='mail_ghost.py "Automatically sent by the machine $HOSTNAME.crans.org when reboot." "[LOG] ${USER}@${HOSTNAME} : reboot"; mail_tel.py "Automatically sent by the machine $HOSTNAME.crans.org when reboot." "[LOG] ${USER}@${HOSTNAME} : reboot"; sudo reboot now'
alias VEILLE='mail_ghost.py "Automatically sent by the machine $HOSTNAME.crans.org when fall asleep." "[LOG] ${USER}@${HOSTNAME} : going sleep"; GoingSleep.sh'
alias LOCK_NO_SLEEP='mail_ghost.py "Automatically sent by the machine $HOSTNAME.crans.org when going locked (but not asleep)." "[LOG] ${USER}@${HOSTNAME} : going locked"; GoingSleep.sh no'
alias Mail_LOG_save='mail.py "Automatically sent by the machine $HOSTNAME.crans.org when saving." "[LOG] ${USER}@${HOSTNAME} : save"'

export sublpath="$HOME/.config/sublime-text-3/Packages/User/"
export codepath="$HOME/.config/Code/User/"

alias openvpn_enscachan='cd ~/.local/share/openvpn/ ; sudo openvpn --config 32.conf'

# Experimental shortcuts, with ¹, ², è, à, @, ç, °, £, ^, ¨, ¤ etc. ?
alias µ='cd /tmp/'
alias ?='ExplainShell'  # try "? !!" for amazing result
# ^ for Push (git push) and v for Pull (git pull), as it looks like and ↑ ↓
alias ^='Push'
alias ↑='Push'
alias v='Pull'
alias ↓='Pull'

# In 2019, I sometimes forgot that Visual Studio Code cli is called 'code' and not 'vscode'...
alias visualstudiocode='code'
alias vscode='code'
# using 'GTK_IM_MODULE="xim" code' was working to remove the emoji input for me, but it broke my ` key...
# see https://askubuntu.com/questions/1046418/how-do-i-disable-emoji-input-in-ubuntu-mate-18-04/1269241#1269241
alias code='code'

export PYTHONIOENCODING='UTF-8'

# Manipulate raw timestamps (as used in ulogme)
function ppDay() { python -c "from datetime import datetime; d = datetime.fromtimestamp(int($1)); print(d.strftime('%A %d %B %Y'))"; }
function ppTime() { python -c "from datetime import datetime; d = datetime.fromtimestamp(int($1)); print(d.strftime('%A %d %B %Y, %r'))"; }

function help_remount() {
	echo -e "To remount a read-only partition as read-write, do this: \nsudo mount -o remount,rw /partition/identifier /mount/point"
}

function Wait.fr() {
	Wait "$@" french
}

alias url_encode='python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))"'
alias url_encode_plus='python3 -c "import urllib.parse, sys; print(urllib.parse.quote_plus(sys.argv[1]))"'
alias url_decode='python3 -c "import urllib.parse, sys; print(urllib.parse.unquote(sys.argv[1]))"'
alias url_decode_plus='python3 -c "import urllib.parse, sys; print(urllib.parse.unquote_plus(sys.argv[1]))"'

complete -f -X '!*.java' -o plusdirs javac
complete -f -X '!*.class' -o plusdirs java

# Get rid of that non-breaking space, http://hauweele.net/~gawen/blog/?p=32
# xmodmap ~/.Xmodmap  # => TODO: doesn't work!
setxkbmap -option "nbsp:none"  # DONE

##############################################################################
# (c) 2011-2021 Lilian BESSON
# Cr@ns: https://perso.crans.org/besson
# On Bitbucket:   https://bitbucket.org/lbesson/bin/
#
# Put a blank line after to autorize echo "alias newalias='newentry'" >> ~/.bash_aliases

