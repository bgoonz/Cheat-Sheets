#! /usr/bin/env python3
# -*- coding: utf-8 -*-
""" Full screen mode for GMusicBrowser.

Start the UI, waits for update_ui.py to change it trough POST requests.

- *Date:* 09 January 2018.
- *Author:* Lilian Besson, © 2018.
- *Licence:* MIT Licence, https://lbesson.mit-license.org/.
"""

from __future__ import print_function, division  # Python 2 compatibility if needed

from subprocess import call

def cmd_gmusicbrowser(arg):
    return call(["gmusicbrowser", "-cmd", arg])

def cmd_Volumesh(arg):
    """Requires my Volume.sh script, download it from https://bitbucket.org/lbesson/bin/src/master/Volume.sh and place it somewhere in your PATH."""
    return call(["Volume.sh", arg])


from flask import Flask, request, render_template
app = Flask("Full screen mode for GMusicBrowser")
app.template_folder = '.'

action = None
data = {}

@app.route("/")
def hello():
    global action, data
    if action is None:
        pause()
        play()
    print("Server handles a '/' GET request...")  # DEBUG
    return render_template("template.html", action=action, data=data)

@app.route("/start", methods=['POST'])
def start():
    global action, data
    action = "start"
    data = request.form.to_dict()
    print("Server handles a '/start' POST request...")  # DEBUG
    print("request.form =", request.form)  # DEBUG
    return render_template("template.html", action=action, data=data)

@app.route("/stop", methods=['POST'])
def stop():
    global action, data
    action = "stop"
    data = request.form.to_dict()
    print("Server handles a '/start' POST request...")  # DEBUG
    print("request.form =", request.form)  # DEBUG
    return render_template("template.html", action=action, data=data)


@app.route("/prev", methods=['GET', 'POST'])
def prev():
    cmd_gmusicbrowser("PrevSong")
    return render_template("template.html", action=action, data=data)

@app.route("/play", methods=['GET', 'POST'])
def play():
    cmd_gmusicbrowser("Play")
    return render_template("template.html", action=action, data=data)

@app.route("/playpause", methods=['GET', 'POST'])
def playpause():
    cmd_gmusicbrowser("PlayPause")
    return render_template("template.html", action=action, data=data)

@app.route("/pause", methods=['GET', 'POST'])
def pause():
    cmd_gmusicbrowser("Pause")
    return render_template("template.html", action=action, data=data)

@app.route("/next", methods=['GET', 'POST'])
def next():
    cmd_gmusicbrowser("NextSong")
    return render_template("template.html", action=action, data=data)

@app.route("/volumedown", methods=['GET', 'POST'])
def volumedown():
    cmd_Volumesh("-")
    return render_template("template.html", action=action, data=data)

@app.route("/volumeup", methods=['GET', 'POST'])
def volumeup():
    cmd_Volumesh("+")
    return render_template("template.html", action=action, data=data)


def main():
    print("""Run this Flask app with the following bash lines:

    $ FLASK_APP=start_ui.py flask run
    """)

if __name__ == '__main__':
    main()