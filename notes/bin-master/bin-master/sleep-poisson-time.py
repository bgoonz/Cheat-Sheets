#! /usr/bin/env python2
# -*- coding: utf-8; mode: python -*-
""" A tiny Python script to call sleep for a random time, drawn from a Poisson distribution of a certain mean time.

Requirements:
- numpy.random (poisson) is needed.

About:
- *Date:* 20/02/2017.
- *Author:* Lilian Besson, (C) 2017.
- *Licence:* MIT Licence (http://lbesson.mit-license.org).
"""

from __future__ import print_function, division  # Python 2 compatibility if needed

import sys
from time import sleep
from numpy.random import poisson

MINUTE = 60
MEAN_TIME = 3 * MINUTE

# --- Main script

if __name__ == '__main__':
    mean_time = int(sys.argv[1]) if len(sys.argv) > 1 else MEAN_TIME
    waiting_time = poisson(mean_time)
    print("Sleeping for {:.3g} seconds ...".format(waiting_time))  # DEBUG
    sys.exit(sleep(waiting_time))

# End of sleep-poisson-time.py
