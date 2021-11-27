#!/usr/bin/env bash
# Author: Lilian BESSON, (C) 2016-oo
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date: 05-01-2016.
# Web: https://bitbucket.org/lbesson/bin/src/master/writegood-bash.sh
#
# One script, merging the three Matt Might's writegood scripts
# From https://github.com/jonathanjouty/writegood-bash
# Inspired by Matt Might's scripts from http://matt.might.net/articles/shell-scripts-for-passive-voice-weasel-words-duplicates/
#
# Usage: writegood-bash.sh [extension [ext2 ..]
# Checks all the file having this extension in the current directory
#
# Example: writegood-bash.sh tex html sh
#
# Licence: MIT Licence (http://lbesson.mit-license.org).
version="0.1"

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
# set -o pipefail
# set -eu

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
        --version | -v | --help | -h )
            # Copyrights and options
            echo -e "${green}$0 v${version} : copyright (C) 2016 Lilian Besson"
            echo -e "You can find it online (https://bitbucket.org/lbesson/bin/src/master/writegood-bash.sh)"
            echo -e "This is free software, and you are welcome to redistribute it under certain conditions."
            echo -e "This program comes with ABSOLUTELY NO WARRANTY; for details see http://lbesson.mit-license.org${white}"
            exit 0
            ;;
    esac
done

# # Script
# extension="${*:-tex}"

# echo -e "${black}Working on the files: ${white}"
# for ext in ${extension}; do
#     ls ./*."${ext}"
# done

# echo -e "\n1. ${yellow}Checking weasel words: ${white}"
# for ext in ${extension}; do
#     weasel ./*."${ext}"
# done
# echo -e

# echo -e "\n2. ${yellow}Checking passive voice: ${white}"
# for ext in ${extension}; do
#     passive ./*."${ext}"
# done
# echo -e

# echo -e "\n3. ${yellow}Checking (possible) duplicates words: ${white}"
# for ext in ${extension}; do
#     dups ./*."${ext}"
# done
# echo -e

# Script
files=${*:-$(ls ./*.tex)}

echo -e "${black}Working on the files: ${white}"
ls ${files}

echo -e "\n1. ${yellow}Checking weasel words: ${white}"
weasel ${files}
echo -e

echo -e "\n2. ${yellow}Checking passive voice: ${white}"
passive ${files}
echo -e

echo -e "\n3. ${yellow}Checking (possible) duplicates words: ${white}"
dups ${files}
echo -e

# End of writegood-bash.sh
