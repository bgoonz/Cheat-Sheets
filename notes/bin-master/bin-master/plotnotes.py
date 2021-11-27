#!/usr/bin/env python
# -*- coding: utf-8; mode: python -*-
""" A script to automatically plot notes for corrected written exams.

(C) Lilian BESSON ~ Janvier 2014
"""

from __future__ import print_function  # Python 2/3 compatibility !

try:
    try:
        from ansicolortags import printc as print
    except ImportError as e:
        print("Optional dependancy (ansicolortags) is not available, using regular print function.")
        print("  You can install it with : 'pip install ansicolortags' (or sudo pip)...")
        from ANSIColors import printc as print
except ImportError:
    print("Optional dependancy (ANSIColors) is not available, using regular print function.")
    print("  You can install it with : 'pip install ANSIColors-balises' (or sudo pip)...")


import sys
import csv as csv  #: To read .csv files
import numpy as np  #: To compute and use math tools
import pylab  #: To plot

#: Read the datas
csv_file = sys.argv[1]
csv_name = csv_file[:-3]

#: Load in the csv file
csv_file_object = csv.reader(open(csv_file, 'rb'))

#: Skip the fist line as it is a header
header = csv_file_object.next()

data = []
for row in csv_file_object:
    data.append(row)  # adding each row to the data variable
#: Then convert from a list to an array
data = np.array(data)

#: Just the notes
notes = data[::, 1].astype(np.float)
nbnotes = np.size(notes)

#: Sort decreasingly
ind = np.argsort(notes)
data = data[ind[::-1]]
notes = notes[ind[::-1]]

#: The grades are between 0 and this value. Default is the French convention: 20.
noteMax = 20

###################################################################
# I want now to produce annex files
f = file(csv_name + "table", 'w')
f.write("%% Notes from '%s'" % f.name)
for i in range(nbnotes):
    f.write("\n%s & %g/%i \\\\" % (data[i, 0], notes[i], noteMax))
    print("I wrote <blue>'%s & %g/%i \\\\'<white> in <u>%s<U>..." % (data[i, 0], notes[i], noteMax, f.name))

minimale = np.min(notes)
f = file(csv_name + "minimale", 'w')
f.write("%g/%i" % (minimale, noteMax))
print("I wrote the value of minimale (<cyan>%g<white>) to <u>%s<U>..." % (minimale, f.name))

argminimale = data[np.argmin(notes), 0]
f = file(csv_name + "argminimale", 'w')
f.write("%s" % argminimale)
print("I wrote the value of argminimale (<cyan>%s<white>) to <u>%s<U>..." % (argminimale, f.name))

maximale = np.max(notes)
f = file(csv_name + "maximale", 'w')
f.write("%g/%i" % (maximale, noteMax))
print("I wrote the value of maximale (<cyan>%g<white>) to <u>%s<U>..." % (maximale, f.name))

argmaximale = data[np.argmax(notes), 0]
f = file(csv_name + "argmaximale", 'w')
f.write("%s" % argmaximale)
print("I wrote the value of argmaximale (<cyan>%s<white>) to <u>%s<U>..." % (argmaximale, f.name))

moyenne = np.mean(notes)
f = file(csv_name + "moyenne", 'w')
f.write("%2.2g/%i" % (moyenne, noteMax))
print("I wrote the value of moyenne (<cyan>%2.2g<white>) to <u>%s<U>..." % (moyenne, f.name))

ecarttype = np.std(notes)
f = file(csv_name + "ecarttype", 'w')
f.write("%2.2g" % ecarttype)
print("I wrote the value of ecarttype (<cyan>%2.2g<white>) to <u>%s<U>..." % (ecarttype, f.name))

variance = np.var(notes)
f = file(csv_name + "variance", 'w')
f.write("%2.2g" % variance)
print("I wrote the value of variance (<cyan>%2.2g<white>) to <u>%s<U>..." % (variance, f.name))

###################################################################
# I want now to plot some graphics about the datas, with matplotlib
print("\nPloting some graphics from <u>%s<U> (<neg><green>%i student(s)<Neg><white>)..." % (csv_name + "csv", nbnotes))

#: Graph options
pylab.xlabel(u"Notes (entre $0$ et $%i$)" % noteMax)
pylab.ylabel(u"Nombre d'élève(s) ayant eu cette note")
pylab.title(u"Répartition des notes dans la classe")

pylab.xlim(0, noteMax)
pylab.xticks(np.arange(noteMax + 1))

xvalues, bins, patches = pylab.hist(notes, np.arange(noteMax + 1), range=(0., 20.), facecolor='blue', alpha=0.0)

pylab.ylim(0, xvalues.max() + 1)
pylab.yticks(np.arange(xvalues.max() + 1))

pylab.grid(True, alpha=0.3)

#: Print only little stars for grades really presents
idc = xvalues > 0
pylab.plot(bins[:-1][idc], xvalues[idc], 'g*--', linewidth=.5, markersize=18)

pylab.xticks(bins[:-1][idc])

# Tweak spacing to prevent clipping of ylabel
pylab.subplots_adjust(left=0.15)

# pylab.show()
pylab.savefig(csv_name + "pdf")
print("Ploting the grades repartition on an histogram: <u>" + csv_name + "pdf<U>")
pylab.draw()
pylab.clf()
