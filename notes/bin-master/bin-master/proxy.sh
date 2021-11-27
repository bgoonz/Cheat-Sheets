#!/usr/bin/env /bin/bash
# (C) Lilian BESSON
# http://perso.crans.org/besson/bin/proxy.sh

# The domain to connect with
dom="${1:-ssh2.crans.org}"
shift

# The username to use
login="${1:-besson}"
shift

# The command to launch
mycommand="${1:-firefox}"
shift

# The args to pass to the command
args="${@:-monip.org}"

# Start the proxy only if required
if [[ $(grep "login:${login} port:23456 host:${dom}" /tmp/startSocksProxy.list 2>/dev/null) ]]; then
    echo -e "This SOCKS v5 Proxy  : login:${login} port:23456 host:${dom} is already running (according to /tmp/startSocksProxy.list)."
else
    echo -e "Starting SOCKS v5 Proxy : login:${login} port:23456 host:${dom} ... (press Enter to continue)"
    read
    xfce4-terminal --title="SOCKS v5 Proxy : login:${login} port:23456 host:${dom} ..." --command="ssh -p 443 -v -D 23456 -N ${login}@${dom} | tee /tmp/startSocksProxy.log || mv -f /tmp/startSocksProxy.list /tmp/startSocksProxy.list~" || mv -f /tmp/startSocksProxy.list /tmp/startSocksProxy.list~ &
    echo -e "login:${login} port:23456 host:${dom}" >> /tmp/startSocksProxy.list
fi

echo -e "Starting ${mycommand} with tsocks... (press Enter to continue)"
read

# tsocks firefox -new-instance "${args}"
tsocks "${mycommand}" "${args}"
