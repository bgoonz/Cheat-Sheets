#!/usr/bin/env bash
#
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date: 16/06/2017
# Web version: http://perso.crans.org/besson/bin/generateglisse.sh
# Web version (2): https://bitbucket.org/lbesson/bin/src/master/generateglisse.sh
#
# Auto generate an 'index.html' page to show photos with glisse.js
# Also generate a 'index.htm' page, which works on Windows by fetching the CSS and JS online (http://perso.crans.org/besson/_static/) and not locally (http://0.0.0.0/).
#
# FUTURE: use http://dimsemenov.com/plugins/magnific-popup/documentation.html#gallery instead, seems better.
#
# A demo is here : http://perso.crans.org/besson/generateglisse.sh/
# Last version is here : http://perso.crans.org/besson/bin/generateglisse.sh
# with stylesheets and templates is here : http://perso.crans.org/besson/bin/generateglisse/
#
version='1.1'

GenerateGlisse() {
    # Go to the directory.
    p=$(pwd)
    if [ -d "$*" ]; then cd "$*"; fi
    echo -e "Working for the directory ${magenta}$(pwd)${white}."
    # if [ -f index.html ]; then
    #  cp -vf index.html $(tempfile)
    #  mv -f index.html index.html~
    # fi

    # Header
    currentdir="$(basename "$(pwd -P)")"
    currentdir="${currentdir#./}"
    cat ~/bin/generateglisse/header.html \
        | sed s%VERSION%"$version"% \
        | sed s%CURRENTDIR%"$currentdir"% \
        | sed s%VERSION%"$version"% \
        | sed s_DATE_"$(date +" %d %b %Y, à %Hh:%Mm:%Ss")"_ > index.html

    # Listing of sub directories (without .. ou .)
    targets=$(find . -maxdepth 1 -type d -iname '*'[A-Za-z]'*' 2>/dev/null)

    targets=${targets//' '/%20}
    targets="${targets//'&'/&amp;}"
    echo -e "$red$targets$white" > /dev/stderr

    if [ "X$targets" != "X" ]; then
        nombre=$(echo "$targets" | grep -c -o ./)
        if (( nombre > 1 )); then
            echo -e "<br><br><div class='subdirs'><h2>Liste des sous-dossiers (au nombre de $nombre) :</h2>" >> index.html
        else
            echo -e "<br><br><div class='subdirs'><h2>Liste du sous-dossier :</h2>" >> index.html
        fi

        echo -e "<span style='font-size: 140%; line-height: 140%'><ul>" >> index.html
        echo -e "<li><a href='..' title='Parent directory !'>..</a> (dossier parent)</li>" >> index.html

        for d in $targets; do
            dossier=${d//'%20'/ }
            dossier=${dossier//'&amp;'/&}

            subphotos=$(find "${dossier}" -maxdepth 1 -type f -iname '*'.jpg -o -iname '*'.png -o -iname '*'.gif -o -iname '*'.jpeg 2>/dev/null)
            nombrephotos=$(echo "$subphotos" | grep -c -o "\(jpg\|JPG\|png\|PNG\|gif\|GIF\|jpeg\|JPEG\)")
            subdirs=$(find "${dossier}" -maxdepth 1 -type d -iname '*'[A-Za-z]'*' 2>/dev/null)
            nombredirs=$(echo "$subdirs" | grep -c -o ./)
            nombredirs=$(( nombredirs / 2 )) # does not count itself ? FIXME

            # Adapt what to print according to the number of subdirs and photos
            if (( nombrephotos > 1 )); then
                if (( nombredirs > 1 )); then
                    echo -e "<li><a href='${d}/'>${dossier}</a> (${nombrephotos} photos, ${nombredirs} sous-dossiers)</li>" >> index.html
                elif (( nombredirs == 1 )); then
                    echo -e "<li><a href='${d}/'>${dossier}</a> (${nombrephotos} photos, 1 sous-dossier)</li>" >> index.html
                else
                    echo -e "<li><a href='${d}/'>${dossier}</a> (${nombrephotos} photos)</li>" >> index.html
                fi
            elif (( nombrephotos == 1 )); then
                if (( nombredirs > 1 )); then
                    echo -e "<li><a href='${d}/'>${dossier}</a> (1 photo, ${nombredirs} sous-dossiers)</li>" >> index.html
                elif (( nombredirs == 1 )); then
                    echo -e "<li><a href='${d}/'>${dossier}</a> (1 photo, 1 sous-dossier)</li>" >> index.html
                else
                    echo -e "<li><a href='${d}/'>${dossier}</a> (1 photo)</li>" >> index.html
                fi
            else
                if (( nombredirs > 1 )); then
                    echo -e "<li><a href='${d}/'>${dossier}</a> (${nombredirs} sous-dossiers)</li>" >> index.html
                elif (( nombredirs == 1 )); then
                    echo -e "<li><a href='${d}/'>${dossier}</a> (1 sous-dossier)</li>" >> index.html
                fi
            fi

            echo -e "For ${u}${dossier}${U}: ${yellow}${nombrephotos}${white} photos, ${magenta}${nombredirs}${white} subdirs."

        done
        echo -e "</ul></span></div><br><hr><br>" >> index.html
    fi

    # Listing of photos (and gallery) (with glisse.js)
    targets=$(find . -maxdepth 1 -type f -iname '*'.jpg -o -iname '*'.png -o -iname '*'.gif -o -iname '*'.jpeg 2>/dev/null)

    if [ "X${targets//'%20'/}" != "X" ]; then
        targets="${targets//' '/%20}"
        targets="${targets//'&'/&amp;}"
        nombre=$(echo "$targets" | grep -c -o "\(jpg\|JPG\|png\|PNG\|gif\|GIF\|jpeg\|JPEG\)")

        # Print the list of files.
        if (( nombre > 1 )); then
            echo -e "<br><br><h2>Liste des photos (au nombre de $nombre) :</h2>" >> index.html
        else
            echo -e "<br><br><h2>Une seule photo :</h2>" >> index.html
        fi
        # I prefer to use the gallery style, it is REALLY better than the stack one (and less cpu consuming)
        echo -e "<ul class='gallery'>" >> index.html
        # echo -e "<ul class='stack' data-count='$nombre'>" >> index.html

        for i in $targets; do
            title=${i//'%20'/ }

            # Other metadata about the file.
            # metadata=$(file -b -p "$title")
            metadata=$(identify "$title")
            # echo "metadata = $metadata"
            size=$(expr "$metadata" : ".*\( [0-9]\+x[0-9]\+\)")
            size=${size# }
            # echo "size = $size"
            # read
            # echo du: $(du -h "$title")
            filesize=$(du -h "$title" | grep -o "^[,0-9]\+[KMGT]b\?")
            # echo "filesize = $filesize"
            # read

            title=${title#./}
            # Remove extension
            title=${title%.jpg}
            title=${title%.JPG}
            title=${title%.gif}
            title=${title%.png}
            title=${title%.PNG}
            title=${title%.jpeg}
            title=${title%.JPEG}

            # Try to find the date of the photo. title=2013-11-19_14-06-41_657
            # Could use exiftool, but it is REALLY too slow !

            # jour=$(echo -e "${title}" | grep -o "20[0-9][0-9]-[0-9][0-9]-[0-9][0-9]")
            jour=${title:0:10}
            #jour=${jour:-2013-11-30}

            # heure=$(echo -e "${title}" | grep -o "_[0-9][0-9]-[0-9][0-9]-[0-9][0-9]_" | tr - : )
            heure=${title:10:9}
            heure=${heure//-/:}
            heure=${heure//_/}
            #heure=${heure:-00:00:00}

            title=${title//_/ }

            # Check if jour, heure are valid, otherwise use the picture's name to title
            if ( echo -e "${jour}T${heure}Z" | grep -o "20[0-9][0-9]-[0-9][0-9]-[0-9][0-9]T[0-9][0-9]:[0-9][0-9]:[0-9][0-9]Z" >/dev/null); then
                echo -e "<li><img width='192' height='144' class='glisse-lazy rotation' angle='0' size='${size}' filesize='${filesize}' jour='${jour}' heure='${heure}' data-original='${i}'>Le ${jour} à ${heure}.</li>" >> index.html
                echo -e "  Adding ${u}${i}${U}, jour: ${blue}${jour}${white}, heure: ${black}${heure}${white}, size: ${magenta}${size}${white}, filesize: ${cyan}${filesize}${white}"
            else
                echo -e "<li><img width='192' height='144' class='glisse-lazy rotation' angle='0' title='« ${title} »   (${i}, ${size} px, ${filesize})' data-original='${i}'>« ${title} »</li>" >> index.html
                echo -e "  Adding ${u}${i}${U}, title: ${blue}${title}${white}, size: ${magenta}${size}${white}, filesize: ${cyan}${filesize}${white}"
            fi
        done
        echo -e "</ul><br><hr>" >> index.html
    fi
    # Footer starts with a JS line and then a closed </script> balise
    pathtobechanged="$(pwd)"
    pathtobechanged="${pathtobechanged#/home/lilian/Music/}"
    cat ~/bin/generateglisse/footer.html \
     | sed s%PATHTOBECHANGED%"$pathtobechanged"% \
     >> index.html

    echo -e "index.html have been generated in ${magenta}$(pwd)${white}."

    # Come back.
    cd "$p"
}

targets=$(find . -type d)
targets=${targets//' '/%20}
echo -e "${blue}${targets}${white}" | less -r

# To find every concerned directory
for i in $targets; do
    direction=${i//'%20'/ }
    echo -e "For the directory ${blue}'${direction}'${white}........."

    ( time GenerateGlisse "${direction}" ) 2>&1 | tee "${direction}/generateglisse.log"
    grep -a "^real[0-9a-z \t\.]*" "${direction}/generateglisse.log" > "${direction}/generateglisse.time"
    # Coloring the log.
    cat "${direction}/generateglisse.log" \
        | sed s_"./"_"http://./"_ \
        | sed s%"/home/lilian/photos/"%"http://0.0.0.0/lns_photos/"% \
        | ansi2html \
        | sed s_"http://./"_"./"_ \
        | sed s_"http://./"_"./"_ \
        | sed s_"http://.http://"_"http://"_ \
        | sed s_"http://.http://"_"http://"_ \
        > "${direction}/generateglisse.html"
    cp "${direction}/index.html" "${direction}/index.html~"
    cat "${direction}/index.html~" \
        | sed s_TIMESPENT_"$(cat "${direction}/generateglisse.time")"_ \
        > "${direction}/index.html"

    # Make the index.htm page for Windows
    cat "${direction}/index.html" \
        | sed s_"0\.0\.0\.0"_"perso.crans.org/besson/"_g \
        | sed s_"/index.html"_"/index.htm"_g \
        | sed s_"Programme pour GNU/Linux"_"Page pour Windows®"_ \
        > "${direction}/index.htm"
done

# END
