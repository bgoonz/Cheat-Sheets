#!/usr/bin/env bash

URL=${1:-https://banques-ecoles.fr/}
sleepTime=${2:-30s}
OUT=$(tempfile)

wget --quiet "$URL" -O "$OUT"
sum=$(md5sum "$OUT")
othersum=$(md5sum "$OUT")
echo -e "date = $(date), sum = $sum, othersum = $othersum"

while [ "$sum" = "$othersum" ]; do
    sleep "$sleepTime"
    wget --quiet "$URL" -O "$OUT"
    othersum=$(md5sum "$OUT")
    echo -e "data = $(date), sum = $sum, othersum = $othersum"
done;

FreeSMS.py "La page $URL a changé à la date $(date)."
