#!/usr/bin/env bash
# Author: Lilian BESSON, (C) 2016-oo
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date: 26-03-2016.
# Web: https://bitbucket.org/lbesson/bin/src/master/remove_trailing_spaces.sh
#
# Remove trailing spaces of all current files.
#
# Usage: remove_trailing_spaces.sh
# in the directory you want
#
# Reference http://stackoverflow.com/a/149081/5889533
#
# Licence: MIT Licence (http://lbesson.mit-license.org).
version="0.1"

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

. ~/.color.sh
# Add here options
NOANSI='false'
JUSTVERSION='false'
for i in "$@"; do
    case "$i" in
        --noansi )
            NOANSI='true'
            . ~/.nocolor.sh
            shift
            ;;
        --version )
            JUSTVERSION='true'
            shift
            ;;
        --help | -h | -? | -help )
            echo -e "${blue}USAGE: $0 [FILE1 [FILE2 ..]]${white}\n"
            JUSTVERSION='true'
            shift
            ;;
    esac
done

# Copyrights and options
clear
echo -e "${green}$0 v${version} : copyright (C) 2016 Lilian Besson"
echo -e "You can find it online (https://bitbucket.org/lbesson/bin/src/master/remove_trailing_spaces.sh)"
echo -e "This is free software, and you are welcome to redistribute it under certain conditions."
echo -e "This program comes with ABSOLUTELY NO WARRANTY; for details see http://lbesson.mit-license.org${white}"
[ "X${JUSTVERSION}" = "Xtrue" ] && exit 1

# Reference http://stackoverflow.com/a/149081/5889533
echo -e "${red}Listing all the files I will work on:${white} ..."
if [ X"$*" = "X" ]; then
    echo -e "${magenta}Using files given in ${red}./${white} ..."
    find ./* -type f -print -not -iwholename '.git/*'
    #
    echo -e "\n${green}Do you agree?${white}"
    echo -e "[Enter to continue]"
    read
    find ./* -type f -print0 -not -iwholename '.git/*' | xargs -0 perl -pi.backup -e 's/[ \t]+$//'
else
    echo -e "${magenta}Using files given in argument: '$*' ...${white}"
    find "$@" -type f -print -not -iwholename '.git/*'
    #
    echo -e "\n${green}Do you agree?${white}"
    echo -e "[Enter to continue]"
    read
    find "$@" -type f -print0 -not -iwholename '.git/*' | xargs -0 perl -pi.backup -e 's/[ \t]+$//'
fi

echo -e "Done. A backup file is available for each files with a '.backup' extension. Remove them or move them to /tmp/ ..."


# End of remove_trailing_spaces.sh
