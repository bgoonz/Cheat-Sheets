#! /usr/bin/env python3
# -*- coding: utf8 -*-
"""
Hand written implementation of a very naive hash table data structure.

- It supports the same interface as Python default 'dict' data structure.
- O(1) insertion, O(1) read, deletion and write (in average)
- It is not slow! For about 100 values, it is about has fast as 'dict', 10x slower for 1000 values, 100x slower for 10000 values.

About:
- *Date:* 23/09/2017.
- *Author:* Lilian Besson, (C) 2017
- *Licence:* MIT Licence (http://lbesson.mit-license.org).
- *Web*: https://bitbucket.org/lbesson/bin/
"""


def small_hash(x, nb_bits=3):
    """A naive hash function."""
    # return abs(hash(x)) % 2  # test, to check that collisions are well handled
    return abs(hash(x)) % (1 << nb_bits)


NB_BITS = 4
DEFAULT_SIZE = 1 << NB_BITS


class hashtable(object):
    """Manual implementation of a naive hash table.

    - Can only store hashable values.
    - Use single-linked lists to be collision-resistant!
    - Uses a non cryptographic hash function (default `hash`).
    """

    def __init__(self, map_values=None, nb_bits=NB_BITS):
        self._nb_bits = nb_bits
        self._size = 1 << nb_bits
        self._nb = 0
        self._array = [[] for _ in range(self._size)]
        self._keys = []
        # Naive way of inserting
        if map_values is not None:
            for key, value in map_values:
                self.insert(key, value)

    # convenient methods

    def __len__(self):
        return self._nb

    def __str__(self):
        return "{" + ", ".join(["{}: {}".format(kv[0], kv[1]) for kv in self]) + "}"

    __repr__ = __str__

    def insert(self, key, value):
        """Insert a new (key, value) pair in the hash table."""
        if key in self.keys():
            raise ValueError("key = {} is already present in the hash table".format(key))
        self._keys.append(key)
        self._nb += 1
        h = small_hash(key, nb_bits=self._nb_bits)
        if self._nb >= self._size:
            self._double_size()
        self._array[h].append((key, value))

    # internal double method

    def _double_size(self, debug=False):
        """If needed, double the size of the hash table."""
        self._array += [[] for _ in range(self._size)]
        self._nb_bits += 1
        self._size *= 2
        if debug:
            print("Doubling the size of the hash table...\nUsing now {} bits for the addressing, and able to store up to {} values. Currently {} are used.".format(self._nb_bits, self._size, self._nb))  # DEBUG

    # read, write, delete methods

    def read(self, key):
        """Read the value stored with this key."""
        if key not in self.keys():
            raise IndexError
        h = small_hash(key, nb_bits=self._nb_bits)
        cell = self._array[h]
        for (k, v) in cell:
            if k == key:
                return v
        raise IndexError

    __getitem__ = read

    def delete(self, key):
        """Delete the value stored with this key."""
        if key not in self.keys():
            raise IndexError
        h = small_hash(key, nb_bits=self._nb_bits)
        cell = self._array[h]
        for i, (k, _) in enumerate(cell):
            if k == key:
                self._nb -= 1
                del cell[i]
                del self._keys[self._keys.index(k)]
                break
        else:
            raise IndexError

    __delitem__ = delete

    def write(self, key, value):
        """Set the value stored with this key."""
        if key not in self.keys():
            raise IndexError
        h = small_hash(key, nb_bits=self._nb_bits)
        cell = self._array[h]
        for i, (k, _) in enumerate(cell):
            if k == key:
                cell[i] = (key, value)
                break
        else:
            raise IndexError

    # dictionary like methods

    def keys(self):
        """Return iterator of keys."""
        return self._keys

    def items(self):
        """Return iterator of items."""
        return (self[k] for k in self.keys())

    def __contains__(self, key):
        return key in self.keys()

    def __setitem__(self, key, value):
        if key in self.keys():
            self.write(key, value)
        else:
            self.insert(key, value)

    def update(self, iterator):
        if hasattr(iterator, 'keys') and callable(iterator.keys):
            for k in iterator:
                self[k] = iterator[k]
        else:
            for k, v in iterator:
                self[k] = v

    # Methods to make it an iterator

    def list(self):
        r = []
        for c in self._array:
            if len(c) > 0:
                r += c
        return r

    def __iter__(self):
        for c in self._array:
            if len(c) > 0:
                for kv in c:
                    yield kv


# --- Testing

def test():
    print("Creating empty hash table ...")
    H = hashtable()
    print(H)

    print("Inserting i**2 for i = 0..9 ...")
    for i in range(10):
        H.insert(i, i**2)
    print(H)

    print("Reading i**2 for i = 0..9 ...")
    for i in range(10):
        assert H[i] == H.read(i)
        print("H[{}] = {} = H.read({}) = {}".format(i, H[i], i, H.read(i)))
    print(H)

    print("Writing in place i**3 ...")
    for i in range(10):
        H.write(i, i**3)
    print(H)

    print("Writing in place i**4 ...")
    for i in range(10):
        H[i] = i**4
    print(H)

    print("Deleting even values ...")
    for i in range(0, 10, 2):
        H.delete(i)
    print(H)

    print("Inserting a new value ...")
    H.insert(20, 8000)
    print(H)

    print("Deleting this new value ...")
    del H[20]
    print(H)

    print("len(H) =", len(H))

    print("list(H) =", list(H))

    print("Updating from a dictionary ...")
    H.update({k: k**2 for k in range(10, 15)})
    print(H)

    print("Updating from a list ...")
    H.update([(k, k**2) for k in range(15, 20)])
    print(H)

if __name__ == '__main__':
    test()
