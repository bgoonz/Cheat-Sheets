#! /usr/bin/env python2
# -*- coding: utf-8; mode: python -*-
""" Small experimental bot for our Slack team at SCEE (https://sceeteam.slack.com/), CentraleSupélec campus de Rennes.

It reads a file full of quotes (from TV shows), and post one randomly at random times on the channel #random.

Requirements:
- If progressbar (https://pypi.python.org/pypi/progressbar) is installed, use it.

About:
- *Date:* 13/02/2017.
- *Author:* Lilian Besson, (C) 2017
- *Licence:* MIT Licence (http://lbesson.mit-license.org).
"""

from __future__ import print_function, division  # Python 2 compatibility if needed

import sys
import os
import random
from os.path import join, expanduser
import time

import logging
logging.basicConfig(
    format="%(asctime)s  %(levelname)s: %(message)s",
    datefmt='%m-%d-%Y %I:%M:%S %p',
    level=logging.INFO
)

from numpy.random import poisson
from slackclient import SlackClient

# --- Parameters of the bot

MINUTES = 60
HOURS = 60 * MINUTES

QUOTE_FILE = os.getenv("quotes", expanduser(join("~", ".quotes.txt")))

SLACK_TOKEN = open(expanduser(join("~", ".slack_api_key")), 'r').readline().strip()

USE_CHANNEL = False  # DEBUG
USE_CHANNEL = True
SLACK_USER = "@lilian"
SLACK_CHANNEL = "#random"

MEAN_TIME = (12 * HOURS) if USE_CHANNEL else 30

URL = "https://bitbucket.org/lbesson/bin/src/master/my-small-slack-bot.py"

POSITIVE_REACTIONS = ['up', '+1', 'thumbsup']
NEGATIVES_REACTIONS = ['down', '-1', 'thumbsdown']


# --- Functions

def sleeptime(lmbda=MEAN_TIME, use_poisson=True):
    """Random time until next message."""
    if use_poisson:
        return poisson(lmbda)
    else:
        return lmbda


def sleep_bar(secs):
    """Sleep with a bar, or not"""
    try:
        # From progressbar example #3, https://github.com/niltonvolpato/python-progressbar/blob/master/examples.py#L67
        from progressbar import Bar, ETA, ProgressBar, ReverseBar
        widgets = [Bar('>'), ' ', ETA(), ' ', ReverseBar('<')]
        pbar = ProgressBar(widgets=widgets, maxval=100).start()
        for i in range(100):
            # do something
            time.sleep(secs / 110.)
            pbar.update(i)
        pbar.finish()
    except ImportError:
        time.sleep(secs)


def random_line(lines):
    """Read the file and select one line."""
    try:
        return random.choice(lines).replace('`', '').replace('_', '')
    except:  # Default quote
        logging.info("Failed to read a random line from this list with {} lines...".format(len(lines)))  # DEBUG
        return "I love you !"


def get_reactions(list_of_ts_channel, sc):
    """Get the reaction of users on all the messages sent by the bot, to increase or decrease the frequency of messages."""
    scale_factor = 1.
    try:
        for (ts, c) in list_of_ts_channel:
            # https://api.slack.com/methods/reactions.get
            reaction = sc.api_call(
                "reactions.get", channel=c, timestamp=ts
            )
            logging.debug("reaction =", reaction)
            if 'message' not in reaction:
                continue
            text = {t['name']: t['count'] for t in reaction['message']['reactions']}
            logging.info("text =", text)
            if any(s in text.keys() for s in POSITIVE_REACTIONS):
                nb = max([0.5] + [text[s] for s in POSITIVE_REACTIONS if s in text.keys()])
                logging.info("I read {} positive reactions ...".format(int(nb)))
                scale_factor /= 2 * nb
            elif any(s in text for s in NEGATIVES_REACTIONS):
                nb = max([0.5] + [text[s] for s in NEGATIVES_REACTIONS if s in text.keys()])
                logging.info("I read {} negative reactions ...".format(int(nb)))
                scale_factor *= 2 * nb
            elif "rage" in text:
                raise ValueError("One user reacted with :rage:, the bot will quit...")
        return scale_factor
    except KeyError:
        return scale_factor


def send(text, sc, use_channel=USE_CHANNEL):
    """Send text to channel SLACK_CHANNEL with client sc.

    - https://github.com/slackapi/python-slackclient#sending-a-message
    """
    channel = SLACK_CHANNEL if use_channel else SLACK_USER
    text = "{}\n> (Sent by an _open-source_ Python script :snake:, {}, written by Lilian Besson)".format(text, URL)
    logging.info("Sending the message '{}' to channel/user {} ...".format(text, channel))
    # https://api.slack.com/methods/chat.postMessage
    return sc.api_call(
        "chat.postMessage", channel=channel, text=text,
        username="Citations aléatoires", icon_emoji=":robot_face:"
    )


def loop(quote_file=QUOTE_FILE):
    """Main loop."""
    logging.info("Starting my Slack bot, reading random quotes from the file {}...".format(quote_file))
    # Get list of quotes and parameters
    the_quote_file = open(quote_file, 'r')
    lines = the_quote_file.readlines()
    sc = SlackClient(SLACK_TOKEN)
    lmbda = MEAN_TIME
    list_of_ts_channel = []
    # Start loop
    while True:
        # 1. get random quote
        text = random_line(lines)
        logging.info("New message:\n{}".format(text))
        response = send(text, sc)
        # logging.debug("  response =", response)
        # 2. sleep until next quote
        secs = sleeptime(lmbda)
        str_secs = time.asctime(time.localtime(time.time() + secs))
        logging.info("  ... Next message in {} seconds, at {} ...".format(secs, str_secs))
        sleep_bar(secs)
        # 3. get response
        try:
            ts, c = response['ts'], response['channel']
            # logging.debug("  ts, c =", ts, c)
            list_of_ts_channel.append((ts, c))
            # Get reaction from users on the messages already posted
            scale_factor = get_reactions(list_of_ts_channel, sc)
            lmbda = scale_factor * MEAN_TIME  # Don't accumulate this!
        except KeyError:
            pass
        logging.info("  Currently, the mean time between messages is {} ...".format(lmbda))
    return 0


# --- Main script

if __name__ == '__main__':
    quote_file = sys.argv[1] if len(sys.argv) > 1 else QUOTE_FILE
    sys.exit(loop(quote_file))

# End of my-small-slack-bot.py
