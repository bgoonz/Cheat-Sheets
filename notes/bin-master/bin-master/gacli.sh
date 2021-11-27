#!/usr/bin/env bash
# (C) Lilian BESSON, 2014
# A command line Google Analytics client, to be included in other script
# Latest version of http://perso.crans.org/besson/bin/gacli.sh
#
script="${1}"
shift
url="http://perso.crans.org/besson/beacon/15/gacli/bin/${script}"
for a in "$@"; do
    url="${url}/${a}"
done
url="${url}/?pixel"

wget --quiet "${url}" -O /dev/null >/dev/null 2>/dev/null || curl -q "${url}" -o /dev/null >/dev/null 2>/dev/null || echo -e "'gacli.sh ${1} ${@}' failed to get ${url} on."$(date) > /tmp/gacli.sh.log
