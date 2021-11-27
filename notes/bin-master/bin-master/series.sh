#!/usr/bin/env bash
#
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date: 10-06-2018
#
# A first try to automatize the selection of the "next" episode in your current TV serie.
#
# Requires VLC 2.0+.
# vrun is not yet included nor required (https://perso.crans.org/besson/bin/vrun)
#
# A bash completion file is available (https://perso.crans.org/besson/bin/series.sh.bash_completion)
#
version='0.8'
myname="$(basename "$0")"

# If possible, use ~/.color.sh (https://perso.crans.org/besson/bin/.color.sh)
[ -f ~/.color.sh ] && ( . ~/.color.sh ; clear )

previous="no"
next="no"
last="yes"

#
# command line options
#
for i in "$@"; do
    case "$i" in
        -h|--help|help)
            echo -e "$green${myname}$white --help | [options]"
            echo -e ""
            echo -e "Play the correct next (or last or previous) episode of your current TV show."
            echo -e ""
            echo -e "${u}Requirements:${U}"
            echo -e "    1. The program reads a file '${blue}~/current${white}', to look to the directory where that TV show is stored."
            echo -e "    2. Then it reads a '${blue}current_sXXeYY${white}' file on that directory, to know the current season and episode number."
            echo -e "       (if none is there, it assumes ${magenta}season XX=01${white} and ${magenta}episode YY=01${white})"
            echo -e "    3. And then it read a file on directory '${blue}Season_XX/${white}' of the form '${blue}*EYY*.{avi,mp4,mkv,AVI,flv,wma,rmvb}${white}'."
            echo -e ""
            echo -e "${u}Help:${U}"
            echo -e "    ${yellow}help$white   to print this help message (and quit)."
            echo -e ""
            echo -e "${u}Options:${U}"
            echo -e "    ${yellow}next$white   play the next one."
            echo -e "    ${yellow}previous$white   play the previous one."
            echo -e "    ${yellow}last$white   play the last one (default)."
            echo -e "    ${yellow}list$white   shows the location and number of the current episodes for your TV shows."
            echo -e ""
            echo -e "Copyrights: (c) Lilian Besson 2012-2017."
            echo -e "Released under the term of the GPL v3 Licence."
            echo -e "In particular, $myname is provided WITHOUT ANY WARANTY."
            exit 0
        ;;
        -n|--next|n|next)
            next="yes"
            echo -e "${cyan} option next found."
            last="no"
        ;;
        -p|--previous|p|previous)
            previous="yes"
            echo -e "${cyan} option previous found."
            last="no"
        ;;
        -l|--last|l|last)
            last="yes"
        ;;
        --list|list|--currents|currents|c)
            list="yes"
            echo -e "${cyan} option list found."
            last="no"
        ;;
        *)
        ;;
    esac
done

echo -e "${yellow}.: Lilian BESSON presents :.$white$reset"
echo -e "Automatic next episode player, v${version}.$white$reset"

# Detection of VLC 2.0+
#( vlc --version 2>/dev/null | grep VLC.*2\.0\.[0-9]*.* >/dev/null && echo -e "$green - vlc 2.0+    is in your $"PATH" :)$reset$white" ) || \
# echo -e "$red Error:$white vlc 2.0+ is not in your $"PATH

# Detection of vrun
#( vrun help | grep "VLM commands" >/dev/null && echo -e "$green - vrun     is in your $"PATH" :)$reset$white" ) || \
# echo -e "$red Error:$white vrun is not in your $"PATH

#
# Current Folder detection.
#
dflt="current_s01e01"

echo -e "Reading ~/current to see the current watched folder..."
current_path="$(cat ~/current || echo -e "$red Error: no ~/current file, using default current_path...$white" >/dev/stderr)"
current_path="${current_path:-~/Séries/TBBT/}"

#
# Go to the current folder
#
cd "$current_path" || ( echo -e "${red} Error:$white the folder $u$current_path$U ${red}is not available...$reset$white" ; exit 1 )

echo -e "${blue}I am now in $magenta'$(pwd -P)'$white\n"

#
# Find meta data about the possible next episode(s).
#
currents=$(find . -type f -iname current_'*')
[ "0$?" != "00" ] && echo -e "${red} Error:$white no ${black}current_$white file have been found...$reset$white"

