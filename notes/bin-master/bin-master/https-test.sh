#!/usr/bin/env bash
# Test for SSL verified site
 
# CPR : Jd Daniel :: Ehime-ken
# MOD : 2013-11-11 @ 11:23:30
# INP : $ ./https-test.sh {optional: domain.com}

if [ ! -z $1 ]; then
	site="$1"
else
	#site='tldp.org'		# http
	site='erado.com'	# https
fi

# are you SSL verified or not ... ?
[ '' != "$(echo $(echo ^D | telnet $site https 2> /dev/null) | awk '{print $3}')" ] \
	&& protocol='https' \
	|| protocol='http'

echo $protocol
