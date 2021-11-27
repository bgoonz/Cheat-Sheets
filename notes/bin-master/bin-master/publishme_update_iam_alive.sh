#!/usr/bin/env bash
# Under MIT License, (c) Lilian Besson 2020
# https://bitbucket.org/lbesson/bin/

set -eu
set -o pipefail

notify-send "Building https://perso.crans.org/besson/index.fr.html ..."
cd ~/web-sphinx/

rm -vf -- ./index.*.rst~
git add -- index.*.rst

git commit -m "Auto updating https://perso.crans.org/besson/index.fr.html"
git push && clear

make && clear

notify-send "Updated https://perso.crans.org/besson/index.fr.html : YOUPI JE SUIS (ENCORE) VIVANT"
echo "Updated https://perso.crans.org/besson/index.fr.html : YOUPI JE SUIS (ENCORE) VIVANT" | lolcat
