#! /usr/bin/env python3
# -*- coding: utf-8; mode: python -*-
""" Check if an NIRPP ("numéro de sécurité sociale", in France) is correct.

Reference:
https://fr.wikipedia.org/wiki/Num%C3%A9ro_de_s%C3%A9curit%C3%A9_sociale_en_France#Signification_des_chiffres_du_NIR


- *Date:* Tuesday 01 November 2016.
- *Author:* Lilian Besson, © 2016.
- *Licence:* MIT Licence (http://lbesson.mit-license.org).
"""

from __future__ import print_function, division  # Python 2 compatibility if needed

import subprocess

length_checksum = 2


def l_to_c(l):
    try:
        return str(int(l))
    except ValueError:
        return str(10 + ord(l.upper()) - ord('A'))


def check_nirpp(nirpp, length_checksum=length_checksum):
    print("\nChecking the NIRPP number '%s' ..." % nirpp)
    ib = nirpp.replace(' ', '')
    checksum = int(ib[-length_checksum:])
    ib = ib[:-length_checksum]
    print("  Of length", len(ib))
    num_nirpp = int(''.join(l_to_c(l) for l in ib))
    print("  Of sum num_nirpp =", num_nirpp)
    print("  Of check sum to 97 =", (97 - (num_nirpp % 97)))
    print("  And expected checksum was", checksum)
    check = (97 - (num_nirpp % 97)) == checksum
    if check:
        print("OK '%s' seems to be a valid NIRPP number." % nirpp)
    else:
        print("[WARNING] NOT OK '%s' seems to NOT be a valid NIRPP number!" % nirpp)
    return check


information_nirpp = {
    (0, 1): {
        "meaning": "sexe",
        "mapping": {
            "1": "homme",
            "2": "femme",
            "3": "personne étrangère de sexe masculin en cours d'immatriculation en France",
            "4": "personne étrangère de sexe féminin en cours d'immatriculation en France"
        }
    },
    (1, 2): {
        "meaning": "deux derniers chiffres de l'année de naissance",
        "mapping": {
            # DONE nothing to do for this information
        }
    },
    (3, 2): {
        "meaning": "mois de naissance",
        "mapping": {
            "01": "janvier",
            "02": "février",
            "03": "mars",
            "04": "avril",
            "05": "mai",
            "06": "juin",
            "07": "juillet",
            "08": "août",
            "09": "septembre",
            "10": "octobre",
            "11": "novembre",
            "12": "décembre",
        }
    },
    # Only case A : TODO implement case B and C
    (5, 2): {
        "meaning": "département de naissance métropolitain",
        "mapping": {  # Cf. http://www.insee.fr/fr/methodes/nomenclatures/cog/documentation.asp
            "01": "Ain",
            "02": "Aisne",
            "03": "Allier",
            "04": "Alpes-de-Haute-Provence",
            "05": "Hautes-Alpes",
            "06": "Alpes-Maritimes",
            "07": "Ardèche",
            "08": "Ardennes",
            "09": "Ariège",
            "10": "Aube",
            "11": "Aude",
            "12": "Aveyron",
            "13": "Bouches-du-Rhône",
            "14": "Calvados",
            "15": "Cantal",
            "16": "Charente",
            "17": "Charente-Maritime",
            "18": "Cher",
            "19": "Corrèze",
            "2A": "Corse-du-Sud",
            "2B": "Haute-Corse",
            "21": "Côte-d'Or",
            "22": "Côtes-d'Armor",
            "23": "Creuse",
            "24": "Dordogne",
            "25": "Doubs",
            "26": "Drôme",
            "27": "Eure",
            "28": "Eure-et-Loir",
            "29": "Finistère",
            "30": "Gard",
            "31": "Haute-Garonne",
            "32": "Gers",
            "33": "Gironde",
            "34": "Hérault",
            "35": "Ille-et-Vilaine",
            "36": "Indre",
            "37": "Indre-et-Loire",
            "38": "Isère",
            "39": "Jura",
            "40": "Landes",
            "41": "Loir-et-Cher",
            "42": "Loire",
            "43": "Haute-Loire",
            "44": "Loire-Atlantique",
            "45": "Loiret",
            "46": "Lot",
            "47": "Lot-et-Garonne",
            "48": "Lozère",
            "49": "Maine-et-Loire",
            "50": "Manche",
            "51": "Marne",
            "52": "Haute-Marne",
            "53": "Mayenne",
            "54": "Meurthe-et-Moselle",
            "55": "Meuse",
            "56": "Morbihan",
            "57": "Moselle",
            "58": "Nièvre",
            "59": "Nord",
            "60": "Oise",
            "61": "Orne",
            "62": "Pas-de-Calais",
            "63": "Puy-de-Dôme",
            "64": "Pyrénées-Atlantiques",
            "65": "Hautes-Pyrénées",
            "66": "Pyrénées-Orientales",
            "67": "Bas-Rhin",
            "68": "Haut-Rhin",
            "69": "Rhône",
            "70": "Haute-Saône",
            "71": "Saône-et-Loire",
            "72": "Sarthe",
            "73": "Savoie",
            "74": "Haute-Savoie",
            "75": "Paris",
            "76": "Seine-Maritime",
            "77": "Seine-et-Marne",
            "78": "Yvelines",
            "79": "Deux-Sèvres",
            "80": "Somme",
            "81": "Tarn",
            "82": "Tarn-et-Garonne",
            "83": "Var",
            "84": "Vaucluse",
            "85": "Vendée",
            "86": "Vienne",
            "87": "Haute-Vienne",
            "88": "Vosges",
            "89": "Yonne",
            "90": "Territoire de Belfort",
            "91": "Essonne",
            "92": "Hauts-de-Seine",
            "93": "Seine-Saint-Denis",
            "94": "Val-de-Marne",
            "95": "Val-d'Oise",
            # TODO support these too
            "971": "Guadeloupe",
            "972": "Martinique",
            "973": "Guyane",
            "974": "La Réunion",
            "975": "Saint-Pierre-et-Miquelon",
            "976": "Mayotte",
            "977": "Saint-Barthélemy",
            "978": "Saint-Martin",
            "984": "Terres australes et antarctiques françaises",
            "986": "Wallis-et-Futuna",
            "987": "Polynésie française",
            "988": "Nouvelle-Calédonie",
            "989": "Île de Clipperton"
        }
    },
    (7, 3): {
        "meaning": "code officiel de la commune de naissance",
        "mapping": {  # TODO
        }
    },
    (10, 3): {
        "meaning": "numéro d’ordre de la naissance dans le mois et la commune (ou le pays)",
        "mapping": {
            # DONE nothing to do for this information
        }
    }

}


