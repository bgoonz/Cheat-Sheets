#!/usr/bin/python3
# -*- coding: utf-8; mode: python -*-
"""Small script to put all the strings in arguments to title case, as specified by the New York Times Manual of Style.

Requirements:
- *titlecase*, installable from PyPi or GitHub:
  $ (sudo) pip install titlecase
  Cf. https://github.com/ppannuto/python-titlecase/

About:
- *Date:* 19/02/2017.
- *Author:* Lilian Besson, (C) 2017
- *Licence:* MIT Licence (http://lbesson.mit-license.org).
"""

from __future__ import print_function # Python 2 compatibility if needed

from sys import argv
try:
    from titlecase import titlecase
except ImportError:
    print("Install titlecase with 'pip install titlecase'...")  # DEBUG

if __name__ == '__main__':
    for v in argv[1:]:
        print(titlecase(v))
