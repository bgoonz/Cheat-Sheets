#!/usr/bin/env bash
# Author: Lilian BESSON, (C) 2018-oo
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date: 22-03-2018.
# Web: https://bitbucket.org/lbesson/bin/src/master/ngrok_and_text_address.sh
#
# ngrok_and_text_address.sh: a script to launch ngrok (see http://ngrok.com/)
# every 8 hours, get the address, send it to my phone. Durty but efficient!
#
# Usage: ngrok_and_text_address.sh [protocol] [port]
#
# Example:
#  $ ngrok_and_text_address.sh http 5000
#
# Licence: MIT Licence (http://lbesson.mit-license.org).
version="0.1"

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -eu
# set -o pipefail

# help
function printhelp(){
    cat << EOF
ngrok_and_text_address.sh: a script to launch ngrok (see http://ngrok.com/)
every 8 hours, get the address, send it to my phone. Durty but efficient!

Usage: ngrok_and_text_address.sh [protocol] [port]

Example:
    ngrok_and_text_address.sh http 5000
EOF
    exit 0
}

[ -x ~/.color.sh ] && . ~/.color.sh
# Add here options
JUSTVERSION=false
for i in "$@"; do
    case "$i" in
        --version )
            JUSTVERSION=true
            shift
        ;;
        -h | --help )
            printhelp
        ;;
    esac
done

# if [ "${#@}" -lt 1 ]; then printhelp; fi

# check if ngrok is present
if ngrok --version > /dev/null; then
    echo -e "${green}ngrok is available: $(ngrok --version)${reset}"
else
    echo -e "${red}ngrok is unavaible${reset}, please install it from ${u}https://ngrok.com/download${reset}"
fi

# Copyrights and options
echo -e "${green}$0 v${version} : copyright (C) 2018 Lilian Besson"
echo -e "  You can find it online (https://bitbucket.org/lbesson/bin/src/master/Wait)"
echo -e "  This is free software, and you are welcome to redistribute it under certain conditions."
echo -e "  This program comes with ABSOLUTELY NO WARRANTY; for details see http://lbesson.mit-license.org${white}"
${JUSTVERSION} && exit 1

# Script
protocol="${1:-http}"
port="${2:-5000}"

nbhour_freeplan=8
# maxtime=30  # DEBUG
maxtime=$(( nbhour_freeplan * 60 * 60 - 30 ))

logfile="$(tempfile -s ngrok_and_text_address.log)"

function launch_ngrok_in_tmux_bottom_window() {
    if pidof ngrok > /dev/null; then
        echo -e "${red}ngrok running with pid $(pidof ngrok)...${reset}"
        pkill -9 ngrok
        echo -e "${blue}ngrok killed...${reset}"
    else
        echo -e "${blue}no ngrok running...${reset}"
    fi
    echo -e "Starting ngrok in a bottom pan (in tmux)..."
    tmux split-window -d "ngrok ${protocol} ${port}"
    echo -e "Sleeping 2 seconds..."
    sleep 2
    echo -e "OK, pid of ngrok is $(pidof ngrok), it seems to be running well..."
    # now get the address
    address=$(wget -q 'http://127.0.0.1:4040/inspect/http' -O - | grep -o 'http://[^.]*.ngrok.io')
    echo -e "${green}ngrok seems to be well running, with external address ${address}..."
    FreeSMS.py "From $(date "+%T - %D") until $(date -d "+${maxtime} seconds" "+%T - %D"), ngrok is running to open webservice '${protocol}://localhost:${port}/' with external address '${address}'.\\n- Sent by $(basename "$0") v${version}, using FreeSMS.py by Lilian Besson."
}

while true; do
    launch_ngrok_in_tmux_bottom_window
    sleep ${maxtime}
done

# End of ngrok_and_text_address.sh
