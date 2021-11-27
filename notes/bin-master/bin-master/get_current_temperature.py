#! /usr/bin/env python3
# -*- coding: utf-8 -*-
""" A small Python script to download and print the current temperature in different places.

Used to get real-world numerical data for this demo.
MALIN: Multi-Arm bandit Learning for Iot Networks with GRC. Demo made by Lilian Besson, Rémi Bonnefoi, Christophe Moy. Presented at the ICT 2018 conference (http://ict-2018.org/call-for-demos/).
https://bitbucket.org/scee_ietr/malin-multi-arm-bandit-learning-for-iot-networks-with-grc/

- *Date:* 3 May 2018.
- *Author:* Lilian Besson, © 2018.
- *Licence:* MIT Licence (http://lbesson.mit-license.org).
"""

from __future__ import print_function, division  # Python 2 compatibility if needed

from os.path import expanduser, join, isfile
from datetime import datetime
from json import load, dump


try:
    from darksky import forecast
except ImportError as e:
    print("Install 'darksky' module with 'pip install git+https://github.com/lukaskubis/darkskylib'...")
    raise e


def save_data(time_of_data, data, filename):
    new_dict = {
        time_of_data: data,
    }
    old_data = load_data(filename)
    old_data.update(new_dict)
    with open(filename, "w") as fp:
        dump(new_dict, fp)
    return new_dict


def load_data(filename):
    old_data = dict()
    if isfile(filename):
        with open(filename, "r") as fp:
            old_data = load(fp)
    return old_data


def get_data(names, locations, key, verbose=True):
    data = []
    now = datetime.now()
    for name, location in zip(names, locations):
        weather = forecast(key, *location)
        temperature_in_F = weather['currently']['temperature']
        temperature_in_C = round((temperature_in_F - 32) * (5/9), 1)
        data.append({
            "name": name,
            "location": location,
            "temperature_in_C": temperature_in_C,
        })
        if verbose:
            print("\n- In {}, at location {}, the temperature is {}°C at time {:%Y-%m-%d %H:%M}".format(name, location, temperature_in_C, now))
    return weather['currently']['time'], data


def main(filename, names, locations, key, verbose=True):
    time_of_data, data = get_data(names, locations, key, verbose=verbose)
    save_data(time_of_data, data, filename)
    return time_of_data, data


if __name__ == '__main__':
    filename = "get_current_temperature.json"
    names, locations = [], []

    # https://www.google.fr/maps/place/Supélec/@48.1252316,-1.6255899,17z/
    name = "CentraleSupélec, Rennes, France"
    location = 48.1252316, -1.6255899
    names.append(name); locations.append(location)

    # # https://www.google.fr/maps/place/05100+Briançon/@44.8826142,6.6285124,16z/
    # name = "Briançon, France"
    # location = 44.8826142, 6.6285124
    # names.append(name); locations.append(location)

    # https://www.google.fr/maps/place/Palais+du+Grand+Large/@48.6516678,-2.0214016,17z/
    name = "ICT conference, Saint-Malo, France"
    location = 48.6516678, -2.0214016
    names.append(name); locations.append(location)

    with open(join(expanduser("~"), ".darksky_api.key"), "r") as f:
        key = f.readline()
        # print("Using key =", key)  # DEBUG

    data = main(filename, names, locations, key)
