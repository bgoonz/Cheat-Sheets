#!/usr/bin/env python
# -*- coding: utf-8; mode: python -*-
"""
A simple (beta) Python tool to plot graphics from Wikipédia statistics.

- Date: 02-06-2016
- Author: Lilian Besson, (C) 2016.
- Online: https://bitbucket.org/lbesson/bin/src/master/wikistats.py
- Licence: GPLv3.

Examples
--------
>>> wikistats.py --help
Gives help

>>> wikistats.py "Professeur Xavier" fr
Will produce a graphic of visiting statistics for the page https://fr.wikipedia.org/wiki/Professeur_Xavier for the last 30 days

------

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

wikistats.py is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License v3 along with wikistats.py.
If not, see <http://perso.crans.org/besson/LICENSE.html>.
"""


from __future__ import print_function  # Python 2/3 compatibility !

# Pour détecter le langage par défault
import os
import sys

# Default values
language_default = os.getenv("LANG")[0:2]


def lang_to_text(lang, exception=False):
    """ lang_to_text(lang, exception=False) -> str

Convert a Wikipédia language code (two letters) to a English version of the language.

Example:
>>> lang_to_text("en")
'english'
>>> lang_to_text("fr")
'french'
    """
    if exception:
        try:
            # TODO improve this !
            return {"en": "english", "fr": "french"}[lang]
        except:
            "unknown"
    else:
        return {"en": "english", "fr": "french"}[lang]

latest = 30  # also 60 or 90 are available

template_url_default = "http://stats.grok.se/json/{language}/latest{latest}/{page}"

template_output_default = "{page}.{language}.json"


def download_json(page="JSON", language=language_default,
                  template_output=template_output_default,
                  template_url=template_url_default):
    """ download_json(page="JSON", template_output=template_output_default,                  language=language_default, template_url=templateurl_default) -> str

Download a JSON file.

@page: tell which Wikipédia page to lookup to.
@template_output: template string for the output JSON (.json) file.
@language: language to use for downloading the JSON.
@template_url: online page to use a format to download the JSON.

Example:
>>> download_json(page="France", language="en", template_output="{page}.en.json")
'France.en.json'

>>> download_json(page="France", language="fr", template_output="out_{page}.fr.json")
'out_France.fr.json'
    """
    from sys import stderr
    # To download the JSON file from the web
    # WARNING: https might not be supported
    import urllib2
    # To move the destination file to "/tmp/" if it is already there.
    import distutils.file_util

    url_to_download = template_url.format(page=page, language=language, latest=latest)
    outfile = template_output.format(page=page, language=language)

    try:
        stderr.write("\nWarning: The destination file '{outfile}' was already present in the current directory, now it is in {newfile}.\n".format(outfile=outfile, newfile=distutils.file_util.copy_file(outfile, "/tmp/")[0]))
    except distutils.file_util.DistutilsFileError:
        stderr.write("Perfect, apparently the destination file '{outfile}' is not there.\n".format(outfile=outfile))

    url_request = urllib2.urlopen(url_to_download)
    distutils.file_util.write_file(outfile, url_request.readlines())
    return outfile


def outfile_to_json(outfile_name):
    """ outfile_to_json(outfile_name) -> dir

    Try to dump and return the content of the file @outfile.
    """
    outfile = open(outfile_name)
    # To convert the content of this file in a Python dictionnary.
    import json
    try:
        json_obj = json.loads(outfile.readline())
    except ValueError:
        import string
        json_obj = json.loads(string.join(outfile.readlines()))
    return json_obj


