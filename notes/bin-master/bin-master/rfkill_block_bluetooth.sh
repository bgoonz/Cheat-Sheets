#!/bin/sh
# Author: Lilian BESSON, (C) 2018-oo
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date: 01-05-2018.
# Web: https://bitbucket.org/lbesson/bin/src/master/rfkill_block_bluetooth.sh
#
# Simply run 'rfkill block bluetooth' after $1 seconds (default 60).
#
# Licence: MIT Licence (http://lbesson.mit-license.org).

sleep "${1:-60}"
rfkill block bluetooth
