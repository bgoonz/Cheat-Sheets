#!/usr/bin/env /usr/bin/python
#-*- coding: utf-8 -*-
# (C) Lilian BESSON, 2013
# http://perso.crans.org/besson/bin/mail.py

import subprocess
def notify(msg, submsg="mail.py : auto mailer (with notify-send)"):
 ''' Notification using subprocess and notify-send.
 Also print the informations directly to the screen.

 Fails simply if notify-send is not found.'''
 try:
  subprocess.Popen(['notify-send', msg, submsg])
 except:
  print "notify-send : not-found !"
  return -1
 print "msg=%s\nsubmsg=%s" % (msg, submsg)

# Import smtplib for the actual sending function
import smtplib

# Import the email modules we'll need
from email.mime.text import MIMEText

signature="""\n
--
%s
###	Auto-sent by [mail.py], a simple Python 2.6 script.
###	Auto configure with SMTP server on localhost in the cr@ns server.
###	(c) by Lilian Besson
"""

def send_me_an_email(message, subj="[LOG] no object", me="jarvisATcransDOTorg".replace("AT","@").replace("DOT","."), you="jarvisATcransDOTorg".replace("AT","@").replace("DOT","."), my_identity="jarvis log"):
	""" Send a message [message] by email.
	The content of the email is [message], the subject is [subj].
	The sender is [me], not necessary a valid sender for the SMTP.
	The mail will be sent to [you].

	Auto configure with SMTP server on localhost in the cr@ns server (http://www.crans.org)

	(c) Lilian Besson, 2012-2013.
	"""
	notify(subj, message+"\n### ME="+me+" YOU="+you)
	msg = MIMEText(message+(signature % me))
	# The order is "important", to act like a real mail client !
	msg['From'] = my_identity+" <"+me+">"
	msg['To'] = you
	msg['Subject'] = subj
	# Send the message via our own SMTP server, but don't include the
	# envelope header.
	s = smtplib.SMTP('smtp.crans.org')
	# s = smtplib.SMTP('localhost')
	s.sendmail(me, [you], msg.as_string())
	s.quit()
	print "An email has been sent to %s, from %s <%s>." % (you, my_identity, me)
	print "Title of the email : \n%s" % subj
	print "Content of the email : \n%s" % message

import sys, os

if __name__ == '__main__':
  if '-h' in sys.argv or '--help' in sys.argv:
   print "  mail.py [message [subject]]\nUSAGE:"
   print send_me_an_email.__doc__
   sys.exit(0)
  if len(sys.argv)>2:
   subject = sys.argv[2]
  else:
   subject = "[LOG] jarvis"
  identity = "User = %s @ Host = %s." % (os.getenv("USER"), os.getenv("HOSTNAME"))
  message="### Content of the email :\n"
  if len(sys.argv)>1:
   message=message+str(sys.argv[1])
  message=message+("\n### Content of command line : %s.\n### From %s" % (str(sys.argv), identity))
  send_me_an_email(message, subj=subject)
