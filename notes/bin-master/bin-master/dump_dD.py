#! /usr/bin/env python
# -*- coding: utf-8 -*-
"""
A small script to dump all Maths Exercice LaTeX sources from some website.
Eavily dependant on the website being used.

Doc: http://www.crummy.com/software/BeautifulSoup/bs3/documentation.html#Printing%20a%20Document
And an example: http://mp.cpgedupuydelome.fr/mesexos.php?idTeX=1485

- Author: Lilian BESSON
- Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
- Web version: http://perso.crans.org/besson/bin/dump_dD.py
- Web version (2): https://bitbucket.org/lbesson/bin/src/master/dump_dD.py
- Date: 24-07-2013
"""

from __future__ import print_function  # Python 2/3 compatibility !
import sys

try:
    from ansicolortags import printc as print
except ImportError as e:
    print("ansicolortags not available, using regular print.")
    print("  You can install it with : 'pip install ansicolortags' (or sudo pip)...")

print("<yellow>.: Lilian Besson presents :.")
print("<cyan>Maths exercice LaTeX sources dumper, v0.1<reset>")

# Quicker if you keep this value up-to-date here
# nbExos=$(wget -O - --quiet "http://mp.cpgedupuydelome.fr/index.php" | html2text | grep Exercice | grep -o [0-9]*)
# nbExos  = 3994

# print("<reset>Choix aléatoire parmi <neg>%i<Neg> exercices de maths (niveau MPSI et MP)..." % nbExos)
# from random import randint
# numexo  = randint(1, nbExos)  # FIXME !

numexo = int(sys.argv[1]) if len(sys.argv) > 1 else 1485

chapter = str(sys.argv[2]) if len(sys.argv) > 2 else ""

urlToGo = "http://mp.cpgedupuydelome.fr/mesexos.php?idTeX=%i" % numexo

print("Numéro <magenta>%i<reset>. On va vers <u>\"%s\"<U><white>" % (numexo, urlToGo))

# On récupère la page (la partie la plus lente du coup)
import urllib2
response = urllib2.urlopen(urlToGo)
html = response.read()

# BeautifulSoup v3 (et pas v4, attention !)
from BeautifulSoup import BeautifulSoup

# On l'analyse
parsed_html = BeautifulSoup(html, fromEncoding='utf-8')

print("<black>Encodage original : %s<white>\n\n" % parsed_html.originalEncoding)

# On cherche la section <section id="contenu">..</section>
contenu = parsed_html.body.find('section', attrs={'id': 'contenu'})

# Et on prend le contenu de la première <textarea> !
codeTeX = contenu.findAll('textarea', limit=1)[0].renderContents()

# Quelques corrections, parce que BeautifulSoup échappe certains trucs
codeTeX = codeTeX.replace("&amp;", "&").replace("&lt;", "<").replace("&gt;", ">").replace("&le;", "<=").replace("&ge;", ">=")

# Et d'autres erreurs fréquentes.
codeTeX = codeTeX.replace("^ - ", "^{-}")

# Ici on pourrait utiliser un outil de traduction bien conçu pour produire codeTeX_en en anglais
# FIXME !

# Là on galère pour afficher en UTF-8. Zut !
# print( unicode( codeTeX ) )
print("<blue><u>Code LaTeX de cet exercice:<U><white>\n\n%s" % codeTeX)

# On créé un fichier TeX
name = "ex_%i.fr.tex" % numexo
out = open(name, mode="w")

# On va écrire le code de l'exercice dedans
print("<green>On écrit dans %s !<white>" % out)

# Ajout de la possibilité de préciser le chapitre courant en train d'être construit.
if chapter:
    chapter = chapter.replace("_", " ").replace("/", "")
    print("<magenta>Pour le chapitre '%s' :<white>" % chapter)
    out.write("%%%% -*- mode: latex; coding: utf-8 -*-\n%%%% Chapter : %s.\n%%%% Start of LaTeX code, for exercise #%i (from '%s'), in French (file '%s').\n\n" % (chapter, numexo, urlToGo, name))
else:
    out.write("%%%% -*- mode: latex; coding: utf-8 -*-\n%%%% Start of LaTeX code, for exercise #%i (from '%s'), in French (file '%s').\n\n" % (numexo, urlToGo, name))

out.write(codeTeX)
out.write("\n%%%% End of LaTeX code, for exercise #%i (from '%s'), in French (file '%s').\n" % (numexo, urlToGo, name))

print("<green>Succès :)")
# DONE !
