#!/usr/bin/env bash
#
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date: 18-01-2013
#
# A small script to download informations from pgp.mit.edu
#
version='0.1'
LANG='en'

echo -e ".: Starting: Search GPG :." >/dev/stderr

search="${@:-zelda}"
echo -e "Searching for ${search}..." >/dev/stderr

url="http://pgp.mit.edu:11371/pks/lookup?search=${search}&fingerprint=on"
echo -e "Searching on ${url}..." >/dev/stderr

# Emails
echo -e "Printing email addresses..." >/dev/stderr
wget --quiet "$url" -O - | grep -o "&lt;".*@.*"&gt;" | uniq | sort | sed s/'&lt;'/''/ | sed s/'&gt;'/''/
# echo -e "Disabled :("

# DONE
