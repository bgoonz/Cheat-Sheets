#! /usr/bin/env python3
# -*- coding: utf-8 -*-
""" Full screen mode for GMusicBrowser.

## Settings
In GMusicBrowser settings, under the tab "Plugins", enable the "Current song" plugin,
and use these two values for the two text boxes:

- Command to run when the song starts:
/home/lilian/bin/gmusicbrowser_fullscreen_info/update_ui.py start %t %a %l %y %d %n %f %c

- Command to run when the song stops:
/home/lilian/bin/gmusicbrowser_fullscreen_info/update_ui.py stop %t %a %l %y %d %n %f %c

Legend:
%t : title
%a : artist
%l : album
%y : year
%d : disk
%n : track number
%f : full path to the file
%c : full path to the album cover image

Of course, adapt the path to where you downloaded and saved gmusicbrowser_fullscreen_info.


- *Date:* 07 January 2018.
- *Author:* Lilian Besson, © 2018.
- *Licence:* MIT Licence.
"""

from __future__ import print_function, division  # Python 2 compatibility if needed
import sys
import requests

PROTOCOL = "http"
ADDRESS = "0.0.0.0"
PORT = "9999"
WEBAPPBASE = "{}://{}:{}/".format(PROTOCOL, ADDRESS, PORT)


def update_ui(start, data):
    return requests.post("{}{}".format(WEBAPPBASE, start), data=data)


def main(args):
    # Check that action is start or stop
    start = args[0] if len(args) > 0 else "start"
    if start not in ["start", "stop"]:
        return
    # Build data dict
    names = [
        "action",
        "title",
        "artist",
        "album",
        "year",
        "disk",
        "track",
        "filepath",
        "coverpath",
    ]
    names += ["unknown arg"] * (len(args) - len(names))
    # This is for DEBUG
    data = {}
    for name, arg in zip(names, args):
        # print(f"Argument of name '{name}' : {arg}")  # DEBUG
        if name != "action":
            if name == 'filepath' or 'coverpath':
                if arg.startswith('/home/lilian/Music/'):
                    arg = arg[len('/home/lilian/Music/'):]
            data[name] = arg
    return update_ui(start, data)


if __name__ == '__main__':
    main(sys.argv[1:])
