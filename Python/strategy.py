#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# strategy.py


def pairs(seq):
    n = len(seq)
    for i in range(n):
        yield seq[i], seq[(i + 1) % n]


def all_unique_sort(s):
    sorted_s = sorted(s)
    for c1, c2 in pairs(sorted_s):
        if c1 == c2:
            return False
    return True


def all_unique_set(s):
    return len(s) == len(set(s))


def all_unique(s, strategy):
    return strategy(s)


def main():
    strategies = {"1": all_unique_sort, "2": all_unique_set}
    while True:
        choose = input(
            "Choose your strategy : [1] Sort and pair [2] Use a set\n")
        strategy = strategies.get(choose, None)
        if strategy:
            res = all_unique(input("Insert word\n"), strategy)
            print(res)
        else:
            break


main()
