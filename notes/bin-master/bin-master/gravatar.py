#!/usr/bin/env python
# -*- coding: utf-8; mode: python -*-
"""
A simple python implementation of Gravatar Image requests (using their API).

- Author: Lilian Besson, (C) 2013.
- Online: https://bitbucket.org/lbesson/bin/src/master/gravatar.py
- Licence: MIT Licence (http://lbesson.mit-license.org).
"""

from __future__ import print_function  # Python 2/3 compatibility !
# import code for encoding urls and generating md5 hashes
import urllib
import hashlib

# Set the default picture
# default = "http://perso.crans.org/besson/.besson.jpg"
default = "retro"

size = 256
secure = True


def gravatar(email, default=default, size=size, secure=secure):
    """
    gravatar(email, default=default, size=size, secure=secure) -> string"

    Return the URL of the gravatar picture associated with @email.
    @default: default picture to use if not available. Default is %s.
    @size: format to use (pixel x pixel). Default is %i.
    @secure: if true, the returned URL use https://secure.gravatar.com instead of http://www.gravatar.com. Default is %s."
    """ % (default, size, secure)
    if secure:
        gravatar_url = "https://secure.gravatar.com/avatar/" + hashlib.md5(email.lower()).hexdigest() + "?r=pg&"
    else:
        gravatar_url = "http://www.gravatar.com/avatar/" + hashlib.md5(email.lower()).hexdigest() + "?r=pg&"
    gravatar_url += urllib.urlencode({'d': default, 's': str(size)})
    return gravatar_url


if __name__ == '__main__':
    # Set the email address to check
    email = "lbessonATens-cachanDOTfr".replace("AT", "@").replace("DOT", ".")
    print("For the email adress " + email)
    print(gravatar(email))
    email = "ameliaDOTnoreenATgmailDOTcom".replace("AT", "@").replace("DOT", ".")
    print("For the email adress " + email)
    print(gravatar(email))
