#!/usr/bin/env bash
# From https://stackoverflow.com/questions/8608226/simulate-bash-snow-fall-script-in-ncurses-c

LINES=$(tput lines)
COLUMNS=$(tput cols)

declare -A snowflakes
declare -A lastflakes

clear

function move_flake() {
    i="$1"

    if [ "${snowflakes[$i]}" = "" ] || [ "${snowflakes[$i]}" = "$LINES" ]; then
snowflakes[$i]=0
    else
if [ "${lastflakes[$i]}" != "" ]; then
printf "\033[%s;%sH \033[0;0H " ${lastflakes[$i]} $i
        fi
fi

printf "\033[%s;%sH*\033[0;0H" ${snowflakes[$i]} $i

    lastflakes[$i]=${snowflakes[$i]}
    snowflakes[$i]=$((${snowflakes[$i]}+1))
}

trap clear EXIT

while true; do
    i=$(($RANDOM % $COLUMNS))
    move_flake $i
    for x in "${!lastflakes[@]}"; do
        move_flake "$x"
    done
done
