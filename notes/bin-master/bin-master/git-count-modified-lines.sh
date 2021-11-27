#!/usr/bin/env bash
# Author: Lilian BESSON, (C) 2016-oo
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date: 10-08-2016.
# Web: https://bitbucket.org/lbesson/bin/src/master/git-count-modified-lines.sh
#
# Minimalist script to print the number of new and deleted lines of every modified files in a git repository
# It helps to know how big the changes are before commiting them...
#
# Usage: git-count-modified-lines.sh
#
# Licence: MIT Licence (http://lbesson.mit-license.org).
version="0.3"

[ -f ~/.color.sh ] && . ~/.color.sh
# Add here options
NOANSI='false'
JUSTVERSION='false'
JUSTHELP='false'
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
    esac
done

# Copyrights and options
if [ "X${JUSTHELP}" = "Xtrue" ]; then
    echo -e "\nUsage: git-count-modified-lines.sh"
fi
if [ "X${JUSTVERSION}" = "Xtrue" ]; then
    echo -e "${green}$0 v${version} : copyright (C) 2016 Lilian Besson"
    echo -e "  You can find it online (https://bitbucket.org/lbesson/bin/src/master/git-count-modified-lines.sh)"
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

prefix="$(git rev-parse --show-prefix)"
p="$(pwd)/"
maingit="${p%$prefix}"

cd "${maingit}" &>/dev/null

# Start
echo -e "${yellow}${u}Modified files${U} in this git repository ...${white}"
files=$(git status --porcelain | grep '^ \?MM\?' | sed s/'^ \?MM\? '/''/)

for f in $files; do
    if [ -f "$f" ]; then
        echo -e "  ${f}"
    fi
done

for f in $files; do
    if [ -f "$f" ]; then
        echo -e "\n${blue}For the file${white} '${black}${u}${f}${U}${white}' :"

        nbplus=$(git diff --no-color -- "$f" | cat | grep -o '^+' | wc -l)
        echo -e "  + ${green}${nbplus}${white} ${magenta}new lines${white} ..."

        nbminus=$(git diff --no-color -- "$f" | cat | grep -o '^-' | wc -l)
        echo -e "  - ${red}${nbminus}${white} ${cyan}deleted lines${white} ..."
    fi
done

cd "${p}" &>/dev/null
echo -e "${reset}${white}"
