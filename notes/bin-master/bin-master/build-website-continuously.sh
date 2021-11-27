#!/usr/bin/env bash
#
# Launch this script to build my website when there is a change in one file
#
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]crans[DOT]org
# Web version: https://perso.crans.org/besson/bin/build-website-continuously.sh
# Web version (2): https://bitbucket.org/lbesson/bin/src/master/build-website-continuously.sh
# Date: 2020-04-28 17:48
#
# Usage:
# $ build-website-continuously.sh
#

watch-file ~/web-sphinx/journal-de-bord-pendant-confinement-coronavirus-2020.fr.rst corona_virus_update_iam_alive.sh auto
