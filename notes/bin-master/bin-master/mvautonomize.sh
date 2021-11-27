#!/usr/bin/env bash
echo -e "$1"
file="$1"
desti="${file%__autonomize.en.tex}.en.tex"

# echo -e "TEST"
echo -e mv -vf "${desti}" "${desti}~"
echo -e mv -vf "${file}" "${desti}"

echo -e "Do it?"
# read
mv -vf "${desti}" "${desti}~"
mv -vf "${file}" "${desti}"

echo -e "git diff: ${desti}"
git diff "${desti}"
