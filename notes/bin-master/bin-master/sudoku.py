#!/usr/bin/env python3
# -*- coding: utf-8; mode: python -*-
""" A simple and tiny 9x9 Sudoku solver with z3.

- Author: Lilian Besson, (C) 2013, updated 2021.
- Online: https://bitbucket.org/lbesson/bin/
- Licence: MIT Licence (http://lbesson.mit-license.org).
- Dependency: install z3-solver (https://pypi.org/project/z3-solver/)
"""

from __future__ import print_function
import sys

if __name__ != "__main__":
    sys.exit(0)

try:
    import z3
except ImportError:
    print("Cannot import 'z3' package.\nHave you tried to install it?\n sudo pip3 install -U z3 solver")
    import webbrowser
    webbrowser.open_new_tab("https://pypi.org/project/z3-solver/")
    sys.exit(0)

# TODO check if we can easily change the size and generalize?
SIZE = 3

# 9x9 matrix of integer variables
X = [
     [ z3.Int("x_%s_%s" % (i + 1, j + 1)) for j in range(SIZE**2) ]
     for i in range(SIZE**2)
]

# each cell contains a value in {1, ..., 9}
cells_c = [ z3.And(1 <= X[i][j], X[i][j] <= SIZE**2)
            for i in range(SIZE**2)
            for j in range(SIZE**2)
          ]

# each row contains a digit at most once
rows_c = [ z3.Distinct(X[i]) for i in range(SIZE**2) ]

# each column contains a digit at most once
cols_c = [ z3.Distinct( [ X[i][j] for i in range(SIZE**2) ] )
           for j in range(SIZE**2)
         ]

# each 3x3 square contains a digit at most once
sq_c = [ z3.Distinct([ X[SIZE * i0 + i][SIZE * j0 + j]
                       for i in range(SIZE)
                                        for j in range(SIZE)
                  ])
        for i0 in range(SIZE)
        for j0 in range(SIZE)
       ]

sudoku_c = cells_c + rows_c + cols_c + sq_c

# sudoku instance, we use '0' for empty cells
if SIZE != 3:
    print("TODO write an instance of size = {}.".format(SIZE))
    sys.exit(1)

instance = [[0, 0, 0, 0, 0, 0, 7, 0, 0],
            [7, 3, 0, 0, 4, 0, 0, 0, 0],
            [1, 0, 0, 7, 5, 0, 0, 3, 0],
            [0, 0, 3, 2, 0, 5, 4, 0, 7],
            [0, 0, 0, 9, 0, 8, 0, 0, 0],
            [2, 0, 7, 1, 0, 4, 5, 0, 0],
            [0, 6, 0, 0, 8, 7, 0, 0, 4],
            [0, 0, 0, 0, 9, 0, 0, 1, 3],
            [0, 0, 2, 0, 0, 0, 0, 0, 0]]

try:
    from pprint import pprint
except ImportError:
    pprint = print

print("Trying to solve this 9x9 SUDOKU grid:")
pprint(instance)

import time
before = time.time()

instance_c = [ z3.If(instance[i][j] == 0, True, X[i][j] == instance[i][j])
               for i in range(9) for j in range(9)
             ]

s = z3.Solver()
s.add(sudoku_c + instance_c)

if s.check() == z3.sat:
    m = s.model()
    after = time.time()
    duration = after - before
    print("Solved in {:.4g} seconds.".format(duration))

    r = [ [ m.evaluate(X[i][j]) for j in range(SIZE**2) ]
            for i in range(SIZE**2) ]
    z3.print_matrix(r)
else:
    print("Failed to solve the grid...")
