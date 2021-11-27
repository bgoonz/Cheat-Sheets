#!/bin/sh
## About:
#  This script define many useful colors code as Bash variables
#  Use this script with other GNU Bash scripts, simply by importing him with
#  $ . ~/.color.sh
#
## Web
#  Both are on https://bitbucket.org/lbesson/bin/
#  - https://bitbucket.org/lbesson/bin/src/master/.color.sh (to enable them)
#  - https://bitbucket.org/lbesson/bin/src/master/.nocolor.sh (to disable them)
#
## How to use it after?
#  For example, echo -e "${red}This part is red. ${blue}That's blue :) ${black}And black.${reset}${white}"
#  will print: This part is red. That's blue :) And black. <-- with colors!
#
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
export black="\033[01;30m"
export red="\033[01;31m"
export green="\033[01;32m"
export yellow="\033[01;33m"
export blue="\033[01;34m"
export magenta="\033[01;35m"
export cyan="\033[01;36m"
export white="\033[01;37m"
# Without bold colors
export Bblack="\033[02;30m"
export Bred="\033[02;31m"
export Bgreen="\033[02;32m"
export Byellow="\033[02;33m"
export Bblue="\033[02;34m"
export Bmagenta="\033[02;35m"
export Bcyan="\033[02;36m"
export Bwhite="\033[02;37m"
export Black="\033[40m"
# Background colors
export Red="\033[41m"
export Green="\033[42m"
export Yellow="\033[43m"
export Blue="\033[44m"
export Magenta="\033[45m"
export Cyan="\033[46m"
export White="\033[47m"
# Special effects
export blink="\033[05m"  # Start blinking
export Blink="\033[06m"  # Stop blinking
export nocolors="\033[0m"
export default="\033[39m"
export Default="\033[49m"
export italic="\033[3m"  # Start italic
export Italic="\033[23m"  # Stop italic
export b="\033[1m"  # Start bold
export B="\033[2m"  # Stop bold
export u="\033[4m"  # Start underline
export U="\033[24m"  # Stop underline
export neg="\033[7m"  # Start negative
export Neg="\033[27m"  # Stop negative
export clear="\033[2J"  # Clear screen
export el="\r\033[K"  # Erase line
export reset="\033[0;39;49m"  # Reset ?
export bell=""  # Alarm ?
export title="\033]0;"  # Change title
export warning="\033[01;31m\033[4m/!\\ \033[24m\033[39m"  # /!\ with colors
export question="\033[01;33m\033[4m/?\\ \033[24m\033[39m"  # /?\ with colors
export ERROR="\033[0;39;49m\033[01;31mERROR\033[39m"  # ERROR with colors
export WARNING="\033[0;39;49m\033[01;33mWARNING\033[39m"  # WARNING with colors
export INFO="\033[0;39;49m\033[01;34mINFO\033[39m"  # INFO with colors
# DONE
