#!/usr/bin/env bash
# Author: Lilian BESSON, (C) 2018-oo
# Email: Lilian.BESSON[AT]centralesupelec[DOT]fr
# Date: 22-03-2018.
# Web: https://bitbucket.org/lbesson/bin/src/master/git-count-total-commit-in-all-repo.sh
#
# Minimalist script to print the total number of commit you did in ALL your git repositories
# It scans your HOME for '.git/config' files, and for each repo, look for commits from usernames given in arguments
#
# Usage: git-count-total-commit-in-all-repo.sh lbesson naereen
#
# Licence: MIT Licence (http://lbesson.mit-license.org).
version="0.1"

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
    echo -e "\nUsage: git-count-total-commit-in-all-repo.sh"
fi
if [ "X${JUSTVERSION}" = "Xtrue" ]; then
    echo -e "${green}$0 v${version} : copyright (C) 2018 Lilian Besson"
    echo -e "  You can find it online (https://bitbucket.org/lbesson/bin/src/master/git-count-total-commit-in-all-repo.sh)"
    echo -e "  This is free software, and you are welcome to redistribute it under certain conditions."
    echo -e "  This program comes with ABSOLUTELY NO WARRANTY; for details see http://lbesson.mit-license.org${white}"
    exit 0
fi

# first find list of all git repositories
# cd ~ >/dev/null
mainpwd="$(pwd)"

find . -type f -iname 'config' | grep -v '.git/modules' | grep '.git/config' | sed s_'/.git/config'_''_ > /tmp/list_gitconfig.txt

# then count for each
for dir in $(cat /tmp/list_gitconfig.txt); do
    echo -e "\n# For git project ${dir}:"
    cd "${dir}" >/dev/null
    for username in "$@"; do
        # Use my fork of git-count, to use a corrected version of clime
        # see https://github.com/moskytw/clime/pull/30
        # and https://github.com/moskytw/git-count/pull/6
        git-count -p y -a "${username}" | head -n1 | tee -a "/tmp/git-count-output-for-${username}.txt"
    done
    cd "${mainpwd}" >/dev/null
done

if type hr &> /dev/null; then
    hr -
fi

# finally count the total
for username in "$@"; do
    echo -e "\n# For user ${username}, total number of commit in last year is:"
    cat "/tmp/git-count-output-for-${username}.txt" | grep "$(date "+%Y")" | awk '{print $2}' | paste -sd+ - | bc
done

# end of git-count-total-commit-in-all-repo.sh
