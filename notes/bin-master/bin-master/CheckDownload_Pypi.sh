#!/usr/bin/env bash
# Author: Lilian Besson
# Email: lilian DOT besson AT normale DOT fr
# Date: monday 08/07/2013 at 14h:56m:39s
# Webaddress: http://perso.crans.org/besson/bin/CheckDownload_Pypi.sh
# License: GPL v3
#
# A simple script to count the number of downloads for a PyPi package
# WARNING this feature is now disabled on pypi.python.org/pypi
#

echo -e "${red}WARNING this feature is now disabled on pypi.python.org/pypi${reset}"
exit 2

if [ "X$1" = "X" ]; then
    # package='ANSIColors-balises'
    package='ansicolortags'
else
    package="$1"
fi

echo -e "${reset}${white}For the package ${neg}${package}${Neg} (hosted on ${u}https://pypi.python.org/pypi/${package}${U}) :"

webquery=$(wget https://pypi.python.org/pypi/"${package}" -q -O - | grep -Eo '<span>[0-9]*</span> downloads in the last.*')

if [ "X$?" = "X0" ]; then
    echo -e "${webquery}" | \
    sed s{'<span>'{' * '{g | \
    sed s{'</span>'{'\t'{g
else
    echo -e "${red}No connection${reset}${white}"
    exit 18
fi
