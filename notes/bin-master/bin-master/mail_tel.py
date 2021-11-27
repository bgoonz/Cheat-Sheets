#!/usr/bin/env /usr/bin/python
# -*- coding: utf-8; mode: python -*-
"""
A small Python 2/3 script to send an email from the crans.org network, verbous mode.

- Author: Lilian Besson, (C) 2014.
- Online: https://bitbucket.org/lbesson/bin/src/master/mail.py
- Licence: MIT Licence (http://lbesson.mit-license.org).
"""

from __future__ import print_function  # Python 2/3 compatibility !

# Import smtplib for the actual sending function
import smtplib
# Import the email modules we'll need
from email.mime.text import MIMEText
import sys
import os

signature = """\n
--
%s
"""


def send_me_an_email(message, subj="[LOG] no object", me="jarvisATcransDOTorg".replace("AT", "@").replace("DOT", "."), you="0628412257ATsfrDOTfr".replace("AT", "@").replace("DOT", "."), my_identity="jarvis log"):
    """ Send a message [message] by email.
    The content of the email is [message], the subject is [subj].
    The sender is [me], not necessary a valid sender for the SMTP.
    The mail will be sent to [you].

    Auto configure with SMTP server on localhost in the cr@ns server (http://www.crans.org)

    (c) Lilian Besson, 2012-2013.
    """
    msg = MIMEText(message + (signature % me))
    # The order is "important", to act like a real mail client !
    msg['From'] = my_identity + " <" + me + ">"
    msg['To'] = you
    msg['Subject'] = subj
    # Send the message via our own SMTP server, but don't include the
    # envelope header.
    s = smtplib.SMTP('smtp.crans.org')
    # s = smtplib.SMTP('localhost')
    s.sendmail(me, [you], msg.as_string())
    s.quit()
    # print("An email has been sent to %s, from %s <%s>." % (you, my_identity, me))
    # print("Title of the email : \n%s" % subj)
    # print("Content of the email : \n%s" % message)


if __name__ == '__main__':
    if '-h' in sys.argv or '--help' in sys.argv:
        print("  mail.py [message [subject]]\nUSAGE:")
        print(send_me_an_email.__doc__)
        sys.exit(0)
    if len(sys.argv) > 2:
        subject = sys.argv[2]
    else:
        subject = "[LOG] jarvis"
        message = ""
    if len(sys.argv) > 1:
        message = message + str(sys.argv[1])
    send_me_an_email(message, subj=subject)
