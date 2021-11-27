#!/usr/bin/env bash
#
# Launch this script to do "git pull" in Version-Jaune, every hour
# See https://github.com/Pokemon-via-GitHub-contre-Covid-2020-fr/Version-Jaune
#
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]crans[DOT]org
# Web version: https://perso.crans.org/besson/bin/launch-watch-git-pull-Version-Jaune.sh
# Web version (2): https://bitbucket.org/lbesson/bin/src/master/launch-watch-git-pull-Version-Jaune.sh
# Date: 2020-04-24 17:48
#
# Usage:
# $ launch-watch-git-pull-Version-Jaune.sh 15
#
# will do "git pull" every 15 minutes instead.
#

echo "Going to the folder ~/publis/Pokemon-via-GitHub/fr/Version-Jaune.git ..."
touch /tmp/Version-Jaune.log
cd /home/lilian/publis/Pokemon-via-GitHub/fr/Version-Jaune.git

watch_duration="${1:-60}"
duration="$((${watch_duration} * 60))"

watch \
    --interval "${duration}" \
    "git pull \
        | tee /tmp/Version-Jaune.log \
        && notify-send \
            'Pokémon Version Jaune' \
            'Pokémon Version Jaune : dernière sauvegarde récupérée depuis GitHub à \
                $(date)\
                \n\n\
                $(ls -larth /tmp/Version-Jaune.log)\
                \n\n\
                $(cat /tmp/Version-Jaune.log)\
            '\
       && \
       { \
           grep -v 'à jour' /tmp/Version-Jaune.log && \
           FreeSMS \
           'Pokémon Version Jaune : dernière sauvegarde récupérée depuis GitHub à \
                $(date)\
                \n\n\
                $(ls -larth /tmp/Version-Jaune.log)\
                \n\n\
                $(cat /tmp/Version-Jaune.log)\
            ';\
       }
    "
