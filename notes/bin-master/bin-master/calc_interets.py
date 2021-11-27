#! /usr/bin/env python2
# -*- coding: utf-8 -*-
""" Petit script Python pour afficher des graphiques de ses comptes et calculer des intérêts.

- *Date:* 03 January 2019.
- *Author:* Lilian Besson, © 2016-18.
- *Licence:* MIT Licence (http://lbesson.mit-license.org).
"""

from __future__ import print_function, division  # Python 2 compatibility if needed
import sys
import time
import pickle
import matplotlib.pyplot as plt
import seaborn as sns

if sys.version_info.major == 3:
    try:
        import codecs
        sys.stdout = codecs.getwriter('utf8')(sys.stdout)
    except Exception as e:
        print("Failed to force utf8 for stdout...")

try:
    try:
        from ansicolortags import printc as print
    except ImportError as e:
        print("ansicolortags not available, using regular print.")
        print("  You can install it with : 'pip install ansicolortags' (or sudo pip)...")
        raise e
except ImportError:
    try:
        from ANSIColors import printc as print
    except ImportError:
        print("ANSIColors not available, using regular print.")
        print("  You can install it with : 'pip install ANSIColors-balises' (or sudo pip)...")


# Valeurs EMPIRIQUES des taux d'intérêts.
taux2020 = {'CCP' : 0.00,
            'LA'  : 0.73,
            'LEP' : 1.25,  # XXX I don't own a LEP anymore
            'LJ'  : 1.65,  # XXX I don't own a LJ anymore
            'PEA' : 0.00,  # XXX I don't own a PEA anymore
            'PEL' : 2.36,
            'CCP2': 0.00,
            }

path_comptes = "/home/lilian/comptes.pickle"

print("<yellow>Calcul des intérêts, <white>script <u>calc_interets.py<U>:")
try:
    print("Lecture des comptes via le fichier <u>'{}'<U>...".format(path_comptes))
    with open(path_comptes, 'r') as f:
        comptes = pickle.load(f)
except:
    print("Echec de la lecture. Le script va utiliser des valeurs par defaut : 2000.00 dans chaque compte (pour tester).")
    comptes = {'CCP': 2000.00,
               'LA': 2000.00,
               'LEP': 2000.00,
               'LJ': 2000.00,
               'PEA': 2000.00,
               'PEL': 2000.00,
               'CCP2': 2000.00,
               }


type_comptes = list(comptes.keys())


def maximizeWindow():
    """ Experimental function to try to maximize a plot.

    - Tries as well as possible to maximize the figure.
    - Cf. https://stackoverflow.com/q/12439588/
    """
    try:
        figManager = plt.get_current_fig_manager()
        figManager.window.showMaximized()
    except:
        try:
            figManager.frame.Maximize(True)
        except:
            try:
                figManager.window.state('zoomed')  # works fine on Windows!
            except:
                try:
                    figManager.full_screen_toggle()
                except:
                    print("Unable to maximize window...")


# FIXED use a clever color palette, eg http://seaborn.pydata.org/api.html#color-palettes
sns.set(context="talk", style="darkgrid", palette="hls", font="sans-serif", font_scale=1.4)


def palette(nb):
    """ Use a smart palette from seaborn, for nb different things to plot.

    - Ref: http://seaborn.pydata.org/generated/seaborn.hls_palette.html#seaborn.hls_palette
    """
    return sns.hls_palette(nb + 1)[:nb]


def calc_interets(comptes, taux=taux2020):
    """ Calcule une estimation de mes intérêts."""
    interet_fin_annee = sum(comptes[k] * taux[k] / 100.0 for k in type_comptes)
    for k in type_comptes:
        print("Pour mon <blue>compte {:>4}<white>, avec <magenta>{:>10,.2f} €<white>, et un <cyan<taux à <u>{:>4,.2f}%<U><white> {} <green>intérêt ~= {:>6.2f} €<white>.".format(k.upper(), comptes[k], taux[k], '→', comptes[k] * taux[k] / 100.0))
    print("<green>Intérêt estimé pour 2016 : {:.2f} €.<white>".format(interet_fin_annee))
    print("<red>Attention<white> : les vrais intérêts sont calculés toutes les quinzaines, mon estimation n'est pas précise !")
    return interet_fin_annee


def main(comptes, taux=taux2020):
    """ Affiche un beau diagramme camembert montrant la répartition de ses économies. """
    argenttotal = sum(comptes.values())
    interets = sum(round(comptes[k] * taux[k] / 100.0, 3) for k in type_comptes)
    print("Affichage d'un diagrame camembert en cours...")
    valeurs = list(comptes.values())
    print("Valeurs du diagrame : <black>{}<white>".format(valeurs))
    etiquettes = []
    legendes = []
    for k in type_comptes:
        etiquettes.append(u'{} : {} € (à {}% $\\rightarrow$ {} €)'.format(k, comptes[k], taux[k], round(comptes[k] * taux[k] / 100.0, 2)))
        legendes.append(u'{:6} (taux {:5}%)'.format(k, taux[k]))
    print("Étiquettes du diagrame : <black>{}<white>".format(etiquettes))
    explode = [0.05] * len(valeurs)  # Explode the pie chart
    colors = palette(len(valeurs))

    plt.pie(valeurs, labels=etiquettes, explode=explode, colors=colors, labeldistance=1.05, startangle=135)
    plt.legend(legendes, loc='lower right')

    mydate = time.strftime('%d %b %Y', time.localtime())
    # FIXME FUCKING hack because Matplotlib apparently fails to handles utf-8 correctly here...
    mydate2 = mydate.replace('û', 'u').replace('é', 'e')
    mytitle = "Mes comptes (le {}). Total = {:.2f} -> Interets = {:.2f} euros ?".format(mydate2, argenttotal, interets)
    print("Using title: <magenta>{}<white>".format(mytitle))
    mytitle = u"Mes comptes (le {}). Total = {:.2f} € $\\rightarrow$ intérêts = {:.2f} € ?".format(mydate, argenttotal, interets)

    plt.title(mytitle)
    plt.axis('equal')

    maximizeWindow()
    year  = time.strftime('%Y', time.localtime())
    month = time.strftime('%m', time.localtime())
    day   = time.strftime('%d', time.localtime())
    outfile = '/home/lilian/Public/argent_{}-{}_{}.png'.format(day, month, year)

    print("Sauvegarde de ce graphique vers {} en cours...".format(outfile))
    plt.savefig(outfile)
    plt.show()
    try:
        plt.close('all')
        return 0
    except:
        return 1


if __name__ == '__main__':
    print("Commence...")
    calc_interets(comptes=comptes)
    ret = main(comptes=comptes)
    print("Terminé !")
    sys.exit(ret)

# End of calc_interets.py
