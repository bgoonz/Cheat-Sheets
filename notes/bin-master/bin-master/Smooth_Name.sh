#!/usr/bin/env bash
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date: 07-12-2016
# Web: https://bitbucket.org/lbesson/bin/src/master/Smooth_Name.sh
#
# A small script to rename all files in a directory semi-automatically.
# The main purpose is to smooth filenames in order for generatejplayer to work more nicely.
#
# WARNING: the files are renamed (ie. move in place) with no control : it might NOT work.
#
# Requires [smoothnameone.sh](https://bitbucket.org/lbesson/bin/src/master/smoothnameone.sh)
#
# Licence: GPL v3
#
version='1.5'
LANG='fr'
log=/tmp/$(basename "$0").log

# Options: --batch, --test, --onlyfiles
if [ "${1}" = "--batch" ]; then
    echo -e "Nothing asked to the user : batch mode (option --batch)."
    MV="mv -vf"
    shift
elif [ "${1}" = "--test" ]; then
    echo -e "Just a test (option --test)."
    MV="echo mv -vf"
    shift
elif [ "${1}" = "--onlyfiles" ]; then
    echo -e "Working only on files (option --onlyfiles)."
    MV="mv -vf"
    onlyfiles="true"
    shift
else
    MV="mv -vi"
fi

# Change sub-directory
allfolder=$(find . -type d -iname [\.0-9A-Za-z]'*')
allfolder="${allfolder//' '/%20}"

for folder in ${allfolder}; do
    folder="${folder//'%20'/ }"
    # folder="${folder#./}"
    newfolder="$(smoothnameone.sh "${folder}")"
    echo -e "${green}Working with the directory ${u}'${folder}'${U}.${white}"
    echo mv -vi "${folder}" "${newfolder}"
    $MV "${folder}" "${newfolder}"
    folder="${newfolder}"


    # Now I use inode, to fix https://bitbucket.org/lbesson/bin/issues/5/handle-new-lines-in-file-names
    # TODO use ls -i to get the inode (unique identifier of the file)
    # Cf. http://www.softpanorama.org/Tools/Tips/renaming_files_with_special_characters.shtml

    allinode="$(find ./"${folder}" -maxdepth 1 -type f -exec ls -i {} \; | grep -o "^[0-9]* ./" | sed s_' ./'_''_)"


    for INUM in ${allinode}; do
        # Example:
        # find . -type f -inum 31467125 -exec mv {} new_name.html \;

        file=$(find . -type f -inum "$INUM")
        echo -e "${black}Working with the file ${magenta}${u}'${file}'${U}${white}."

        # DONE? implement a small test, display a warning if the name of the file is weird
        nbline1=$(echo $file | wc -l)    # Without quotes
        nbline2=$(echo "$file" | wc -l)  # With quotes
        if [ $nbline1 -lt $nbline2 ]; then
            echo -e "  ${red}Warning${white}: this file might have weird characters in his name (I guess ${black}$(( nbline2 - nbline1 ))${white}) ..."
        fi

        localname="$(find . -type f -inum "$INUM")"  # The leading ./ has to be removed

        # Then use:
        # find . -inum "$INUM" mv {} "..."
        if [ "X$onlyfiles" = "Xtrue" ]; then
            find . -type f -inum "$INUM" -exec $MV {} ./"$(smoothnameone.sh --file ${localname:2})" \; 2>>$log
            # $MV "$file" "$(smoothnameone.sh --file "$file")" 2>>$log
            ## Réf: http://abs.traduc.org/abs-5.3-fr/ch19.html#ioredirref
        else
            # TODO add the second case without the option --file
            find . -type f -inum "$INUM" -exec $MV {} ./"$(smoothnameone.sh ${localname:2})" \; 2>>$log
            # $MV "$file" "$(smoothnameone.sh "$file")" 2>>$log
        fi
    done
done

# END
