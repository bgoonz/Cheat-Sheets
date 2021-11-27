#!/usr/bin/env bash
#
# A simple Bash script to call check_site_selenium.py to download a URL, research a message inside the interpreted web page (with JavaScript support!), and continue doing so as long as the check_site_selenium.py returns 0 (= message was found).
#
# Use FreeSMS.py (https//github.com/Naereen/FreeSMS.py) to warn you by a SMS when the page has changed.
#
# - Copyright 2021 Lilian Besson
# - License MIT.
#
# Examples
# --------
# Use it like this:
#
# $ check_site_and_texto_if_changed_selenium.sh "$URL" "$message" "$success"

clear
URL="${1:-https://partners.doctolib.fr/hopital-public/perigueux/vaccination-covid?speciality_id=5494&enable_cookies_consent=1}"
message="${2:-ce centre n\'a plus de disponibilités}"
success="${3:-Peut être qu\'il y a des disponibilités désormais...}"

sleepTime=${4:-1800s}

echo "Launching this command regularly..."
echo "    " check_site_selenium.py "'$URL'" "'$message'" "'$success'"
echo -e "\n\n"

# XXX: no "do {} while" loop in Bash, let's cheat
check_site_selenium.py "$URL" "$message" "$success"
returncode=$?

while [ "X$returncode" == "X0" ]; do
    echo "'$message' still found in '$URL'..."
    echo -e "${black}Sleeping '$sleepTime'...${white}"
    date
    sleep "$sleepTime"
    echo -e "\n\n"
    check_site_selenium.py "$URL" "$message" "$success"
    returncode=$?
done;

FreeSMS.py "${URL} semble indiquer qu'il y a des disponibilités désormais. (le $(date))"