def pprint_nirpp(nirpp, length_checksum=length_checksum):
    print("\nDisplaying information contained in the NIRPP number '%s' ..." % nirpp)
    ib = nirpp.replace(' ', '')
    ib = ib[:-length_checksum]
    # Printing
    for (i, l) in sorted(information_nirpp):
        n = nirpp[i: i + l]
        info = information_nirpp[(i, l)]
        if n in info["mapping"]:
            explain = "\"{}\"".format(info["mapping"][n])
        else:
            explain = n
        # For towns, durty hack to extract the town from the INSEE database
        if i == 7:
            try:
                # 1st try
                # https://docs.python.org/3/library/subprocess.html#replacing-shell-pipeline
                # args = [
                #     "grep", "--", "',{},{},'".format(
                #         nirpp[5: 5 + 2],
                #         nirpp[7: 7 + 3]
                #     ),
                #     "comsimp2016.txt",
                # ]
                # print("Executing subprocess.Popen to \"{}\"".format(' '.join(args)))
                # p1 = subprocess.Popen(args, stdout=subprocess.PIPE)
                # args = [
                #     "cut", "-d,", "-f10"
                # ]
                # print("Executing subprocess.Popen to \"{}\"".format(' '.join(args)))
                # p2 = subprocess.Popen(args, stdin=p1.stdout, stdout=subprocess.PIPE)
                # p1.stdout.close()  # Allow p1 to receive a SIGPIPE if p2 exits
                # explain = p2.communicate()[0]
                # print("explain =", explain)

                # 2nd try
                args = [
                    "grep", "--", "',{},{},'".format(
                        nirpp[5: 5 + 2],
                        nirpp[7: 7 + 3]
                    ),
                    "/home/lilian/bin/comsimp2016.txt",
                    "|", "cut", "-d,", "-f10"
                ]
                # print("Executing subprocess.check_output to \"{}\"".format(' '.join(args)))
                explain = subprocess.check_output(' '.join(args), shell=True)
                explain = explain[:-1].decode()
                # print("explain =", explain)
                explain = "{} (code {})".format(explain, nirpp[7: 7 + 3])
            except Exception:
                explain = n
        print("- Number '{}' (index {}:{}) means:\n\t\"{}\" : \t{}".format(
            n, i, i + l, info["meaning"], explain)
        )


def main(args):
    try:
        if not args:
            check_nirpp('HAHA LOL YOU THOUGH I WILL LET A REAL NIRPP IN MY SCRIPT')
        else:
            for nirpp in args:
                if check_nirpp(nirpp):
                    pprint_nirpp(nirpp)
        return 0
    except Exception as e:
        print(e)
        return 1


if __name__ == '__main__':
    from sys import argv, exit
    exit(main(argv[1:]))

# End of check_nirpp.py
