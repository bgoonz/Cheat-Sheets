#!/usr/bin/env python
# -*- coding: utf-8; mode: python -*-
#
# Terminal visualization of 2D numpy arrays
# Copyright (c) 2009  Nicolas P. Rougier
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program.  If not, see <http://www.gnu.org/licenses/>.
# ------------------------------------------------------------------------------
"""
Terminal visualization of 2D numpy arrays
Using extended color capability of terminal (256 colors), the termimshow function
renders a 2D numpy array within terminal.
"""

from __future__ import print_function, division  # Python 2/3 compatibility !

import sys
import numpy as np

try:
    try:
        from ansicolortags import clearScreen
    except ImportError as e:
        print("Optional dependancy (ansicolortags) is not available, trying to import the old version (ANSIColors).")
        print("  You can install it with : 'pip install ansicolortags' (or sudo pip)...")
        from ANSIColors import clearScreen
except ImportError:
    print("Optional dependancy (ANSIColors) is not available, not using clearScreen().")
    print("  You can install it with : 'pip install ANSIColors-balises' (or sudo pip)...")

    def clearScreen():
        pass


class ColorMap:
    """ A colormap is used to map scalar values to colors. It is build by
        adding couples of (value,color) where value must be between 0 and 1.
        - The 'scale' method allows to specify the range of the colormap and
        - the 'color' method then returns a color for any value.
    """

    def __init__(self, colors, name=None):
        self.colors = colors
        self.min = 0
        self.max = 1
        if name:
            self.name = name
        else:
            self.name = "Default"

    def __str__(self):
        return "ColorMap (name = {}): min = {}, max = {}, colors = {}.".format(self.name, self.min, self.max, self.colors)

    def scale(self, vmin, vmax):
        self.min, self.max = vmin, vmax

    def color(self, value):
        """ Return the color corresponding to value. """
        if not len(self.colors):
            return (0, 0, 0)
        elif len(self.colors) == 1:
            return self.colors[0][1]
        elif value < self.min:
            return self.colors[0][1]
        elif value > self.max:
            return self.colors[-1][1]
        value = (value - self.min) / (self.max - self.min)
        sup_color = self.colors[0]
        inf_color = self.colors[-1]
        for i in range(len(self.colors) - 1):
            if value < self.colors[i + 1][0]:
                inf_color = self.colors[i]
                sup_color = self.colors[i + 1]
                break
        r = (value - inf_color[0]) / (sup_color[0] - inf_color[0])
        if r < 0:
            r = -r
        color = [sup_color[1][0] * r + inf_color[1][0] * (1 - r),
                 sup_color[1][1] * r + inf_color[1][1] * (1 - r),
                 sup_color[1][2] * r + inf_color[1][2] * (1 - r)]
        return color


# Some colormaps
CM_IceAndFire = ColorMap([(0.00, (0.0, 0.0, 1.0)),
                         (0.25, (0.0, 0.5, 1.0)),
                         (0.50, (1.0, 1.0, 1.0)),
                         (0.75, (1.0, 1.0, 0.0)),
                         (1.00, (1.0, 0.0, 0.0))], "Ice and Fire")
# ==> GAME OF THRONES !

CM_Ice = ColorMap([(0.00, (0.0, 0.0, 1.0)),
                   (0.50, (0.5, 0.5, 1.0)),
                   (1.00, (1.0, 1.0, 1.0))], "Ice")

CM_Fire = ColorMap([(0.00, (1.0, 1.0, 1.0)),
                    (0.50, (1.0, 1.0, 0.0)),
                    (1.00, (1.0, 0.0, 0.0))], "Fire")

CM_Hot = ColorMap([(0.00, (0.0, 0.0, 0.0)),
                   (0.33, (1.0, 0.0, 0.0)),
                   (0.66, (1.0, 1.0, 0.0)),
                   (1.00, (1.0, 1.0, 1.0))], "Hot")

CM_Grey = ColorMap([(0.00, (0.0, 0.0, 0.0)),
                    (1.00, (1.0, 1.0, 1.0))], "Grey")


def termimshow(Z, vmin=None, vmax=None, cmap=CM_Hot, show_cmap=True):
    """ Show a 2D numpy array using terminal colors. """

    if len(Z.shape) != 2:
        print("Cannot display non 2D array")
        return

    vmin = vmin or Z.min()
    vmax = vmax or Z.max()
    cmap.scale(vmin, vmax)

    # Build initialization string that setup terminal colors
    init = ''
    for i in range(240):
        v = cmap.min + (i / 240.0) * (cmap.max - cmap.min)
        r, g, b = cmap.color(v)
        init += "\x1b]4;%d;rgb:%02x/%02x/%02x\x1b\\" % (16 + i, int(r * 255), int(g * 255), int(b * 255))

    # Build array data string
    data = ''
    for i in range(Z.shape[0]):
        for j in range(Z.shape[1]):
            c = 16 + int(((Z[Z.shape[0] - i - 1, j] - cmap.min) / (cmap.max - cmap.min)) * 239)
            if (c < 16):
                c = 16
            elif (c > 255):
                c = 255
            data += "\x1b[48;5;%dm  " % c
            u = cmap.max - (i / float(Z.shape[0] - 1)) * ((cmap.max - cmap.min))
        if show_cmap:
            data += "\x1b[0m  "
            data += "\x1b[48;5;%dm  " % (16 + (1 - i / float(Z.shape[0])) * 239)
            data += "\x1b[0m %+.2f" % u
        data += "\n"

    sys.stdout.write(init + '\n')
    sys.stdout.write(data)


if __name__ == '__main__':
    dx, dy = .15, .15
    x = np.arange(-3.0, 3.75, dx)
    y = np.arange(-3.0, 3.75, dy)
    X, Y = np.meshgrid(x, y)

    # Example 1 :
    def func1(x, y):
        return (1 - x / 2 + x**5 + y**3) * np.exp(- x**2 - y**2)
    Z1 = np.array(func1(X, Y))
    print("Using color map : Hot.")
    termimshow(Z1, cmap=CM_Hot)
    print(raw_input("[Enter to continue]"))
    clearScreen()

    # Example 2 :
    def func2(x, y):
        return (1 - x / 4 + x**4 + y**3) * np.exp(- x**2 - y**2)
    Z2 = np.array(func2(X, Y))
    print("Using color map : IceAndFire.")
    termimshow(Z2, cmap=CM_IceAndFire)
    print(raw_input("[Enter to continue]"))
    clearScreen()

    # Example 3 :
    def func3(x, y):
        return (1 - x / 4 + x**2 + y**2) * np.exp(- x**2 - y**2)
    Z3 = np.array(func3(X, Y))
    print("Using color map : Ice.")
    termimshow(Z3, cmap=CM_Ice)
    print(raw_input("[Enter to continue]"))
    clearScreen()

    # Example 4 :
    def func4(x, y):
        return (1 - x / 4 + x**3 + y**1) * np.exp(- x**2 - y**2)
    Z4 = np.array(func4(X, Y))
    print("Using color map : Fire.")
    termimshow(Z4, cmap=CM_Fire)
    print(raw_input("[Enter to continue]"))
    clearScreen()

    # Example 5 :
    def func5(x, y):
        return (1 + 50 * y**2) * np.exp(- x**2 - y**2)
    Z5 = np.array(func5(X, Y))
    print("Using color map : Grey.")
    termimshow(Z5, cmap=CM_Grey)
