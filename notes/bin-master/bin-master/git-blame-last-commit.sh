#!/usr/bin/env bash
# Author: Lilian BESSON, (C) 2016-oo
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date: 13-12-2016.
# Web: https://bitbucket.org/lbesson/bin/src/master/git-blame-last-commit.sh
#
# List the lines modified bthe last commit of a git repository.
#
# Usage: git-blame-last-commit.sh [FILES]
#
# Licence: MIT Licence (http://lbesson.mit-license.org).
version="0.3"

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
# set -euo pipefail
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
        --version | -v )
            JUSTVERSION='true'
            shift
            ;;
    esac
done

# Copyrights and options
echo -e "${green}$0 v${version} : copyright (C) 2016 Lilian Besson${white}"
echo -e "    ${black}You can find it online (${u}https://bitbucket.org/lbesson/bin/src/master/git-blame-last-commit.sh${U})${white}"
echo -e "    ${black}This is free software, and you are welcome to redistribute it under certain conditions.${white}"
echo -e "    ${black}This program comes with ABSOLUTELY NO WARRANTY; for details see ${u}http://lbesson.mit-license.org${U}${white}"
[ "X${JUSTVERSION}" = "Xtrue" ] && exit 0


# Requires git-extras
echo -e "\n${magenta}Working in the git repository ${white}${u}$(git summary | grep project)${U}."
# Find the 8-symbols hash of the last commit
commitid="$(git log|head -n1|less|sed 's/commit //'| sed -r "s:\x1B\[[0-9;]*[mK]::g")"

# Show the blame, either for one file or all
if [ "X$@" = "X" ]; then
    echo -e "${red}No file was given${white}, using all the files in the current directory (depth 1):"
    # for i in $(find . -maxdepth 1 -type f); do
    #     output=$(git blame "${i}" 2>/dev/null | grep --color=always "${commitid:0:8}")
    #     if [ "X$output" != "X" ]; then
    #         echo -e "  - ${blue}For the file${white} '${u}${i}${U}':"
    #         echo $output | less -r
    #     fi
    # done
    # git blame $(find . -maxdepth 1 -type f) | grep --color=always "${commitid:0:8}" | less -r
else
    git blame "$@" | grep --color=always "${commitid:0:8}" | less -r
fi

# This is better
echo -e "\n${black}Using ${green}'git show HEAD'${black}:${white}"
# git show HEAD | less -r
git show HEAD


# End of git-blame-last-commit.sh
