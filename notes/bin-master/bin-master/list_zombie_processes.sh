#!/usr/bin/env bash
# Author: Lilian BESSON, (C) 2016-oo
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date: 19-10-2017.
# Web: https://bitbucket.org/lbesson/bin/src/master/list_zombie_processes.sh
#
# List the zombie processes, but do not kill any.
#
# Usage: list_zombie_processes.sh
#
# Licence: MIT Licence (http://lbesson.mit-license.org).
#
version="0.2"

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

[ -x ~/.color.sh ] && . ~/.color.sh
# Add here options
NOANSI='false'
JUSTVERSION='false'
JUSTHELP='false'
for i in "$@"; do
    case "$i" in
        --noansi )
            NOANSI='true'
            [ -x ~/.nocolor.sh ] && . ~/.nocolor.sh
            shift
            ;;
        --version | -v )
            JUSTVERSION='true'
            shift
            ;;
        --help | -h | -? )
            JUSTHELP='true'
            shift
            ;;
    esac
done

# Copyrights and options
if [ "X${JUSTVERSION}" = "Xtrue" ]; then
    echo -e "${green}$0 v${version} : copyright (C) 2016 Lilian Besson"
    echo -e "You can find it online (https://bitbucket.org/lbesson/bin/src/master/list_zombie_processes.sh)"
    echo -e "This is free software, and you are welcome to redistribute it under certain conditions."
    echo -e "This program comes with ABSOLUTELY NO WARRANTY; for details see http://lbesson.mit-license.org${white}"
    exit 0
fi

# Help
if [ "X${JUSTHELP}" = "Xtrue" ]; then
    echo -e "Usage: ${green}$0${white}: list the zombie process and their parent processes."
    exit 0
fi

# Main part
echo -e " => There is ${red}$(ps axo pid=,stat= | awk '$2~/^Z/ { print $1 }' | wc -l) zombie process(es)${white}."
echo ""
for processid in $(ps axo pid=,stat= | awk '$2~/^Z/ { print $1 }'); do
    # echo -e "${black}$(/usr/bin/pstree -p $processid | tail -n1)${white}:"
    /usr/bin/pstree -p -s $processid | tail -n2
done
echo -e "\nTo kill any of the zombie process, use:"
echo -e "$ kill [PROCESSID]"
echo -e "\nAnd if this fails:"
echo -e "$ kill [PARENT_PROCESSID]"
echo -e "\n${WARNING} It might kill a parent program brutally${white}"

# End of list_zombie_processes.sh
