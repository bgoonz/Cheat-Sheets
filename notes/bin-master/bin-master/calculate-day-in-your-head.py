#!/usr/bin/env python3
# -*- coding: utf8 -*-
"""
Short algorithm to compute the day of the week of any date, given by its year, month and day.
Not so easy to learn and do in your head, but managable.

- Idea from http://www.commandlinefanatic.com/cgi-bin/showarticle.cgi?article=art009
"""

from __future__ import print_function


days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
adjustment = [0, 1, -1, 0, 0, 1, 1, 2, 3, 3, 4, 4]


def day_offset(y, m, d):
    # Add 1 if y > 2000 to account for the fact that 2000 was a leap year.
    year_offset = ( y - 2000 ) + ( ( y - 2000 ) // 4 ) + ( y > 2000 )
    # Account for wrongly computed leap years
    year_offset -= ( y - 2000 ) // 100

    # Add back 1 year if the target year is a leap year but the target day
    # is after the 29th (in other words, the leap day hasn't happened yet).
    if y % 100:
        year_offset += ( y < 2000 ) and not( y % 4 ) and ( m > 2 )
        year_offset -= ( y > 2000 ) and not( y % 4 ) and ( m < 3 )

    # Read month offset from the adjustment table
    # by default each month has 30 days, and the adjument corrects that
    month_offset = ( ( m - 1 ) * 2 ) + adjustment[ m - 1 ]

    # Remove today as we count from 0
    day_offset = d - 1

    return ( year_offset + month_offset + day_offset ) % 7


if __name__ == '__main__':
    import datetime
    from sys import argv
    assert len(argv) >= 4, "Need three arguments: '$ {} y m d'".format(argv[0])
    y, m, d = int(argv[1]), int(argv[2]), int(argv[3])
    offset = day_offset(y, m, d)
    # Saturday, Jan. 1, 2000 is the reference date
    date = ( offset + 5 ) % 7
    import datetime as dt
    today = datetime.datetime.today()
    then = datetime.datetime(y, m, d)
    verb = "will be" if today < then else "was" if today > then else "is"
    print("The date {}/{}/{} {} a {}.".format(d, m, y, verb, days[date]))
