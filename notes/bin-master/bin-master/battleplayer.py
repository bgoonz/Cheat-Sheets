#!/usr/bin/env python3
# -*- coding: utf-8; mode: python -*-
""" My not-too-naive answer to https://github.com/dutc/battlegame

Bot part!

- Author: Lilian Besson, (C) 2018.
- Online: https://bitbucket.org/lbesson/bin/src/master/battleplayer.py
- License: MIT License (http://lbesson.mit-license.org).
"""
__author__ = "Lilian Besson"
__name_of_app__ = "Battle Client"
__version__ = "0.1"

import sys
from collections import defaultdict
from time import sleep
from random import choice
from docopt import docopt
import numpy as np
# https://stackoverflow.com/a/4896288/5889533
from subprocess import PIPE, Popen
ON_POSIX = 'posix' in sys.builtin_module_names

from battleserver import ships, DEFAULT_X, DEFAULT_Y

length_of_ships = defaultdict(lambda: min(ships.values()))
length_of_ships.update({k.lower(): v for k,v in ships.items()})

# --- Documentation

documentation = f"""{__name_of_app__}.

Usage:
    battleplayer.py [--delay=<t>] [--smart] [--size=<xy>] [--server_command=<cmd>]
    battleplayer.py (-h | --help)
    battleplayer.py --version

Options:
    -h --help       Show this screen.
    --version       Show version.
    --server_command=<cmd>  Play against a server launched by 'cmd' [default: ./battleserver.py --random --play].
    --size=<xy>     Set size of the board [default: {DEFAULT_X},{DEFAULT_Y}].
    --delay=<t>     Delay between successive plays, in seconds [default: 0.1].
    --smart         Try to be smart when playing. Experimental.
"""


def main(args):
    cmd = args['--server_command']
    sizex, sizey = [int(i) for i in args['--size'].split(',')]
    delay = float(args['--delay'])
    if '--size' not in cmd:
        cmd += f" --size={sizex},{sizey}"
    smart = args['--smart']

    if not cmd: return 1

    pipe = Popen(cmd.split(' '), stdout=PIPE, stdin=PIPE, bufsize=1, close_fds=ON_POSIX, universal_newlines=True)
    child_stdin, child_stdout = pipe.stdin, pipe.stdout

    all_possible_positions = [
        (x, y)
        for x in range(sizex)
        for y in range(sizey)
    ]
    max_nb_positions = len(all_possible_positions)
    hit_a_ship = False
    length_of_hit_ship = 0
    last_hist_ship = None
    next_x_y = []
    hit_x, hit_y = -1, -1

    def next_play():
        # global all_possible_positions, child_stdin
        x, y = 0, 0
        t = len(all_possible_positions)
        if t > 0:
            if next_x_y:
                # FIXME that's where I can improve!
                x, y = next_x_y.pop(0)
            else:
                x, y = choice(all_possible_positions)
        print(f"bot: {x},{y}")
        print(f"{x},{y}", file=child_stdin, flush=True)
        return x, y

    x, y = -1, -1
    while True:
        # 1. playing
        if (x, y) in all_possible_positions: all_possible_positions.remove((x, y))
        x, y = next_play()
        # 2. seeing output and using it as feedback
        stdout_data = child_stdout.readline()
        if not stdout_data:
            print("ERROR: Server died!")
            return 2
        if smart:
            if 'hit ' in stdout_data:  # hit a ship!
                new_hit_ship = stdout_data.replace('\n','').replace('hit ','')
                if not hit_a_ship:
                    # first hit of this ship
                    hit_a_ship = True
                    last_hist_ship = new_hit_ship
                    length_of_hit_ship = length_of_ships[last_hist_ship]
                    hit_x, hit_y = x, y
                    next_x_y = [
                        (newx, y)
                        for newx in range(
                            max(0, x - length_of_hit_ship),
                            min(sizex, x + length_of_hit_ship)
                        )
                        if (newx, y) in all_possible_positions
                        if newx != hit_x
                    ] + [
                        (x, newy)
                        for newy in range(
                            max(0, y - length_of_hit_ship),
                            min(sizey, y + length_of_hit_ship)
                        )
                        if (x, newy) in all_possible_positions
                        if newy != hit_y
                    ]
                else:
                    if new_hit_ship != last_hist_ship:
                        print(f"WARNING: was hitting {last_hist_ship} but now hitting {new_hit_ship}")
                        if new_hit_ship is None:
                            if x == hit_x:  # we tried to aim at same x
                                for _y in range(0, sizey):
                                    if _y in next_x_y and hit_y != _y: next_x_y.remove((x, _y))
                            if y == hit_y:  # we tried to aim at same y
                                for _x in range(0, sizex):
                                    if _x in next_x_y and hit_x != _x: next_x_y.remove((_x, y))
                    else:
                        if x == hit_x:  # the ship has same x
                            for _y in range(0, sizey):
                                if _y in next_x_y: next_x_y.remove((x, _y))
                        if y == hit_y:  # the ship has same y
                            for _x in range(0, sizex):
                                if _x in next_x_y: next_x_y.remove((_x, y))
            elif 'sunk ' in stdout_data:  # sunk a ship!
                new_hit_ship = stdout_data.replace('\n','').replace('sunk ','')
                if new_hit_ship != last_hist_ship:
                    print(f"WARNING: was hitting {last_hist_ship} but sunk {new_hit_ship}")
                else:
                    hit_a_ship = False
                    last_hist_ship = None
                    next_x_y = []
        # done for smart
        print(f"board: {stdout_data}", end='')
        if 'you win!' in stdout_data:
            print("VICTORY!")
            return 0
        if len(all_possible_positions) == 0:
            print("ERROR: cannot play anymore, all positions were tried but the bot did not win!")
            return 1
        sleep(delay)

if __name__ == '__main__':
    arguments = docopt(documentation, version=f"{__name_of_app__} v{__version__}")
    sys.exit(main(arguments))
