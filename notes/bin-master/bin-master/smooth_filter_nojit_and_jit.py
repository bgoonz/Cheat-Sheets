#!/usr/bin/env python3
# -*- coding: utf8 -*-

from time import time
import numpy as np
import numba

def smooth_nojit(u, a):
    y = np.zeros_like(u)
    y[0] = (1-a)*u[0]
    for k in range(1, len(u)):
        y[k] = a*y[k-1] + (1-a)*u[k]
    return y


smooth_jit = numba.jit(smooth_nojit)
# <- factor ×100 speed-up!


if __name__ == '__main__':
    print("For 1e6 points...")
    u = np.random.randn(int(1e6), 1)
    a = 0.95
    start = time()
    smooth_nojit(u, a)
    print(f"No jit: {time() - start:.3g} seconds")
    start = time()
    smooth_jit(u, a)
    print(f"With Numba jit: {time() - start:.3g} seconds")
