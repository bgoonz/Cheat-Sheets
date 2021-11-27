#! /usr/bin/env python3
# -*- coding: utf-8; mode: python -*-
""" Demo python script to test several algorithms that generate all permutation of a list.

Reference:
- http://typeocaml.com/2015/05/05/permutation/
- https://docs.python.org/3/library/itertools.html#itertools.permutations

- *Date:* 06/02/2017.
- *Author:* Lilian Besson, (C) 2015-16.
- *Licence:* MIT Licence (http://lbesson.mit-license.org).
"""

from __future__ import print_function, division  # Python 2 compatibility if needed
from functools import reduce

# Builtin implementation, as a reference
from itertools import permutations as itertools_permutations


# --- First algorithm : The insert-into-all-positions solution

def ins_all_positions(x, l):
    """Return a list of lists obtained from l by inserting x at every possible index."""
    res = []
    for i in range(0, len(l) + 1):
        res.append(l[:i] + [x] + l[i:])
    return res


# Now the main permutations generator.
def first_permutations(iterable):
    """Second algorithm, insert-into-all-positions solution."""
    if len(iterable) == 0:
        return []
    # we must specify this edge case
    elif len(iterable) == 1:
        return [[iterable[0]]]
    else:
        x, xs = iterable[0], iterable[1:]
        return reduce(lambda acc, p: acc + ins_all_positions(x, p), first_permutations(xs), [])


# --- Second algorithm : The fixed-head solution

def rm(x, l):
    """List l without element x."""
    return [y for y in l if x != y]


def head_of_all(x, l):
    """List of lists from l where x is the head of all the lists."""
    return [[x] + p for p in l]


def second_permutations(iterable):
    """Second algorithm, fixed-head solution."""
    if len(iterable) == 0:
        return []
    # we must specify this edge case
    elif len(iterable) == 1:
        return [[iterable[0]]]
    else:
        return reduce(lambda acc, x: acc + head_of_all(x, second_permutations(rm(x, iterable))), iterable, [])


# --- Third algorithm : Johnson Trotter algorithm
left = False
right = True


def attach_direction(t, d=left):
    """Attach the direction d to all elements of array t."""
    return [(x, d) for x in t]


def remove_direction(t):
    """Remove the attached direction d to all elements of array t."""
    return [y for y, _ in t]


def swap(t, i, j):
    """Swap t[i] and t[j] in array t."""
    t[i], t[j] = t[j], t[i]


def is_movable(a, i):
    """Can a[i] be moved?"""
    x, d = a[i]
    if d == left:
        return i > 0 and x > a[i - 1][0]
    elif d == right:
        return i < len(a) - 1 and x > a[i + 1][0]
    else:
        raise ValueError("unknown direction d = {}".format(d))


def move(a, i):
    """Move it if possible."""
    x, d = a[i]
    if is_movable(a, i):
        if d == left:
            swap(a, i, i - 1)
        elif d == right:
            swap(a, i, i + 1)
        else:
            raise ValueError("unknown direction d = {}".format(d))
    else:
        raise ValueError("not movable")


def scan_largest_movable(a):
    """Find the largest movable element."""
    def aux(acc, i):
        if i >= len(a):
            return acc
        else:
            if not is_movable(a, i):
                return aux(acc, i + 1)
            else:
                x, _ = a[i]
                if acc is None:
                    return aux(i, i + 1)
                else:
                    j = acc if x < a[acc][0] else i
                    return aux(j, i + 1)
    return aux(None, 0)


def flip(d):
    """Flip direction d : left -> right, right -> left"""
    return not d


def scan_flip_larger(x, a):
    """Scan to flip larger."""
    for i, (y, d) in enumerate(a):
        if y > x:
            a[i] = y, flip(d)


def third_permutations(iterable):
    """Third algorithm, Johnson Trotter algorithm."""
    i = sorted(list(iterable))  # Required by the algorithm
    a = attach_direction(i)
    r = list(iterable)[:]
    while True:
        p = r[:]
        yield p
        i = scan_largest_movable(a)
        if i is None:  # No more permutation!
            raise StopIteration
        else:
            x, _ = a[i]
            move(a, i)
            scan_flip_larger(x, a)
            r = remove_direction(a)


# --- Function to test and compare them

def test(list_of_f, iterable, stopearly=False):
    """ Test that all functions in list_of_f give the same list of permutation on this iterable."""
    print("\n\nTesting for the list of functions {} ...".format([f.__name__ for f in list_of_f]))  # DEBUG
    result = True
    print("Testing for the iterable {} ...".format(iterable))  # DEBUG
    i = iterable
    allperms = []
    for f in list_of_f:
        allperms.append(sorted([list(p) for p in f(iterable)]))
    for i, pi in enumerate(allperms):
        for j in range(i + 1, len(allperms)):
            pj = allperms[j]
            if pi != pj:
                print(" - Function #{} ({.__name__}) gave a different list of permutations as function #{} ({.__name__}) ...".format(i, list_of_f[i], j, list_of_f[j]))  # DEBUG
                # print("   - pi =", pi)  # DEBUG
                # print("   - pj =", pj)  # DEBUG
                if stopearly:
                    return False
                else:
                    result = False
            else:
                print(" - Function #{} ({.__name__}) gave the same list of permutations as function #{} ({.__name__}) ...".format(i, list_of_f[i], j, list_of_f[j]))  # DEBUG
    return result


def main():
    # list_of_f = [itertools_permutations, first_permutations]
    # list_of_f = [itertools_permutations, first_permutations, second_permutations]
    list_of_f = [itertools_permutations, first_permutations, second_permutations, third_permutations]

    iterable = [1, 2, 3]
    test(list_of_f, iterable)

    iterable = [1, 2, 3, 4, 5]
    test(list_of_f, iterable)

    iterable = [1, 2, 3, 4, 5, 6]
    test(list_of_f, iterable)


if __name__ == '__main__':
    main()
    print("TODO: finish this script !")

# End of test-permutation-algorithms.py
