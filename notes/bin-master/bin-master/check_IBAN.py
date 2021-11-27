#! /usr/bin/env python3
# -*- coding: utf-8; mode: python -*-
""" Check if an IBAN is correct.

Reference:
https://fr.wikipedia.org/wiki/International_Bank_Account_Number#Algorithme_de_v.C3.A9rification_de_l.27IBAN


- *Date:* Wednesday 09 March 2016.
- *Author:* Lilian Besson, (C) 2015-16.
- *Licence:* MIT Licence (http://lbesson.mit-license.org).
"""

from __future__ import print_function, division  # Python 2 compatibility if needed


def l_to_c(l):
    try:
        return str(int(l))
    except ValueError:
        return str(10 + ord(l.upper()) - ord('A'))


def check_iban(iban):
    print("\nChecking the IBAN number '%s'..." % iban)
    ib = iban.replace(' ', '')
    ib = ib[4:] + ib[:4]
    print("Of length", len(ib))
    i = int(''.join(l_to_c(l) for l in ib))
    check = (i % 97) == 1
    if check:
        print("OK '%s' seems to be a valid IBAN number." % iban)
    else:
        print("[WARNING] NOT OK '%s' seems to NOT be a valid IBAN number!" % iban)
    return check


def main(args):
    try:
        if not args:
            check_iban('HAHA LOL YOU THOUGH I WILL LET A REAL IBAN IN MY SCRIPT')
        else:
            for iban in args:
                check_iban(iban)
        return 0
    except Exception as e:
        print(e)
        return 1


if __name__ == '__main__':
    from sys import argv, exit
    exit(main(argv[1:]))

# End of check_IBAN.py
