#! /usr/bin/env python
# -*- coding: utf-8; mode: python -*-

"""
PasteBox script for http://p.boxnet.eu/api/
Copyright (C) 2011 <sinuc at boxnet dot eu>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

pastebox.py is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with pastebox.py.  If not, see <http://www.gnu.org/licenses/>.
"""

from __future__ import print_function  # Python 2/3 compatibility !
import sys
import urllib.request
import urllib.parse
import urllib.error
import getopt

URL = 'http://p.boxnet.eu/'


class PasteBox:
    def __init__(self):
        self.replyid = 0
        self.mode = 'text'
        self.ttl = 86400
        self.authhash = None

    def create(self, content):
        VALUES = {'content': content,
                  'replyid': self.replyid,
                  'mode': self.mode,
                  'ttl': self.ttl}

        if self.authhash:
            VALUES['authhash'] = self.authhash

        data = urllib.parse.urlencode(VALUES)
        req = urllib.request.Request('%sapi/' % URL, data)
        response = urllib.request.urlopen(req)
        page = response.read()
        return '%s%s' % (URL, page.decode('utf-8').replace('\n', ''))

    def read(self, pasteid):
        if not self.authhash:
            url = '%s%s/download' % (URL, pasteid)
        else:
            url = '%s%s/%s/download' % (URL, pasteid, self.authhash)
        req = urllib.request.Request(url)
        try:
            res = urllib.request.urlopen(req)
        except urllib.error.HTTPError:
            res = None
        return res

    def stdout(self, pasteid):
        print("reading %s.." % pasteid)
        response = self.read(pasteid)
        if response:
            for i in response.readlines():
                print(i.decode('utf-8').replace('\n', ''))
        else:
            print("Paste does not exist")

    def download(self, pasteid):
        print("downloading %s.." % pasteid)
        response = self.read(pasteid)
        if response:
            x = open('pastebox_%s.txt' % pasteid, 'w')
            for line in response.readlines():
                x.write(line.decode('utf-8'))
            x.close()
            print('stored as: pastebox_%s.txt' % pasteid)
        else:
            print("Paste does not exist")


def usage():
    print("""
    Usage: pastebox.py <option> <pasteid|file> ..

    Options:
    --authhash=<authhash>   authentication hash for additional protection ([a-z0-9])
    --ttl=<ttl>             time to live in seconds
    -s|--stdout             print paste to stdout
    -d|--download           download and store to file

    Usage examples:
    lspci|pastebox.py        Upload input by piping
    pastebox.py foo.c bar.h  Upload several files
    pastebox.py --authhash=foo -s 1234  Print Paste to stdout using authhash
    """)


def main(argv):
    try:
        opts, args = getopt.getopt(argv, "sdh", ["stdout", "download", "mode=", "authhash=", "ttl=", "help"])
    except getopt.GetoptError:
        usage()
        sys.exit(2)

    paste = PasteBox()

    for opt, arg in opts:
        if opt in ("--mode"):
            if arg:
                paste.mode = arg
            else:
                print("You need to provide a mode see usage (--help)")
                sys.exit(2)

        if opt in ("--authhash"):
            if arg:
                paste.authhash = arg
            else:
                print("You need to provide an authhash see usage (--help)")
                sys.exit(2)

        if opt in ("--ttl"):
            if arg:
                paste.ttl = arg
            else:
                print("You need to provide the TTL see usage (--help)")
                sys.exit(2)

        if opt in ("-h", "--help"):
            usage()
            sys.exit()
        elif opt == '-s' or opt == '--stdout':
            for pasteid in args:
                paste.stdout(pasteid)
        elif opt == '-d' or opt == '--download':
            for pasteid in args:
                paste.download(pasteid)

    if not opts and args:
        for file in args:
            try:
                print("%s: %s" % (file, paste.create(''.join(open(file, 'r').readlines()))))
            except IOError:
                print("skipping %s: file does not exist" % file)

    if not sys.stdin.isatty():
        paste = paste.create(' '.join(sys.stdin.readlines()))
        print(paste)

if __name__ == "__main__":
    main(sys.argv[1:])
