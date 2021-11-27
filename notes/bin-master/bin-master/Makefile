# Makefile to send this to Zam
SHELL=/usr/bin/env /bin/bash

all:	signs bin bin.zip send

bin:
	cd ~ ; make bin
bin.zip:
	cd ~ ; make bin.zip

send:	send_bashs send_zamok
send_zamok:
	CP --exclude=.*log --exclude=.git ./ ${Szam}bin/

send_bashs:	signs
	CP ~/bin/.bash{rc,_aliases}* ~/
	# CP ~/bin/.bash{rc,_aliases}* ${Szam}bin/

signs:	sign_bashrc sign_bashalias
sign_bashrc:
	gpg --armor --detach-sign --yes --no-batch --use-agent .bashrc
sign_bashalias:
	gpg --armor --detach-sign --yes --no-batch --use-agent .bash_aliases
