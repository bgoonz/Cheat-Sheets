#!/usr/bin/env bash
#
# __author__ = 'Lilian BESSON'
# __email__ = 'Lilian.BESSON[AT]ens-cachan[DOT]fr'
# __date__ = '29-09-2013'
#
# A small script to download informations from pgp.mit.edu
#
version='0.1'
LANG='en'

echo -e "${clear}${reset}$u$yellow .: Starting: Search GPG :.$reset" >/dev/stderr

search="${@:-lilian}"
echo -e "${cyan}Searching for ${white}${search}..." >/dev/stderr

url="http://pgp.mit.edu:11371/pks/lookup?search=${search}&fingerprint=on"
echo -e "${cyan}Searching on ${white}${url}..." >/dev/stderr

# Emails
echo -e "${yellow}Printing email addresses...${default}${reset}" >/dev/stderr
#wget --quiet "$url" -O - | grep -o "&lt;".*@.*"&gt;" | uniq | sort | sed s/'&lt;'/''/ | sed s/'&gt;'/''/
wget --quiet "$url" -O - | grep -o "&lt;".*@.*"&gt;" | uniq | sort | sed s/'&lt;'/''/ | sed s/'&gt;'/''/ | grep --color=always @

# DONE