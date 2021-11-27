#!/usr/bin/env python
# -*- coding: utf-8; mode: python -*-
"""
A minimalist script to print the (ordered) list of Bitbucket repositories for a user :

$ bitbucket_repolist.py pseudo
git_repo1
...
git_repoK

- Date: 29-11-2013.
- Author: Lilian Besson, (C) 2016.
- Online: https://bitbucket.org/lbesson/bin/
- Licence: MIT Licence (http://lbesson.mit-license.org).
"""

from __future__ import print_function  # Python 2/3 compatibility !
from json import load
from os import system
from sys import argv

# Read the pseudo from the command line, or use mine.
pseudo = argv[1] if len(argv) > 1 else "lbesson"
jsonfile = "bitbucket_{}.json".format(pseudo)
system("curl --silent https://bitbucket.org/api/1.0/users/" + pseudo + " > " + jsonfile)

b = load(open(jsonfile, 'r'))

# for i in b['repositories']:
#     print(i['slug'])
list_of_repo = sorted([i['slug'] for i in b['repositories']])
for i in list_of_repo:
    print(i)
