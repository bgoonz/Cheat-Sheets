#!/usr/bin/env python
# -*- coding: utf8 -*-

import urllib.request
import re
import json
import sys
response = urllib.request.urlopen(
    'https://scholar.google.fr/citations?user={}'.format(sys.argv[1]))
html = response.read()
m = re.search("<tbody(.*)</tbody>", str(html))

mm = re.findall(r"<tr class=\"gsc_a_tr\">(.*?)</tr>", m.group(0))
papers = []
for m in mm:
    xx = re.sub(r"<(.*?)>", r"£", m)
    xx = re.sub(r"£+", r"£", xx)
    yy = re.findall(r"£?(.*?)£", xx)
    paper = {
        "title": yy[0],
        "author": yy[1],
        "booktitle": yy[2],
    }
    papers.append(paper)

res = {"papers": papers}
print(json.JSONEncoder().encode(res))
