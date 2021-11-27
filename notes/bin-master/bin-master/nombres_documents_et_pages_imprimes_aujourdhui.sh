#!/bin/sh

wget --quiet 'http://127.0.0.1:631/jobs?which_jobs=completed' -O /tmp/cups_completed_jogs_log.html

nbdocs=$(html2text -width 1000 /tmp/cups_completed_jogs_log.html | grep -B 1 "$(date "+%a %d %b %Y")" | grep -c completed)
nbpages=$(html2text -width 1000 /tmp/cups_completed_jogs_log.html | grep -B 1 "$(date "+%a %d %b %Y")" | grep completed | awk ' { print $3 }' | grep -o "[0-9]*" | python -c 'import sys; print(sum(map(int, sys.stdin)))')

echo "- Nombre de documents : ${nbdocs}\n- Nombres de pages : ${nbpages}"
