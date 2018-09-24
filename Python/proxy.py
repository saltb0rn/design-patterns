#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# proxy.py


class SensitiveInfo:

    def __init__(self):
        self.users = ['nick', 'tom', 'ben', 'mike']

    def read(self):
        print('There are {} users: {}'.format(len(self.users),
                                              ' '.join(self.users)))

    def add(self, user):
        self.users.append(user)
        print('Added user {}'.format(user))


class ProtectiveProxy:

    def __init__(self):
        self.protected = SensitiveInfo()
        self.secret_key = '...././.-../.-../---/--..-- .--/---/.-./.-../-..'

    def read(self):
        self.protocted.read()

    def add(self, user):
        sec = input('what is the secret? your answer: ')
        (
            self.protected.add(user)
            if sec == self.secret_key
            else print("That is so wrong!")
        )


if __name__ == '__main__':
    info = ProtectiveProxy()
    print('1. read list |==| 2. add user |==| 3. quit')
    while 1:
        key = input('choose option: ')
        if key == '1':
            info.read()
        elif key == '2':
            name = input('choose username: ')
            info.add(name)
        elif key == '3':
            break
        else:
            print('unknown option: {}'.format(key))
