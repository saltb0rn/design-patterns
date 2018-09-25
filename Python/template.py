#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# template.py


def default_style(msg):
    msg = msg.capitalize()
    msg = '-' * 10 + msg + '-' * 10
    return msg


def admire_style(msg):
    msg = msg.upper()
    return '!'.join(msg)


def generate_banner(msg, style=default_style):
    print('-- start of banner --')
    print(style(msg))
    print('-- end of banner --\n\n')


def client():
    print("Default style")
    generate_banner("Happy coding")

    print()

    print("Admire style")
    generate_banner("Happy coding", style=admire_style)


client()
