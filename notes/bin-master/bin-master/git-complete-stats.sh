#!/usr/bin/env bash
# Tiny script to generate git statistics
# Author: https://github.com/esc
# From https://github.com/esc/git-stats/blob/master/git-stats.sh

LOGOPTS=()
END_AND_BEGIN=()

# Argument parsing
while [ -n "$1" ]; do
    case "$1" in
     "-s")
        shift
        END_AND_BEGIN+=("--after=$1")
    ;;
    "-e")
        shift
        END_AND_BEGIN+=("--before=$1")
    ;;
    "-w")
        LOGOPTS+=("-w")
    ;;
    "-C")
        LOGOPTS+=("-C")
        LOGOPTS+=("--find-copies-harder")
    ;;
    "-M")
        LOGOPTS+=("-M")
    ;;
    esac
    shift
done

# Test if the directory is a git
git branch &> /dev/null || exit 3

echo -e "$(basename $0): do statistics on this git repository."
echo -e "  From https://github.com/Naereen/git-stats/"
echo -e "\nNumber of commits per author:"
git --no-pager shortlog "${END_AND_BEGIN[@]}" -sn --all
AUTHORS="$(git shortlog "${END_AND_BEGIN[@]}" -sn --all | cut -f2 | cut -f1 -d' ')"

longtiret='----------------------------------------------------------------------------------------------------------'
for a in $AUTHORS; do
    echo -e "\n----------------${longtiret:0:${#a}}"
    echo -e "Statistics for: $a"
    echo -n "  - Number of files changed: "
    git log "${LOGOPTS[@]}" "${END_AND_BEGIN[@]}" --all --numstat --format="%n" --author="$a" | grep -v -e "^$" | cut -f3 | sort -iu | wc -l || true
    echo -n "  - Number of lines added: "
    git log "${LOGOPTS[@]}" "${END_AND_BEGIN[@]}" --all --numstat --format="%n" --author="$a" | cut -f1 | awk '{s+=$1} END {print s}' || true
    echo -n "  - Number of lines deleted: "
    git log "${LOGOPTS[@]}" "${END_AND_BEGIN[@]}" --all --numstat --format="%n" --author="$a" | cut -f2 | awk '{s+=$1} END {print s}' || true
    echo -n "  - Number of merges: "
    git log "${LOGOPTS[@]}" "${END_AND_BEGIN[@]}" --all --merges --author="$a" | grep -c '^commit' || true

done
