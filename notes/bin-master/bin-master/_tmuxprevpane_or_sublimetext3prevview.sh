#!/usr/bin/env bash
#
# Script to interpret the ctrl + button#8 of my mouse (Dell with left/right button)
# works on Ubuntu, with this .xbindkeysrc file (http://perso.crans.org/besson/bin/.xbindkeysrc)
#

# log=/tmp/$(basename ${0})_$$.log
title=$(xdotool getwindowname $(xdotool getactivewindow))

# echo "Interpretation 'b:9 + Release' on the window with title '${title}' ..." | tee -a ${log}  # DEBUG

case $title in
    'Terminal - '*)
        # echo "Running 'tmux select-pane -t :.+' ..." | tee -a ${log}  # DEBUG
        tmux select-pane -t :.+
    ;;
    *' - Sublime Text')
        # echo "Running 'subl --background --command prev_view' ..." | tee -a ${log}  # DEBUG
        subl --background --command prev_view
    ;;
    *)
       # echo "Doing nothing ..." | tee -a ${log}  # DEBUG
       # FIXME the key should still be sent to the running program!
    ;;
esac
