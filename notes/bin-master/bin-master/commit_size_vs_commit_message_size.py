#! /usr/bin/env python2
# -*- coding: utf-8; mode: python -*-
""" Plot the relationship between commit size and commit message size.

- *Date:* 26/02/2015.
- *Author:* Erik Bernhardsson (http://erikbern.com/2015/02/26/the-relationship-between-commit-size-and-commit-message-size/).
- *Link:* https://gist.github.com/erikbern/0f347c8d789402a09f2e
"""

from __future__ import print_function, division  # Python 2 compatibility if needed

import subprocess
import numpy
import matplotlib.pyplot as plt


def read_groups(data):
    buf = []
    for line in data:
        buf.append(line)
        if line.find('changed') != -1 and buf:
            yield buf
            buf = []


def main(url):
    command = 'git log --no-color --shortstat --log-size --format=oneline --no-merges'.split()
    data = subprocess.check_output(command).split('\n')


    xs, ys, msgs, commits = [], [], [], []
    for group in read_groups(data):
        if len(group) != 3: continue

        commit = group[0].split()[0]
        log_size = int(group[0].split()[-1])
        msg = group[1]
        change_size = sum(map(int, group[2].split()[3::2]))

        if log_size > 0 and change_size > 0:
            xs.append(change_size)
            ys.append(log_size)
            msgs.append(msg)
            commits.append(commit)

    fig, ax = plt.subplots()
    ax.set_xscale('log')
    ax.set_yscale('log')
    ax.set_xlabel('Size of commit (added + deleted lines)')
    ax.set_ylabel('Size of commit message')
    ax.scatter(xs, ys)

    xs_pixels, ys_pixels = ax.transData.transform(numpy.vstack([xs, ys]).T).T
    img_height = fig.get_figheight() * fig.dpi

    f = open('/home/lilian/Public/commit_size_vs_commit_message_size.html', 'w')
    f.write('<img src="commit_size_vs_commit_message_size.png" usemap="#points"/>')
    f.write('<map name="points">')
    for x_pixel, y_pixel, msg, commit in zip(xs_pixels, ys_pixels, msgs, commits):
        f.write('<area shape="circle" coords="%d,%d,5" href="https://%s/commit/%s" title="%s">' % (x_pixel, img_height-y_pixel, url, commit, msg.replace('"', '')))
    f.write('</map>')
    f.close()

    fig.savefig('/home/lilian/Public/commit_size_vs_commit_message_size.png', dpi=fig.dpi)


if __name__ == '__main__':
    # main("bitbucket.org/lbesson/bin")
    # main("bitbucket.org/lbesson/web-sphinx")
    # main("bitbucket.org/lbesson/lbesson.bitbucket.org")
    main("github.com/sphinx-doc/sphinx")

# End of commit_size_vs_commit_message_size.py
