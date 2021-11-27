#!/bin/sh
# Use this script to give an order list of the 1-depth sub-folder of
# the current directory which are valid git repositories.
# The list is ordered alphabetically.
#
# (C) Lilian Besson, 2016

# ( for i in $(/bin/ls ./*/.git/config | sort | uniq); do echo "$i" | grep -o "\./[^/]*" ; done ) | grep -v "\./\.git" | sed s_'./'_''_
# Better: keep the trailing '.git/'
for d in $(find -maxdepth 1 -type d); do [ -f $d/.git/config ] && echo $d; done | sort | sed s_'./'_''_
