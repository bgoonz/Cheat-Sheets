#! /usr/bin/env python3
# -*- coding: utf-8; mode: python -*-
""" Calcule les frais de mission.

- *Date:* lundi 3 avril 2017.
- *Author:* Lilian Besson, (C) 2017.
- *Licence:* MIT Licence (http://lbesson.mit-license.org).
"""

from __future__ import print_function  # Python 2 compatibility if needed


# Constantes
repas = 15.25
hotel = 150
taxeSejour = 0  # 1.65
metro = 1.5


def main(nbJour=3, nbRepas=None, trains=None, nbNuit=None, totalHotel=None):
    """ Calcule et affiche les détails des frais de mission.

    Par exemple :
    >>> trains = {
           "Rennes > Lille": (44.00, "14/12/16"),
           "Lille > Paris ": (25.50, "16/12/16"),
           "Paris > Rennes": (35.00, "03/01/17"),
       }
    >>> main(nbJour=3, trains=trains)
    ...
    """
    print("Calcul des frais de mission pour", nbJour, "jours de mission ...")
    total = 0
    # Repas
    print("\n- Pour les repas :")
    if nbRepas is None:
        nbRepas = 2 * nbJour
        print("   2 repas par jour, pour", nbJour, "jours, soit", nbRepas, "repas.")
    totalRepas = repas * nbRepas
    print("  ", repas, "€ par repas, soit", totalRepas, "€ pour", nbRepas, "repas.")
    total += totalRepas

    # Hôtel
    if totalHotel:
        print("\n- Pour l'hôtel, un total de", totalHotel, "€.")
    else:
        print("\n- Pour l'hôtel : déjà réglé avant, normalement. Sinon, max", hotel, "€ par nuit.")
    if nbNuit is None:
        nbNuit = nbJour - 1
        print("  ", nbJour, "jours sur place, soit", nbNuit, "nuits d'hôtel (par défaut)")

    # Taxe de séjour
    print("\n- Taxe de séjour :")
    totalTaxeSejour = taxeSejour * nbNuit
    print("  ", taxeSejour, "€ par nuit, soit", totalTaxeSejour, "€ pour ces", nbNuit, "nuits.")
    total += totalTaxeSejour

    # Déplacements sur place
    print("\n- Métro :")
    totalMetro = 2 * metro * nbJour
    print("  ", metro, "€ par trajet, soit", totalMetro, "€ pour ces", nbJour, "jours sur place")
    total += totalMetro

    # Train
    print("\n- Train :")
    if trains is None:
        print("   Déjà réglé avant, normalement.")
    else:
        print("   Trajets :")
        totalTrain = 0
        for (trajet, (prix, date)) in trains.items():
            print("   -", trajet, "le", date, "à couté", prix, "€")
            totalTrain += prix
        print("   Soit", totalTrain, "€ pour ces", len(trains), "trajets en train.")
        total += totalTrain

    print("==> Soit un total de", total, "€ à me faire rembourser.")
    return total


if __name__ == '__main__':
    # Mission #4 en mars 2017.
    trains = None  # Payé par l'INRIA
    main(nbJour=11, trains=trains, nbRepas=11, totalHotel=0)

    # TODO prochaines missions !

# End of fraisMission.py
