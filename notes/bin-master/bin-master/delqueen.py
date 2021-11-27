#!/usr/bin/env python2
# -*- coding: utf8 -*-
"""
See https://github.com/andreecmonette/pydras
Author: Andree C. Monette
Source: https://raw.githubusercontent.com/andreecmonette/pydras/master/delqueen.py

Launch the script, cancel it with Ctrl+C to solve the n-queen problem

    $ delqueen.py 6
    Interrupt me to solve the 6 queens problem!
    ^CTraceback (most recent call last):
    File "/home/lilian/bin/delqueen.py", line 68, in <module>
        while True:
    KeyboardInterrupt
    894  board states traversed.
    The number of  6 -queens solutions is:  4
"""

from __future__ import print_function
import sys

if sys.version_info.major < 3:
    range = xrange


class delBoard:
    """ A weird object that does nothing while alive,
    but solves the n-queens problem when garbage collected.

    It uses CPython's garbage collection graph traversal algorithm to explore
    the graph of possible solutions to the n-queens problem.
    Very weird, but it works. And it's fast!
    """

    def __init__(self, nqueens=None):
        self.nqueens = nqueens
    
    def __del__(self):
        global __builtins__
        if not hasattr(self, 'myPos'):
            if not __name__ == "__main__":
                __builtins__ = delBoard
            __builtins__.nqueens = self.nqueens if self.nqueens else len(__name__)
            __builtins__.ans = 0
            __builtins__.collected = 0
            for j in range(__builtins__.nqueens):
                a = delBoard()
                a.boardState = ((set(), set(), set()))
                a.myPos = j
                a = 0
            print(str(__builtins__.collected), "board states traversed.")
            print("The number of", __builtins__.nqueens, "-queens solutions is:", __builtins__.ans)
            return

        __builtins__.collected += 1

        if self.myPos in self.boardState[0] \
            or self.myPos in self.boardState[1] \
            or self.myPos in self.boardState[2]:
            return

        if len(self.boardState[0]) == __builtins__.nqueens - 1:
            __builtins__.ans += 1
            return

        c = self.boardState[0].copy()
        c.add(self.myPos)
        l = set(map(lambda x: x - 1, self.boardState[1])).copy()
        l.add(self.myPos - 1)
        l.discard(-1)
        r = set(map(lambda x: x + 1, self.boardState[2])).copy()
        r.add(self.myPos + 1)
        r.discard(__builtins__.nqueens)
        for k in range(__builtins__.nqueens):
            b = delBoard()
            b.boardState = (c, l, r)
            b.myPos = k


# This has to be defined now
nqueens = int(sys.argv[1]) if len(sys.argv) > 1 else None
q = delBoard(nqueens)


if __name__ == "__main__":
    print("Interrupt me to solve the {} queens problem!".format(nqueens))
    while True:
        pass
