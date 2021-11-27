#!/usr/bin/env bash
#!/usr/bin/env bash
# author: Lilian BESSON
# email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# date: 18-05-2017
# web: https://bitbucket.org/lbesson/bin/src/master/random-gcal-events-to-call-some-friends.sh
#
# With a certain probability, Add a random event on your Google Calendar
# at a random time between 7pm and 9pm, to call a random friend (in a fixed list)
#
# Run it every morning, with a 'cron' job, with a well chosen probability
# so that you are sure to call your friends/parents/lawer regularly!
#
# Example:
# --------
# $ random-gcal-events-to-call-some-friends.sh
# Adding an event to your google calendar for calling 'Superman' ...
# -- gcalcli --calendar 'YOUR CALLENDAR' --title 'Appeler Superman' --where 'Depuis mon téléphone' --when 'today at 20:11' --duration 15 --description 'Événement rajouté automatiquement le jeudi 18 mai 2017, 23:55:00 (UTC+0200) par le script Bash random-gcal-events-to-call-some-friends.sh (https://bitbucket.org/lbesson/bin/src/master/random-gcal-events-to-call-some-friends.sh), écrit par Lilian Besson (https://bitbucket.org/lbesson), et distribué en ligne sous licence MIT (https://lbesson.mit-license.org/). Si ce script présente une erreur, merci de la signaler: https://bitbucket.org/lbesson/bin/issues/new. Bonne journée :-)' --reminder 5 add
# ...
# Done
# --------
#
# Note: the script is in English, but by default, the event is added in French
#
# Licence: MIT License, https://lbesson.mit-license.org/
#

# About: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

# Configure here the probability for an event to be added
# For instance, 0.15 ~= 1/7 so only one call request will be added every week, if the script runs every morning
probability="${1:-0.25}"

# Should we do something or cancel directly?
python -c "from sys import exit; from random import random as r; exit(int(r()<$probability))" || exit 0

# Configure here the people you might want to call, one by line
peoples="Parents\nà Gap\nà Paris"

# --> Select one to call
people="$(echo -e "${peoples}" | shuf | head -n1)"

# Hour
minute="$(python -c "from random import randint as r; print('%.2i' % r(0, 60))")"
hour="20:$minute"


# Now computing all the parameters for the gcalcli call
calendar="amelia"."noreen"@"gmail"."com"
title="Appeler ${people}"
where="Depuis mon téléphone - À vélo"
when="tomorrow at ${hour}"
duration="10"
description="Événement rajouté automatiquement le $(date) par le script Bash $(basename $0) (https://bitbucket.org/lbesson/bin/src/master/random-gcal-events-to-call-some-friends.sh), écrit par Lilian Besson (https://bitbucket.org/lbesson), et distribué en ligne sous licence MIT (https://lbesson.mit-license.org/). Si ce script présente une erreur, merci de la signaler: https://bitbucket.org/lbesson/bin/issues/new. Bonne journée :-)"
reminder="5"

echo -e "   Date: $(date)..."
echo -e "Adding an event to your google calendar for calling '$people' ..."
echo -- gcalcli --calendar "'${calendar}'" \
	--title "'${title}'" \
	--where "'${where}'" \
	--when "'${when}'" \
	--duration "${duration}" \
	--description "'${description}'" \
	--reminder "${reminder}" \
	--noprompt \
	add

echo -e "..."
# Calling gcalcli
gcalcli --calendar "${calendar}" \
	--title "${title}" \
	--where "${where}" \
	--when "'${when}'" \
	--duration "${duration}" \
	--description "${description}" \
	--reminder "${reminder}" \
	--noprompt \
	add

echo -e "Done"
# Done