for cu in ${currents:-$dflt}; do
    echo -e "${blue}I found '$magenta$cu$white' as possible ${black}current_$white file."

    cu2=$(echo "$cu" | tr '[:upper:]' '[:lower:]')
    cu2=${cu2#./current_}
    # dont care, lowercase every letters
    echo -e "sSSeEE    ---> $u$cu2$U"

    d=${cu2#s}; d=${d%e[0-9]*}
    echo -e "Season :  $d"

    e=${cu2#s[0-9]*e}
    e=${e#0*}
    #
    # Options.
    #
    # Handling previous one
    if [ "$previous" = "yes" ]; then
        if [ "$e" -gt 10 ]; then
            e=$(( e - 1 ))
        else
            e=0$(( e - 1 ))
        fi
        echo -e "${cyan} Playing the previous one.$white"
    fi

    # Handling next one
    if [ "$next" = "yes" ]; then
        if [ $e -ge 9 ]; then
            e=$(( e + 1 ))
        else
            e=0$(( e + 1 ))
        fi
        echo -e "${cyan} Playing the next one.$white"
    fi

    # Handling list of current TV shows
    # Print the current read/watched TV shows or movies
    Currents() {
        clear
        echo -e "${white}Listing ($myname list):"
        for i in ~/current*; do
            dir="$(cat "$i")"
            echo -e "\n$u$black~/$(basename "$i")$U$white\t ---> \t$blue${dir}$white"
            serie="$(basename "${dir}")"
            cu=$( find "${dir}" -type f -iname current'*' 2>/dev/null || echo -e "Disque Dur Externe ['${u}/media/lilian/Disque Dur - Naereen/${U}']: ${red}pas branché${white}." >/dev/stderr)
            cu2="$(basename "$cu" | tr '[:upper:]' '[:lower:]')"
            cu2=${cu2#current_}
            # echo -e "sSSeEE  ---> $u$cu2$U"
            d=${cu2#s}; d=${d%e[0-9]*}
            # echo -e "Season :  $d"
            e=${cu2#s[0-9]*e}
            e=${e#0*}
            if [[ "${d}${e}" != "" ]]; then
                echo -e "For « ${u}${cyan}${serie}${white}${U} », the last watched episode is ${Black}${red}Season ${d:-?}${white}, ${magenta}Episode ${e:-?}${Default}${white}."
            fi
        done
    }
    if [ "$list" = "yes" ]; then
        Currents
        exit 0
    fi

    # Handling last one
    if [ "$last" = "yes" ]; then
        if [ "$e" -ge 10 ]; then
            e=$e
        else
            e=0$e
        fi
        echo -e "${cyan} Playing the last one.$white"
    fi

    # If negative, -> 01
    [ "${e#0}" -le 0 ] && e=01

    echo -e "Episode:  $e"

    possibles=$(find . -type f -wholename '*'"$d"'*'/'*''[sS]'"$d"'*''[eE]'"$e"'*' | grep "\(avi\|mp4\|mkv\|AVI\|flv\|wma\|rmvb\)")

    [ "0$?" != "00" ] && \
    ( echo -e "${red} Error: no next files found for this $black$current_$white file." ; exit 2 )

    [ "0$possibles" = "0" ] && \
    ( echo -e "${red} Error: $"possibles" is empty: no next files for this $black$current_$white file." ; exit 3 )

    echo -e "---> ${blue}I found '${magenta}$possibles$white' as possible next episode(s)."

    # meta=$(cat $cu)
    # [ 0"$meta" = "0" ] && echo -e "${reset}No time start data in $magenta$cu$reset... Starting from the beginning.$reset$white"

    # New : pause GMusicBrowser or VLC before starting playing
    if type vrun &>/dev/null; then
        echo -e "${blue}Pausing VLC (with the vrun CLI tool)...${white}"
        pidof vlc &>/dev/null && ( vrun play && vrun pause ) || echo -e "${red}Warning: VLC not playing.${white}"
    fi
    if type gmusicbrowser &>/dev/null; then
        echo -e "${blue}Pausing GMusicBrowser (with the 'gmusicbrowser -cmd' CLI tool)...${white}"
        pidof gmusicbrowser &>/dev/null && gmusicbrowser -cmd Pause || echo -e "${red}Warning: GMusicBrowser not playing.${white}"
    fi

    # Idée : on pourrait sauvegarder la position de la lecture, afin de pouvoir reprendre exactement là où on en était.
    # À utiliser: format dernierFichierLu.1h02m23s.position
    # ==> 1*3600 + 02*60 + 23 = 3743s
    # ==> vlc --start-time 3743 dernierFichierLu.avi

    echo "Playing..."
    vlc --fullscreen --no-random --play-and-exit --quiet "$possibles" 2>/tmp/series.sh.log
    echo "Played."

    nextcu="./current_s${d}e${e}"

    [ "$cu" != "nextcu" ] && mv "$cu" "$nextcu"
    echo -e "${green}OK: the episode has been read, new one is $magenta$nextcu$white"

    if [ "$next" = "yes" ]; then
        icon="/usr/share/icons/hicolor/256x256/apps/vlc.png"
        [ ! -f "$icon" ] && icon="question"
        if zenity --timeout=10 --title="$myname $version" --ok-label="Suivant" --cancel-label="Non" --text="Continuer à lire l'épisode suivant ? Saison <b>${d}</b>, épisode <b>${e}</b>..." --window-icon="${icon}" --question ; then
            $0 next
        fi
    fi
done

echo -e "${yellow} .: Contact me at naereen[@]crans[.]org for any questions, proposals or bugs :.$reset$white"
# End of series.sh
