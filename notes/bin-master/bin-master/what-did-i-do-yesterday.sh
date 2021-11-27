#!/usr/bin/env bash
# From https://github.com/stephenmathieson/git-standup
# Date: 20-08-2016.
# Web: https://bitbucket.org/lbesson/bin/src/master/what-did-i-do-yesterday.sh
#
# Minimalist script to see what did you do yesterday (or DAYS before) in a git repository
#
# Usage: what-did-i-do-yesterday.sh [DAYS]
#
# Licence: MIT Licence (http://lbesson.mit-license.org).
version="0.1"

[ -f ~/.color.sh ] && . ~/.color.sh
# Add here options
NOANSI='false'
JUSTVERSION='false'
JUSTHELP='false'
ONELINE=''
for i in "$@"; do
    case "$i" in
        --noansi )
            NOANSI='true'
            [ -f ~/.nocolor.sh ] && . ~/.nocolor.sh
            shift
            ;;
        -v | --version )
            JUSTVERSION='true'
            shift
            ;;
        -h | --help | help )
            JUSTVERSION='true'
            JUSTHELP='true'
            shift
            ;;
        --oneline )
            ONELINE='--oneline'
            shift
            ;;
    esac
done

# Copyrights and options
if [ "X${JUSTHELP}" = "Xtrue" ]; then
    echo -e "\nUsage: what-did-i-do-yesterday.sh [DAYS]"
    echo -e "In a git repository"
fi
if [ "X${JUSTVERSION}" = "Xtrue" ]; then
    echo -e "${green}$0 v${version} : copyright (C) 2016 Lilian Besson"
    echo -e "  You can find it online (https://bitbucket.org/lbesson/bin/src/master/what-did-i-do-yesterday.sh)"
    echo -e "  This is free software, and you are welcome to redistribute it under certain conditions."
    echo -e "  This program comes with ABSOLUTELY NO WARRANTY; for details see http://lbesson.mit-license.org${white}"
    exit 0
fi

# Are we in a git repo?
git rev-parse --is-inside-work-tree &>/dev/null
if [[ $? != 0 ]]; then
    echo -e "${red}Not a git repository.${white}"
    exit 1
fi

AUTHOR=${AUTHOR:="$(git config user.name)"}

nbday="${1}"
if [[ X"${nbday}" = X ]]; then
    since=yesterday
    if [[ $(date +%u) == 1 ]] ; then
        since="3 days ago"
    fi
else
    since="${nbday} days ago"
fi

# git log --since "$since" --oneline --branches=* --author="$AUTHOR"
git log --since "$since" $ONELINE --branches=* --author="$AUTHOR"
