#! /usr/bin/env python3
# -*- coding: utf-8 -*-
""" Command line script to use DeepL translator service.

Requirement: https://github.com/EmilioK97/pydeepl

WARNING: not available, the DeepL API is now only for paying users.
See https://github.com/EmilioK97/pydeepl/issues/6 and https://www.deepl.com/api.html.

- *Date:* 11 December 2017.
- *Author:* Lilian Besson, © 2017.
- *Licence:* MIT Licence (http://lbesson.mit-license.org).
"""

from __future__ import print_function, division  # Python 2 compatibility if needed

import sys

try:
    from pydeepl import translate
except ImportError:
    print("Unable to import 'pydeepl', please install it with 'pip install pydeepl'.")
    print("More details at 'https://github.com/EmilioK97/pydeepl'.")

try:
    try:
        from ansicolortags import printc
    except ImportError:
        print("Optional dependancy (ansicolortags) is not available, using regular print function.")
        print("  You can install it with : 'pip install ansicolortags' (or sudo pip)...")
        from ANSIColors import printc
except ImportError:
    print("Optional dependancy (ANSIColors) is not available, using regular print function.")
    print("  You can install it with : 'pip install ANSIColors-balises' (or sudo pip)...")

    def printc(*a, **kw):
        """ Fake function printc.

        ansicolortags or ANSIColors are not installed...
        Install ansicolortags from pypi (with 'pip install ansicolortags')
        """
        print(*a, **kw)

FROM_LANGUAGE = 'EN'
TO_LANGUAGE = 'FR'


def main(argv, to_language=TO_LANGUAGE, from_language=FROM_LANGUAGE):
    """ Main function. Use the arguments of the command line (sys.argv). """
    # TODO use docopt to handle the command line arguments! Cf. http://docopt.org/
    # TODO can docopt handle a cli documentation with ansicolortags tags in it? Cf. http://ansicolortags.rtfd.io/
    # Manual handing of the command line arguments
    if "-h" in argv or "--help" in argv:
        printc("""
<green>deepl.py<white> --help|-h | -f file | [--from LANG] [--to LANG] text

A simple Python script translate a text from a language to another language, using DeepL translator (https://www.deepl.com/translator).

<u>Examples:<U>
<black>$ deepl.py --help<white>
Print this help message!

<black>$ deepl.py -f test.txt<white>
Translate this text file.

<black>$ deepl.py "I like using command line to translate my text."<white>
J'aime utiliser la ligne de commande pour traduire mon texte.

<black>$ deepl.py --to ES "I like using command line to translate my text."<white>
Me gusta usar la línea de comandos para traducir mi texto.

<magenta>Copyleft 2017 Lilian Besson (License MIT)<white>
<b>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.<reset><white>
""")
        return 0

    if "--to" in argv:
        try:
            i = argv.index("--to")
            to_language = argv[i + 1]
            del argv[i], argv[i]
            # printc("<green>Using destination language {}<reset>...".format(to_language))
        except Exception as e:
            print(e)
            printc("<red>Ignored exception, using default destination language {}...<reset>".format(to_language))

    if "--from" in argv:
        try:
            i = argv.index("--from")
            from_language = argv[i + 1]
            del argv[i], argv[i]
            # printc("<green>Using destination language {}<reset>...".format(from_language))
        except Exception as e:
            print(e)
            printc("<red>Ignored exception, using default source language {}...<reset>".format(from_language))

    if "-f" in argv:
        try:
            with open(argv[argv.index("-f") + 1], 'r') as filename:
                text = "".join(filename.readlines())[:-1]
        except Exception as e:
            print(e)
            printc("<red>Trying to use the rest of the arguments to send the text message...<white>")
            text = "".join(argv)
    else:
        if argv:
            # Text
            if isinstance(argv, list):
                text = "".join(argv)
            elif isinstance(argv, str):
                text = argv
            else:
                printc("<Warning>argv seems to be of unknown type (not list, not str, but {}) ...".format(type(argv)))
                text = argv
            text = text.replace("\\n", "\n")
            # Durty hack to have true new lines in the message
        else:
            text = "I like using command line to translate my text."

    # print("text = '{}'".format(text))  # DEBUG
    results = []
    for t in text.splitlines():
        if t.isspace() or len(t) == 0:
            results.append(t)
        else:
            results.append(translate(t, to_lang=to_language, from_lang=from_language))
    result = "\n".join(results)
    print(result)
    return result


if __name__ == '__main__':
    main(sys.argv[1:])