def plot_stats_from_json(json_obj, graphic_name=None, graphic_name_template="{title}.{lang}.{ext}", ext="all", title=None):
    """ plot_stats_from_json(json_obj, graphic_name=None, graphic_name_template="{title}.{lang}.{ext}", ext="png") -> None

    Plot a couple of PNG/SVG/PDF statistics.

    .. warning:: Beta !
    """
    assert(ext in ["png", "svg", "pdf", "all"])

    title = title if title else json_obj["title"]
    lang = json_obj["project"]
    rank = json_obj["rank"]
    if rank == "-1":
        rank = "NA"

    if not graphic_name:
        graphic_name = graphic_name_template.format(title=title, lang=lang, ext=ext)

    views = json_obj["daily_views"]

    try:
        import datetime
        today = datetime.date.today()
        year, month, day = today.year, today.month, today.day
    except ImportError:
        year, month, day = "2016", "01", "01"

    # stats = {}
    data = []

    # We sort the keys by increasing dates
    for year_month_day in sorted(views, key=lambda s: s[-5:-3] + s[-2:]):
        # newkey = year_month_day[-5:-3] + "-" + year_month_day[-2:]
        # stats[newkey] = views[year_month_day]
        data.append([year_month_day, views[year_month_day]])
        # print("On {year}, the {date} the page \"{title}\" (lang={lang}) had {number} visitor{plural}.".format(date=newkey, number=stats[newkey], title=title, lang=lang, year=year, plural=("s" if stats[newkey]>1 else "")))

    # Now make a graphic thanks to this data
    print("A graphic will be produced to the file \"{graphic_name}\" (with the type \"{ext}\").".format(graphic_name=graphic_name, ext=ext))

    # We use numpy for the data manipulation and pylab for plotting (à la Matlab).
    import numpy
    import pylab
    data_old = data
    try:
        data = numpy.array(data)
    except:  # durty, almost impossible !
        print("Unable to convert data to a numpy array. Exiting now...")
        exit()

    # Just the numbers
    numbers = data[::, 1].astype(numpy.int)
    nbnumbers = numpy.size(numbers)

    print("The page \"{title}\", with language {lang}, has been ranked {rank}th on the {month}th month of {year}, for a total of {total} views.".format(title=title, lang=lang_to_text(lang, exception=True), rank=rank, month=month, year=year, total=sum(numbers)))

    # # Sort decreasingly (bad idea here)
    # ind = numpy.argsort(numbers)
    # data = data[ind]
    # numbers = numbers[ind]

    # Graph options
    pylab.xlabel("Dates from the last 30 days (at the {today})".format(today=datetime.date.today()))
    pylab.ylabel("Number of visitors")

    try:
        lang_name = "(in " + lang_to_text(lang, exception=False).capitalize() + ")"
    except KeyError:
        lang_name = "(unknown language)"
    pylab.title(u".: Visiting statistics for the Wikipedia page '{title}' {lang_name} :.\n (Data from http://stats.grok.se, Python script by Lilian Besson (C) 2014) ".format(title=title, lang_name=lang_name))

    # X axis
    pylab.xlim(1, nbnumbers + 1)
    pylab.xticks(range(nbnumbers + 1), [s[-2:] for s in data[:, 0]], rotation=70)
    # Y axis
    pylab.ylim(numbers.min() * 0.95, numbers.max() * 1.05)

    pylab.grid(True, alpha=0.4)

    # Compute (and plot) an (invisible) histogram
    # xvalues, bins, patches = pylab.hist(numbers, range(nbnumbers+1), alpha=0.0)
    bins = numpy.arange(start=1, stop=nbnumbers + 1)

    # We keep the days with visitors
    idc = numbers >= 0
    pylab.plot(bins[idc], numbers[idc], 'go--', linewidth=.5, markersize=5)

    # Tweak spacing to prevent clipping of ylabel
    pylab.subplots_adjust(left=0.15)  # bottom=0.5

#    pylab.show()  # only if interactive will testing
    # Plot the histogram on 3 files (png, svg, pdf)
    if ext == "all":
        graphic_name = "{title}.{lang}.".format(title=title, lang=lang)
        for ext in ["png", "svg", "pdf"]:
            pylab.savefig(graphic_name + ext, format=ext, dpi=600)
            print("Ploting the statistics on an histogram on the file \"{graphic_name}\".".format(graphic_name=graphic_name + ext))
            pylab.draw()
    # Otherwise use only the one given by the user
    else:
        pylab.savefig(graphic_name, format=ext, dpi=400)
        print("Ploting the statistics on an histogram on the file \"{graphic_name}\".".format(graphic_name=graphic_name))
        pylab.draw()
    pylab.clf()

    return views, data, data_old, numbers


def main(argv):
    """ main(argv) -> None

    Main function. Use the arguments of the command line."""

    # print("argv: ", argv)
    if "-h" in argv or "--help" in argv:
        print("wikistats.py --help|-h | page [language_code]")
        return 1

    language = argv[1] if len(argv) > 1 else language_default
    page = argv[0] if len(argv) > 0 else "Professeur Xavier"

    outfile = download_json(page=page, language=language)
    json_obj = outfile_to_json(outfile)

    views, data, data_old, numbers = plot_stats_from_json(json_obj, title=page)
    return 0


if __name__ == "__main__":
    sys.exit(int(main(sys.argv[1:])))
