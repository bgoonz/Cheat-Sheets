#!/bin/sh
# Use this script to give an order list of the 1-depth sub-folder of
# the current directory which are valid git repositories, hosted on github.
# The list is ordered alphabetically.
#
# (C) Lilian Besson, 2016

# Better: keep the trailing '.git/'
for d in $(find -maxdepth 1 -type d); do [ -f $d/.git/config ] && grep "github\.com.Naereen" $d/.git/config >/dev/null 2>/dev/null && echo $d; done | sort | sed s_'./'_''_
