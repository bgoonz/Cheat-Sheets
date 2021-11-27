#!/usr/bin/env bash
# Author: Lilian BESSON, (C) 2016-oo
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date: 21-11-2016.
# Web: https://bitbucket.org/lbesson/bin/src/master/git-pull-brutal-force.sh
#
# Revert local changes in a git repository and force git pull.
# Warning: can be quite brutal. Use it carefully
#
# Usage: git-pull-brutal-force.sh
# Revert local changes in the current git rep.
#
# Licence: MIT Licence (http://lbesson.mit-license.org).
version="0.1"

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

[ -f ~/.color.sh ] && . ~/.color.sh
# Add here options
NOANSI=false
JUSTVERSION=false
for i in "$@"; do
    case "$i" in
        --noansi )
            NOANSI=true
            [ -f ~/.nocolor.sh ] && . ~/.nocolor.sh
            shift
            ;;
        --version )
            JUSTVERSION=true
            shift
            ;;
    esac
done

# Copyrights and options
echo -e "${green}$0 v${version} : copyright (C) 2016 Lilian Besson"
echo -e "You can find it online (https://bitbucket.org/lbesson/bin/src/master/git-pull-brutal-force.sh)"
echo -e "This is free software, and you are welcome to redistribute it under certain conditions."
echo -e "This program comes with ABSOLUTELY NO WARRANTY; for details see http://lbesson.mit-license.org${white}"
[ ${JUSTVERSION} = true ] && exit 1


# are we in a git repo?
git rev-parse --is-inside-work-tree &>/dev/null
if [[ $? != 0 ]]; then
    echo -e "${red}Not a git repository.${white}"
    exit 1
fi


# Script
echo -e "${red}Reversing local changes...${white}"
for i in $(git status --porcelain | grep ' M ' | sed s/' M '/''/); do echo -e git checkout -- $i; done
echo -e "OK ? [Enter]"
read
for i in $(git status --porcelain | grep ' M ' | sed s/' M '/''/); do git checkout -- $i; done


echo -e "${red}Removing new files...${white}"
for i in $(git status --porcelain | grep '?? ' | sed s/'?? '/''/); do echo -e mv -vf "$i" /tmp/; done
echo -e "OK ? [Enter]"
read
for i in $(git status --porcelain | grep '?? ' | sed s/'?? '/''/); do mv -vf "$i" /tmp/; done

# End of git-pull-brutal-force.sh
