#!/usr/bin/env bash
# Returns the title of the current active window
id=$(xdotool getactivewindow)
# Don't ask about the black magic on this line, I don't know what's going on
# curtitle=$(wmctrl -lpG | while read -a a; do w=${a[0]}; if (($((16#${w:2}))==id)) ; then echo "${a[@]:8}"; break; fi; done)
# echo $curtitle

xdotool getwindowname ${id}
