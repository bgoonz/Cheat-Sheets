#!/usr/bin/env bash
# Author: Lilian BESSON, (C) 2016-oo
# Email: Lilian.BESSON[AT]CentraleSupelec[DOT]fr
# Date: 13-01-2017.
# Web: https://bitbucket.org/lbesson/bin/src/master/newuser.sh
#
# One line description for this script.
#
# Usage: newuser.sh firstname_lastname ...
# Usage description for this script.
#
# Example: optionnal example for this script.
#
# Licence: MIT Licence (http://lbesson.mit-license.org).
version="0.1"

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail


# Script
usertocreate="$1"
grouptoassign="${2:-users}"

echo -e "Please use this temporary password: $(date +"%d%m%Y")"

# Create user
echo sudo adduser --ingroup "$grouptoassign" "$usertocreate"
echo "..."
sudo adduser --ingroup "$grouptoassign" "$usertocreate"

# Force a password change on first login
echo sudo passwd -e "$usertocreate"
echo "..."
sudo passwd -e "$usertocreate"

# If admin, add user to group sudo
if [ X"$grouptoassign" = X"admins" ]; then
    echo sudo adduser "$usertocreate" sudo
    echo "..."
    sudo adduser "$usertocreate" sudo
fi

echo -e "TODO: Send email to new user (id, password, IP, machine name)"

# End of newuser.sh
