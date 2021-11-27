#!/usr/bin/env bash
# Un petit script Bash écrit à l'arrache...
# pour vérifier le programme d'une conférence...
#
# On veut vérifier que chaque article listé dans le fichier XLSX (argument $2)
# est présent UNE et UNE SEULE fois dans le programme en PDF (argument $1).
#
# set -eu
# set -o pipefail

pdf="$1"
echo -e "Using program '$pdf' ..."
pdf="../$pdf"
xlsx="$2"
echo -e "Using XL file '$xlsx'..."

# create temp files
outdir="test"
csv="${xlsx%.xlsx}.csv"
[ ! -d "$outdir" ] && mkdir -p "$outdir"
echo -e "Converting '$xlsx' to '$outdir/$csv'..."
if type in2csv &>/dev/null; then
    in2csv "$xlsx" 2>/dev/null > "$outdir"/"$csv"
    [ ! -f "$outdir"/"$csv" ] && exit 1
else
    echo -e "You should install 'csvkit', please do 'sudo pip install csvkit' and try again."
    exit 2
fi
cd "$outdir"

# get the column numbers for authors and title
titlescolumn=$(csvcut -n "$csv" | grep 'Title' | grep -o '[0-9]*')
titles="titles.csv"
[ -f "$titles" ] && rm -vf "$titles"
echo -e "Saving titles to $titles from column #$titlescolumn ..."
csvcut -c "$titlescolumn" "$csv" > "$titles"
echo -e "\n\n  ---- Looking for titles ----"

function check_this_title () {
    title="${1//\"/}"
    # echo -e "Should check title '$title' ..."
    short="${title:0:30}"
    count=$(pdfgrep -i -c "$short" "$pdf")
    if [ "${count:-0}" != 1 ]; then
        short="${title:0:20}"
        count=$(pdfgrep -i -c "$short" "$pdf")
        if [ "${count:-0}" != 1 ]; then
            echo -e "- Article titled '$title' not found (when looking for '$short')..."
        fi
    fi
}

# handle temp files
while read title; do
    check_this_title "$title"
done < "$titles"


echo -e "\n\n\n"


authorscolumn=$(csvcut -n "$csv" | grep 'Authors' | grep -o '[0-9]*')
authors="authors.csv"
[ -f "$authors" ] && rm -vf "$authors"
echo -e "Saving authors to $authors from column #$authorscolumn ..."
csvcut -c "$authorscolumn" "$csv" > "$authors"
echo -e "\n\n  ---- Looking for authors ----"

function check_this_authors () {
    author="$1"
    # echo -e "Should check authors '$author' ..."
    short="${author:0:40}"
    count=$(pdfgrep -i -c "$short" "$pdf")
    if [ "${count:-0}" != 1 ]; then
        short="${author:0:20}"
        count=$(pdfgrep -i -c "$short" "$pdf")
        if [ "${count:-0}" != 1 ]; then
            short="$(echo "$author" | grep -o '^[^;]*;' | tr -d ';')"
            count=$(pdfgrep -i -c "$short" "$pdf")
            if [ "${count:-0}" != 1 ]; then
                echo -e "- Authors '$author' not found (when looking for '$short')..."
            fi
        fi
    fi
}

while read author; do
    check_this_authors "$author"
done < "$authors"

# move temp files to /tmp/
cd ..
[ -d /tmp/"$outdir" ] && rm -rvf /tmp/"$outdir"
mv -vf "$outdir" /tmp/
