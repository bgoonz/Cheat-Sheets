#!/usr/bin/env bash
# Author: Lilian BESSON, (C) 2017
# Email:  Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date:   17-02-2017.
# Web:    https://bitbucket.org/lbesson/bin/src/master/mp32ogg.sh
#
# Use command line soundconverter to convert .mp3 files to .ogg
#
# Usage: mp32ogg.sh [depth=1]
#   will find and convert all .mp3 files to .ogg
#   max depth = 1 by default, otherwise $1 (first command argument)
#
# Requirements: soundconverter
#
# Licence: MIT Licence (http://lbesson.mit-license.org).
#
version="0.1"

# More details at http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -o pipefail
# Use https://bitbucket.org/lbesson/bin/src/master/.color.sh to add colors in Bash scripts
[ -f ~/.color.sh ] && . ~/.color.sh

for i in "$@"; do
    case "$i" in
        --noansi | --noANSI )
            . ~/.nocolor.sh
            shift
        ;;
        --version | -v | -V )
            JustVersion="true"
            shift
        ;;
        --help | -h | -? )
            JustVersion="true"
            JustHelp="true"
            shift
        ;;
    esac
done

# Copyrights
echo -e "${cyan}$(basename "$0") v${version} : copyright (C) 2017 Lilian Besson${white}"
if [ "X${JustHelp}" = "Xtrue" ]; then
    cat << EOF
Use command line soundconverter to convert .mp3 files to .ogg

Usage: mp32ogg.sh [--help] | [depth=1]
  will find and convert all .mp3 files to .ogg
  max depth = 1 by default, otherwise $1 (first command argument)

Requirements: soundconverter

EOF
fi
if [ "X${JustVersion}" = "Xtrue" ]; then
    echo -e "  ${black}You can find it online (https://bitbucket.org/lbesson/bin/src/master/mp32ogg.sh)${white}"
    echo -e "  ${black}This is free software, and you are welcome to redistribute it under certain conditions.${white}"
    echo -e "  ${black}This program comes with ABSOLUTELY NO WARRANTY; for details see http://lbesson.mit-license.org${white}"
    exit 0
fi

# Variable
depth="${1:-20}"

function du() {
    du -h $* | sed s/'\t'/' : '/g
}

# First, visualize with...
echo -e "\n${yellow}Showing you the command I will execute ...${white}"
time find . -maxdepth $depth -type f -iname '*'.mp3 -exec echo soundconverter -t -b -j 4 -m audio/x-vorbis -s .ogg {} \;

echo -e "\n${green}OK to execute this?${white} [Enter or Ctrl+C]"
read || exit

# Then convert...
time find . -maxdepth $depth -type f -iname '*'.mp3 -exec soundconverter -t -b -j 4 -m audio/x-vorbis -s .ogg {} \;

# Finally, print and check
msg="Converting .mp3 to .ogg : done in $(pwd).\nNew files are $(find . -maxdepth $depth -type f -iname '*'.ogg -exec du {} \;)"
echo -e "$msg"
for command in notify-send FreeSMS.py; do
    echo -e "Executing :" "$command" "$msg" "..."  # DEBUG
    echo -e "\n${green}OK to execute this?${white} [Enter or Ctrl+C]"
    read || exit
    if type "$command" >/dev/null 2>/dev/null; then
        "$command" "$msg"
    fi
done

# Remove all .mp3 files if the .ogg have been converted correctly?
#for i in $(find . -maxdepth $depth -type f -iname '*'.ogg); do
#    j="${i%.ogg}.mp3"
#    echo -e "\n$(du ${j}) ---> $(du ${i})"
#    file "${i}"
#    rm -vi "${j}"
#done
