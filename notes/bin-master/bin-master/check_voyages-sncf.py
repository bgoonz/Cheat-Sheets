#! /usr/bin/env python3
# -*- coding: utf-8; mode: python -*-
""" EXPERIMENTAL Python 3.4+ script to check if a train ticket on https://www.voyages-sncf.com is available or not.

WARNING: this script is only here to play and experiment with it, and demonstrate what robobrowser can do, NOT to be ran really.

Requirement:
- RoboBrowser, https://robobrowser.readthedocs.io, pip install robobrowser


- *Date:* Tuesday 20 November 2018.
- *Author:* Lilian Besson, (C) 2016-2018.
- *Licence:* MIT Licence (http://lbesson.mit-license.org).
"""

from __future__ import print_function, division  # Python 2 compatibility if needed

from robobrowser import RoboBrowser as RB
import re
import json
from sys import exit, argv


# Create and compile now the required regexp
url_finder = re.compile(r'http[^"]*')
query_finder = re.compile(r"data.query = JSON.parse\('\{[^\n]*")
searchResponse_finder = re.compile(r"data.searchResponse = JSON.parse\('\{[^\n]*")


# url0 = "http://www.voyages-sncf.com//vsc/train-ticket/?_LANG=fr&site_country=FR&site_language=fr&ORIGIN_CITY=Toulon&DESTINATION_CITY=Paris%20%28Toutes%20gares%20intramuros%29&OUTWARD_DATE=31/05/2016&OUTWARD_TIME=15&INWARD_DATE=&INWARD_TIME=7&COMFORT_CLASS=2&DISTRIBUTED_COUNTRY=FR&NB_TYPO_ADULT=1&bookingChoice=train&PASSENGER_1=YOUNG&PASSENGER_1_CARD=MI1ST&PASSENGER_1_FID_PROG=&PASSENGER_1FID_NUM_BEGIN=&CODE_PROMO_1=&action:searchTravel=Rechercher"

URL_TEMPLATE = "https://www.voyages-sncf.com/vsc/train-ticket/?_LANG=fr&site_country=FR&site_language=fr&ORIGIN_CITY={ORIGIN_CITY}&DESTINATION_CITY={DESTINATION_CITY}&OUTWARD_DATE={DATE}&OUTWARD_TIME={OUTWARD_TIME}&INWARD_DATE=&INWARD_TIME=7&COMFORT_CLASS=2&DISTRIBUTED_COUNTRY=FR&NB_TYPO_ADULT=1&bookingChoice=train&PASSENGER_1=YOUNG&PASSENGER_1_CARD=MI1ST&PASSENGER_1_FID_PROG=&PASSENGER_1FID_NUM_BEGIN=&CODE_PROMO_1=&action:searchTravel=Rechercher"


# url1 = 'http://www.voyages-sncf.com/vsc/proposals/findProposals?hid='


