#!/usr/bin/env bash
target="$@"
target2="${target// /%20}"
echo "Going to: firefox https://translate.google.fr/#auto/fr/$target"
/usr/bin/firefox https://translate.google.fr/#auto/fr/"$target2"
