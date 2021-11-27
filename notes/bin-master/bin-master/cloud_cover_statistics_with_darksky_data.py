#! /usr/bin/env python3
# -*- coding: utf-8 -*-
""" A small Python script to download and print statistics on historical weather data.

- *Date:* 18 January 2018.
- *Author:* Lilian Besson, © 2018.
- *Licence:* MIT Licence (http://lbesson.mit-license.org).
"""

from __future__ import print_function, division  # Python 2 compatibility if needed

from os.path import expanduser, join
from datetime import date, timedelta
from dateutil.parser import parse
from datetime import datetime as dt
from json import load, dump

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.dates import DayLocator, HourLocator, DateFormatter

try:
    from darksky import forecast
except ImportError as e:
    print("Install 'darksky' module with 'pip install git+https://github.com/lukaskubis/darkskylib'...")
    raise e


def get_data(location, key, delay=365):
    thisday = date.today()
    oneday = timedelta(days=1)
    alldata = {}
    all_cloud_cover = {}
    for d in range(delay):
        t = thisday.isoformat()
        if 'T' not in t:
            t += 'T12:00:00'
        try:
            with forecast(key, *location, time=t) as weather:
                alldata[thisday] = weather
                all_cloud_cover[thisday] = weather["daily"]["data"][0]["cloudCover"]
                print("For the day", thisday, "the 'cloudCover' index was", all_cloud_cover[thisday])
        except:
                all_cloud_cover[thisday] = np.nan
                print("Missing data for", thisday, "so using a nan... it won't be included in the plots!")
        thisday = thisday - oneday
    return alldata, all_cloud_cover


def save_data(all_cloud_cover, filename):
    new_dict = dict()
    for d, k in all_cloud_cover.items():
        new_dict[d.isoformat()] = k
    with open(filename, "w") as fp:
        dump(new_dict, fp)


def load_data(filename):
    with open(filename, "r") as fp:
        new_dict = load(fp)
        all_cloud_cover = dict()
        for d, k in new_dict.items():
            dt = parse(d.replace('T12:00:00', ''))
            all_cloud_cover[dt] = k
    return all_cloud_cover


def plot_data(all_cloud_cover, name, filename):
    Xs = np.array(list(all_cloud_cover.keys()))
    Ys = np.array(list(all_cloud_cover.values()))

    # Remove day where we couldn't find the data
    are_nans = np.isnan(Ys)
    Xs = Xs[~are_nans]
    Ys = Ys[~are_nans]

    fig, ax = plt.subplots()
    ax.set_title(f"Cloud cover index in {name}")
    ax.set_xlabel("Date")
    ax.set_ylabel("Cloud cover (0 is fully sunny, 1 is fully cloudy)")
    ax.plot_date(Xs, Ys, ms=5, marker='o', color='black')

    ax.fmt_xdata = DateFormatter('%Y-%m-%d')
    fig.autofmt_xdate()

    plt.show()
    plt.savefig(filename)
    print("Figure was saved to", filename)


def plot_data_by_weekday(all_cloud_cover, name, filename):
    count_of_weekday = np.zeros(7)
    data_by_weekday = np.zeros(7)
    mean_by_weekday = np.zeros(7)
    for x, y in all_cloud_cover.items():
        if not np.isnan(y):
            weekday = x.weekday()
            count_of_weekday[weekday] += 1
            data_by_weekday[weekday] += y
            # print("For weekday", weekday, "one more count with cloud_cover =", y)
    for weekday in range(7):
        mean_by_weekday[weekday] = data_by_weekday[weekday] / count_of_weekday[weekday]

    plt.figure()
    plt.title(f"Mean cloud cover index in {name}, in 2017")
    plt.xlabel("Day of the week")
    plt.ylabel("Mean cloud cover (0 is fully sunny, 1 is fully cloudy)")

    days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    x = np.arange(7)
    plt.bar(x, mean_by_weekday, color="gold")
    plt.xticks(x, days)
    plt.show()

    plt.savefig(filename)
    print("Figure was saved to", filename)


if __name__ == '__main__':
    # CentraleSupélec, campus of Rennes, France
    name = "CentraleSupélec, Rennes"
    # 48° 6' 36"N, 1° 40' 48"W
    # https://www.google.fr/maps/place/Supélec/@48.1252316,-1.6255899,17z/
    location = 48.1252316, -1.6255899

    # name = "Briançon, France"
    # location = 44.8826142, 6.6285124
    # # https://www.google.fr/maps/place/05100+Briançon/@44.8826142,6.6285124,16z/

    print("For localisation '{}' at location {}...".format(name, location))


    with open(join(expanduser("~"), ".darksky_api.key"), "r") as f:
        key = f.readline()
        print("Using key =", key)

    try:
        print("Trying to load the data from 'all_cloud_cover.json' ...")
        all_cloud_cover = load_data("all_cloud_cover.json")
        print("Success in loading the data from 'all_cloud_cover.json' ...")
    except:
        print("Failed to load the data from 'all_cloud_cover.json' ...")
        print("Using API to download data...")
        print(input("Enter to continue"))
        alldata, all_cloud_cover = get_data(location, key)
        print("Trying to save the data from 'all_cloud_cover.json' ...")
        save_data(all_cloud_cover, "all_cloud_cover.json")
        print("Success in saving the data from 'all_cloud_cover.json' ...")

    plot_data(all_cloud_cover, name, "all_cloud_cover.png")
    plot_data_by_weekday(all_cloud_cover, name, "cloud_cover_by_weekday.png")
    print("Done...")
