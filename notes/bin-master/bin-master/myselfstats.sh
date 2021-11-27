#!/usr/bin/env bash
clear
echo -e "${yellow}Basic selfstats results.${white}"
echo -e "  ${black}See ${u}https://github.com/gurgeh/selfspy#example-statistics${U} for more.${white}"
echo -e "  ${black}See ${u}https://naereen.github.io/selfspy-vis/${U} for graphs.${white}"

# Ratios
selfstats --human-readable --ratios
# Active program
selfstats --human-readable --pactive
# More ?
