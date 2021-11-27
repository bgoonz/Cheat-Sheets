#!/usr/bin/env python
# -*- coding: utf-8; mode: python -*-
"""
A minimalist script to select a color with the GTK ColorSelectionDialog tool.
The selected color is returned (printed) on the consol.

- Date: 02-06-2016
- Author: Lilian Besson, (C) 2016.
- Online: https://bitbucket.org/lbesson/bin/
- Licence: MIT Licence (http://lbesson.mit-license.org).
"""

from __future__ import print_function  # Python 2/3 compatibility !

from gi.repository import Gtk
import sys

if __name__ == '__main__':
    color_sel = Gtk.ColorSelectionDialog("GTK Color Picker (color-picker.py)")

    if len(sys.argv) > 1:
        if Gtk.gdk.Color(sys.argv[1]):
            color_sel.colorsel.set_current_color(Gtk.gdk.Color(sys.argv[1]))

    if color_sel.run() == Gtk.ResponseType.OK:
        color = color_sel.get_color_selection().get_current_color()
        # Convert to 8bit channels
        red = int(color.red / 256)
        green = int(color.green / 256)
        blue = int(color.blue / 256)
        # Format
        finalcolor = "%02x%02x%02x" % (red, green, blue)
        print(finalcolor.upper())

    color_sel.destroy()
