#! /usr/bin/env python3
# -*- coding: utf-8; mode: python -*-
""" EXPERIMENTAL Python 3.4+ script to check if a train ticket on www.voyages-sncf.com is available or not.

WARNING: this script is only here to play and experiment with it, and demonstrate what robobrowser can do, NOT to be ran really.

Requirement:
- RoboBrowser, http://robobrowser.readthedocs.io, pip install robobrowser

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

#URL_TEMPLATE = "http://www.voyages-sncf.com//vsc/train-ticket/?_LANG=fr&site_country=FR&site_language=fr&ORIGIN_CITY={ORIGIN_CITY}&DESTINATION_CITY={DESTINATION_CITY}&OUTWARD_DATE={DATE}&OUTWARD_TIME={OUTWARD_TIME}&INWARD_DATE=&INWARD_TIME=7&COMFORT_CLASS=2&DISTRIBUTED_COUNTRY=FR&NB_TYPO_ADULT=1&bookingChoice=train&PASSENGER_1=YOUNG&PASSENGER_1_CARD=MI1ST&PASSENGER_1_FID_PROG=&PASSENGER_1FID_NUM_BEGIN=&CODE_PROMO_1=&action:searchTravel=Rechercher"
URL_TEMPLATE = 'https://www.oui.sncf/vsc/train-ticket/?_LANG=fr&ORIGIN_CITY={ORIGIN_CITY}&DESTINATION_CITY={DESTINATION_CITY}&OUTWARD_DATE={DATE}&OUTWARD_TIME={OUTWARD_TIME}&DIRECT_TRAVEL_CHECK=1&COMFORT_CLASS=2&PASSENGER_1=YOUNG&PASSENGER_1_CARD=&PASSENGER_1_FID_PROG=&PASSENGER_1FID_NUM_BEGIN=&CODE_PROMO_1=&PASSENGER_1_CARD_NUMBER=&PASSENGER_1_CARD_BIRTH_DATE=&action:searchTravelLaunchTrain=Rechercher'
#EXEMPLE SANS CARTE PARTICULIERE TARIF NORMAL

# url1 = 'http://www.voyages-sncf.com/vsc/proposals/findProposals?hid='


def main(url, MY_OUTWARD_TIME_MINI, MY_OUTWARD_TIME_MAXI="23:59"):
    """ Go to the page 'url', find the next link to got, then extract the JSON query result, find the wanted train, and display the results.
    """
    MY_OUTWARD_TIME_MINI = MY_OUTWARD_TIME_MINI.replace('h', ':')
    MY_OUTWARD_TIME_MAXI = MY_OUTWARD_TIME_MAXI.replace('h', ':')
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
    #print(json.dumps(jsonobj, sort_keys=True, indent=4))

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
    #print(json.dumps(jsonobj, sort_keys=True, indent=4))

    """
    with open('output.json', 'w+') as f:
        json.dump(jsonobj, f, sort_keys=True, indent=4)
    """

    # 3. Affichage des horaires
    print("\nDifferents horaires :")
    horaires = [ i['departureDate'] for i in jsonobj['trainProposals'] ]
    print(horaires)
    for number, h in enumerate(horaires):
        print("Pour un train partant a :", h)
        prices = jsonobj['trainProposals'][number]['priceProposals']
        if len(prices) > 0:
            prix = prices[0]['amount']
            print("\tPrix TGV minimum", "=", prix, "euros.")
        else:
            print("\tTrain complet.")





if __name__ == '__main__':

    dictRecherche = {
        'ORIGIN_CITY': 'Paris',
        'DESTINATION_CITY': 'Laval',
        'DATE': '29/11/2018',
        'OUTWARD_TIME': '6',
        }

    MY_OUTWARD_TIME_MINI = '06:00' # pas utilisé pour le moment
    MY_OUTWARD_TIME_MAXI = '23:59' # pas utilisé pour le moment

    url = URL_TEMPLATE.format(ORIGIN_CITY=dictRecherche['ORIGIN_CITY'], DESTINATION_CITY=dictRecherche['DESTINATION_CITY'], DATE=dictRecherche['DATE'], OUTWARD_TIME=dictRecherche['OUTWARD_TIME'])
    print("Utilisant url =", url)
    exit(main(url=url, MY_OUTWARD_TIME_MINI=MY_OUTWARD_TIME_MINI, MY_OUTWARD_TIME_MAXI=MY_OUTWARD_TIME_MAXI))

