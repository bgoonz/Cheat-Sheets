#!/bin/sh
## About:
#  This script remove all the colors defined in my .color.sh script.
#  Use this script with other GNU Bash scripts, simply by importing him with
#  $ . ~/.nocolor.sh
#
## Web
#  Both are on https://bitbucket.org/lbesson/bin/
#  - https://bitbucket.org/lbesson/bin/src/master/.nocolor.sh (to disable them)
#  - https://bitbucket.org/lbesson/bin/src/master/.color.sh (to enable them)
#
## How to use it after?
#  For example, echo -e "${red}This part is red. ${blue}That's blue :) ${black}And black.${reset}${white}"
#  will print: This part is red. That's blue :) And black. <-- WITHOUT colors!
#
## Warning:
#  Removing the color aliases is NOT recursive: if a script calls a script using ~/.color.sh (or any ANSI color codes), it will not work.
#  You can pipe a colored command through ' | sed -r "s:\x1B\[[0-9;]*[mK]::g"' to remove all colors.
#
## Copyrigths:
#  (c) 2013-17, Lilian Besson
#
## From ANSIColors.py module, auto generated with -g option. (*i.e.* the command './ANSIColors.py --generate')
# About the convention for the names of the colors :
# * for the eight colors black, red, green, yellow, blue, magenta, cyan, white:
#  - the name in minuscule is for color **with bold** (example 'yellow'),
#  - the name starting with 'B' is for color **without bold** (example 'Byellow'),
#  - the name starting with a capital letter is for the backgroung color (example 'Yellow').
# * for the special effects (blink, italic, bold, underline, negative), **not always supported** :
#  - the name in minuscule is for **activate** the effect,
#  - the name starting in capital letter is for **desactivate** the effect.
# * for the other special effects (nocolors, default, Default, clear, el), the effect is **immediate** (and seems to be well supported).
#
#
## List of colors
# Text colors
export black=""
export red=""
export green=""
export yellow=""
export blue=""
export magenta=""
export cyan=""
export white=""
# Without bold colors
export Bblack=""
export Bred=""
export Bgreen=""
export Byellow=""
export Bblue=""
export Bmagenta=""
export Bcyan=""
export Bwhite=""
# Background colors
export Black=""
export Red=""
export Green=""
export Yellow=""
export Blue=""
export Magenta=""
export Cyan=""
export White=""
# Special effects
export blink=""  # Start blinking
export Blink=""  # Stop blinking
export nocolors=""
export default=""
export Default=""
export italic=""  # Start italic
export Italic=""  # Stop italic
export b=""  # Start bold
export B=""  # Stop bold
export u=""  # Start underline
export U=""  # Stop underline
export neg=""  # Start negative
export Neg=""  # Stop negative
export clear=""  # Clear screen
export el=""  # Erase line
export reset=""  # Reset ?
export bell=""  # Alarm ?
export title=""  # Change title
export warning=""  # /!\ with colors
export question=""  # /?\ with colors
export ERROR=""  # ERROR with colors
export WARNING=""  # WARNING with colors
export INFO=""  # INFO with colors
# DONE
