#!/usr/bin/env /usr/bin/python
# -*- coding: utf-8; mode: python -*-
"""
A small Python 2/3 script to send a HTML formatted email from the crans.org network.

- Author: Lilian Besson, (C) 2014.
- Online: https://bitbucket.org/lbesson/bin/src/master/mail_html.py
- Licence: MIT Licence (http://lbesson.mit-license.org).
"""

from __future__ import print_function  # Python 2/3 compatibility !

# Import sys to use arg of the script
import sys
# Import smtplib for the actual sending function
import smtplib
# Import the email modules we'll need
from email.mime.text import MIMEText
from base64 import b64decode
# Import date module
from datetime import date
datetoday = date.today().isoformat()

defaultaddress = "jarvisATcransDOTorg".replace("AT", "@").replace("DOT", ".")

signature = """<br>-- <br>%s<br>
<img style=\"display: none; vibility: hidden;\" src=\"https://ga-beacon.appspot.com/UA-38514290-15/mail_html.py/""" + datetoday + "?pixel\" />"


def send_me_an_email(message, subj="[LOG] no object", me=defaultaddress,
                     you=defaultaddress, my_identity="jarvis (HTML)"):
    """ Send a message [message] by email.
    The content of the email is [message] (encoded as HTML), the subject is [subj].
    The sender is [me], not necessary a valid sender for the SMTP.
    The mail will be sent to [you].

    Auto configured with SMTP server (smtp.crans.org) with SSL support for the cr@ns server (http://www.crans.org)

    (c) Lilian Besson, 2014.
    """
    msg = MIMEText("%s" % (message + (signature % me)).replace("\n", '\n'), _charset=None, _subtype="html")
    # The order is "important", to act like a real mail client !
    # Change "Content-Type" to "text/html"
    msg['Content-Transfer-Encoding'] = "utf-8"
    msg['Content-Type'] = "text/html"
    msg['User-Agent'] = "smtplib.text/html with python 2.7.3 on jarvis.crans.org (with http://perso.crans.org/besson/bin/mail_html.py)"
    # Identity
    msg['From'] = my_identity + " <" + me + ">"
    msg['Reply-To'] = me
    msg['To'] = you
    msg['Subject'] = subj

    # Send the message via our own SMTP server, but don't include the envelope header.
    # s = smtplib.SMTP('localhost')
    # s = smtplib.SMTP('smtp.crans.org', port=465) # Try 587 for starttls ?
    s = smtplib.SMTP_SSL('smtp.crans.org', port=465)  # Try 587 for starttls ?
    # See https://docs.python.org/2/library/smtplib.html#smtplib.SMTP.login
    s.login(b64decode('YmVzc29u'), b64decode(open('/home/lilian/crans.b64').readline()[:-1]))
    s.sendmail(me, [you], msg.as_string())
    s.quit()
    print("A HTML email has been sent to <%s>, from %s <%s>." % (you, my_identity, me))
    print("Title of the email : <%s>" % subj)
    print("Content of the email : \n%s" % message)


if __name__ == '__main__':
    if '-h' in sys.argv or '--help' in sys.argv:
        print("mail_html.py [message [subject [you [me [my_identity]]]]]\nUSAGE:")
        print(send_me_an_email.__doc__)
    sys.exit(0)
    my_identity = sys.argv[5] if len(sys.argv) > 5 else "jarvis (HTML)"
    me = sys.argv[4] if len(sys.argv) > 4 else defaultaddress
    you = sys.argv[3] if len(sys.argv) > 3 else defaultaddress
    subject = sys.argv[2] if len(sys.argv) > 2 else "[LOG] jarvis.crans.org (HTML)"
    message = "%s" % (str(sys.argv[1])) if len(sys.argv) > 1 else "Empty message."
    send_me_an_email(message, subj=subject, you=you, me=me, my_identity=my_identity)
