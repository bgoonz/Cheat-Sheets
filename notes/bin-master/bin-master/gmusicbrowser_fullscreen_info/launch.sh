#!/usr/bin/env bash

cd /home/lilian/bin/gmusicbrowser_fullscreen_info/

FLASK_APP=start_ui.py flask run --host=0.0.0.0 --port=9999 &
#FLASK_PID=$?

[ -x notify-send ] && notify-send "Full screen mode for GMusicBrowser" "Mode plein écran pour GMusicBrowser bien lancé, ouvert dans Chromium"

#killflask(){
#    kill $FLASK_PID
#}
#trap killflask EXIT

chromium-browser http://0.0.0.0:9999/
