#!/usr/bin/env python3
#-*- coding: utf8 -*-
"""Produce text from a list of sentences, inspired by https://github.com/jilljenn/markov.py"""

import argparse
import os
import random
from string import ascii_lowercase
from collections import Counter, defaultdict
from lea import Lea


WORD_LIST = '/home/lilian/bin/latin.txt'


def markov(corpus, start, length):
    # Counting occurrences
    next_one = defaultdict(Counter)
    for sentence in corpus:
        words = sentence.split()
        nb_words = len(words)
        for i in range(nb_words - 1):
            next_one[words[i]][words[i + 1]] += 1

    # Initializing states
    states = {}
    for word in next_one:
        states[word] = Lea.fromValFreqsDict(next_one[word])

    # Outputting visited states
    word = start
    words = [word]
    for _ in range(length - 1):
        word = states[word].random()
        words.append(word)
    return(words)


if __name__ == '__main__':
    # Parse cli arguments
    parser = argparse.ArgumentParser(description='Generate a random latin locution.')
    parser.add_argument(
        'demo_type',
        type=str,
        nargs='?',
        default='latin',
        help='A type of demo: "latin", "text", "music" or "word"')
    parser.add_argument(
        'start',
        type=str,
        nargs='?',
        default='None',
        help='A word to start the random latin locution')
    parser.add_argument(
        'length',
        type=int,
        nargs='?',
        default=-1,
        help='Length of the random latin locution')
    args = parser.parse_args()

    proba_title = 0

    # Generating sentences word by word
    if args.demo_type == 'text':
        corpus = [
            'je mange des cerises',
            'je mange des bananes',
            'je conduis des camions',
        ]
        starts = ['je']
        start = random.choice(starts)
        length = 4
    # Generating sentences word by word
    elif args.demo_type == 'latin':
        corpus = open(WORD_LIST).readlines()
        starts = [c.split()[0] for c in corpus]
        start = args.start
        if start is None or start == 'None':
            start = random.choice(starts)
        proba_title = len([1 for s in starts if s.istitle()]) / len(starts)
        length = args.length
        if length <= 0:
            length = random.randint(2, 8)
    # Generating music note by note
    elif args.demo_type == 'music':
        corpus = [
            'e d# e d# e b d c a',  # Lettre à Élise de Beethoven
            'C E g c e g c e C E g c e g c e C D a d f a d f'
        ]  # Bach
        starts = ['e', 'C']
        start = random.choice(starts)
        length = 20
    # Generating words letter by letter
    elif args.demo_type == 'word':
        corpus = [
            ' '.join(list(word)) for word in open(
                os.path.basename(WORD_LIST)).read().splitlines()
        ]
        starts = list(ascii_lowercase)
        start = random.choice(starts)
        length = 12

    # Try 100 times to generate a sentence
    nb_max_trial = 100
    for trial in range(nb_max_trial):
        try:
            words = markov(corpus, start, length)
            if random.random() <= proba_title:
                words[0] = words[0].title()
            print(' '.join(words))
            break
        except KeyError:
            start = random.choice(starts)
            continue