def main(url, MY_OUTWARD_TIME):
    """ Go to the page 'url', find the next link to got, then extract the JSON query result, find the wanted train, and display the results.
    """
    MY_OUTWARD_TIME = MY_OUTWARD_TIME.replace('h', ':')
    # Create the web browser object
    b = RB(history=True, allow_redirects=True)
    # Open the page
    b.open(url)
    # Find the next page to go
    res = str(b.select('#url_redirect_proposals')[0])
    # # - First solution: manual search
    # offset = 4 + res.index('hid=')
    # length = 3
    # key = res[offset: offset + length]
    # print("key =", key)
    # next_url = url1 + str(key)
    # print("1. Next url =", next_url)
    # - Second solution: search with a regexp
    m = url_finder.search(res)
    next_url = m.string[m.start():m.end()]
    print("Next url =", next_url, "...")
    # Follow this url
    b.open(next_url)
    # Get the data.query part
    script = b.select('#vsc-preloaded-data-snippet')[0]
    content = script.contents[0]
    # 1. Search for the query to display it nicely again
    m = query_finder.search(content)
    jsontext = m.string[m.start():m.end()]
    # print(jsontext)
    beginning = "data.query = JSON.parse('"
    end = "');"
    query = jsontext[len(beginning): -len(end)]
    jsonrawstr = query.replace(r'\"', '"').replace(r'\'', "'")  # \" > ", \' > '
    # print(jsonrawstr)
    jsonobj = json.loads(jsonrawstr)
    print(json.dumps(jsonobj, sort_keys=True, indent=4))
    # 2. Search for the result
    m = searchResponse_finder.search(content)
    jsontext = m.string[m.start():m.end()]
    # print(jsontext)
    beginning = "data.searchResponse = JSON.parse('"
    end = "');"
    searchResponse = jsontext[len(beginning): -len(end)]
    # print(searchResponse)
    jsonrawstr = searchResponse.replace(r'\"', '"').replace(r'\'', "'")  # \" > ", \' > '
    # print(jsonrawstr)
    jsonobj = json.loads(jsonrawstr)
    print(json.dumps(jsonobj, sort_keys=True, indent=4))
    # 3. Affichage des horaires
    print("\nDifferents horaires :")
    horaires = [ i['departureDate'] for i in jsonobj['results'] ]
    for number, h in enumerate(horaires):
        print("Pour un train partant a :", h)
        prices = jsonobj['results'][number]['priceProposals']
        print("Differentes categories :", list(prices.keys()))
        for cat in list(prices.keys()):
            prix = prices[cat]['amount']
            print("\tCategorie", cat, "==> prix", prix, "euros.")
    # 4. Affichages des prix
    longueur_date = len('2016-05-29')
    jour = horaires[0][:longueur_date]
    # FIXED search the list of horaires to find it
    # number = 4
    try:
        montiming = jour + 'T' + MY_OUTWARD_TIME + ':00'
        # FIXME what if the train starts the next day?
        print("Cherche le train partant a l'heure", MY_OUTWARD_TIME)
        print("Date =", montiming)
        number = horaires.index(montiming)
    except:
        print("Aucun train partant a l'heure demandee, je considere le premier de la liste")
        number = 0  # First train
    montrain = jsonobj['results'][number]['priceProposals']
    categories = list(montrain.keys())
    print("\nCategories :", categories)
    if 'FLEX' in categories:
        print("OK je peux le prendre (categorie 'FLEX')")
        prix = montrain['FLEX']['amount']
        print("Prix =", prix, "euros")
        print("URL =", url)
        return 0
    else:
        print("Pas de billet en categorie 'FLUX' disponible ! ... Triste :-( !!")  # XXX keep this 'Triste' part, the bash companion script uses it !
        return 1


if __name__ == '__main__':
    print("TODO: finish this script !")
    # FIXED parse cli argument
    print("Lecture des arguments", argv)
    DATE = argv[1] + '/2018' if len(argv) > 1 and argv[1] else '25/12/2018'
    OUTWARD_TIME = argv[2] if len(argv) > 2 and argv[2] else '12'
    MY_OUTWARD_TIME = argv[3] if len(argv) > 3 and argv[3] else '17:43'  # XXX too specific
    ORIGIN_CITY = argv[4] if len(argv) > 4 and argv[4] else 'Toulon'  # XXX too specific
    # DESTINATION_CITY = argv[5] if len(argv) > 5 and argv[5] else 'Paris'  # XXX too specific
    DESTINATION_CITY = argv[5] if len(argv) > 5 and argv[5] else 'Paris%20%28Toutes%20gares%20intramuros%29'
    print("- Date : ", DATE)
    print("- Heure depart minimale pour la recherche : ", OUTWARD_TIME)
    print("- Heure depart voulue : ", MY_OUTWARD_TIME)
    print("- Ville depart :", ORIGIN_CITY)
    print("- Ville arrivee :", DESTINATION_CITY)
    url = URL_TEMPLATE.format(DATE=DATE, OUTWARD_TIME=OUTWARD_TIME, ORIGIN_CITY=ORIGIN_CITY, DESTINATION_CITY=DESTINATION_CITY)
    print("Utilisant url =", url)
    exit(main(url=url, MY_OUTWARD_TIME=MY_OUTWARD_TIME))

# End of check_voyages-scnf.com
