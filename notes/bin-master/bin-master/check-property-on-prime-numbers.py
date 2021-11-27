#!/usr/bin/env python3
# -*- coding: utf-8; mode: python -*-
""" A simple script to check property on prime numbers, as explained in this article https://www.quantamagazine.org/mathematicians-discover-prime-conspiracy-20160313/.

- Author: Lilian Besson, (C) 2018.
- Online: https://bitbucket.org/lbesson/bin/
- Licence: MIT Licence (http://lbesson.mit-license.org).
"""
from sympy import sieve, nextprime



def ends_by_0(p):
    return (p % 10) == 9


def next_ends_by_9(p):
    np = nextprime(p)
    return (np % 10) == 9


def next_ends_by_1(p):
    np = nextprime(p)
    return (np % 10) == 1



def main(maxn):
    primes = sieve
    primes.extend(maxn)
    primes = primes._list
    nb_primes = len(primes)
    print(f"We found {nb_primes} primes smaller or equal than {maxn}...")

    filtered_primes = [ p for p in primes if ends_by_0(p) ]
    nb_filtered_primes = len(filtered_primes)
    print(f"We found {nb_filtered_primes} primes that finishes by 9...")
    rate = float(nb_filtered_primes) / float(nb_primes)
    print(f"That's about {rate:.3%}...")

    primes_satisfying_property = [ p for p in filtered_primes if next_ends_by_9(p) ]
    nb_primes_satisfying_property = len(primes_satisfying_property)
    print(f"\nWe found {nb_primes_satisfying_property} primes that has next primes finishing by 9...")
    second_rate = float(nb_primes_satisfying_property) / float(nb_filtered_primes)
    print(f"That's about {second_rate:.3%}...")

    primes_satisfying_property = [ p for p in filtered_primes if next_ends_by_1(p) ]
    nb_primes_satisfying_property = len(primes_satisfying_property)
    print(f"\nWe found {nb_primes_satisfying_property} primes that has next primes finishing by 1...")
    third_rate = float(nb_primes_satisfying_property) / float(nb_filtered_primes)
    print(f"That's about {third_rate:.3%}...")
    print(f"\n==> which is about {third_rate/second_rate:.3%} more!")

    return 0

if __name__ == '__main__':
    from sys import argv, exit
    maxn = int(argv[1]) if len(argv) > 1 else 1000
    exit(main(maxn))

