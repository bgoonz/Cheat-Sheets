#!/usr/bin/env bash
#
# Script to interpret the button#9 of my mouse (Dell with left/right button)
# works on Ubuntu, with this .xbindkeysrc file (http://perso.crans.org/besson/bin/.xbindkeysrc)
#

# log=/tmp/$(basename ${0})_$$.log
title=$(xdotool getwindowname $(xdotool getactivewindow))

# echo "Interpretation 'b:8 + Release' on the window with title '${title}' ..." | tee -a ${log}  # DEBUG

case $title in
    'Terminal - '*)
        # echo "Running 'tmux next-window' ..." | tee -a ${log}  # DEBUG
        tmux next-window
    ;;
    *' - Sublime Text')
        # echo "Running 'subl --background --command next_bookmark' ..." | tee -a ${log}  # DEBUG
        subl --background --command next_bookmark
    ;;
    *' - Mozilla Firefox')
       # echo "Doing 'xte 'keydown Alt_L' 'keydown Right' 'keyup Right' 'keyup Alt_L'' ..." | tee -a ${log}  # DEBUG
       xte 'keydown Alt_L' 'keydown Right' 'keyup Right' 'keyup Alt_L'
    ;;
    *)
       # echo "Doing nothing ..." | tee -a ${log}  # DEBUG
       # FIXME the key should still be sent to the running program!
    ;;
esac
