#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# command.py
import os


class MV:

    def __init__(self, src, dest):
        self.src = src
        self.dest = dest

    def execute(self):
        self()

    def undo(self):
        os.rename(self.dest, self.src)

    def redo(self):
        self()

    def __call__(self):
        os.rename(self.src, self.dest)


class Client:

    obj = None

    def __new__(cls):
        if not cls.obj:
            cls.obj = super().__new__(cls)
            cls._command_stack = []
        return cls.obj

    def record(self, command):
        self._command_stack.append(command)

    def stack(self):
        return self._command_stack

    def execute_all(self):
        for cmd in self.stack():
            cmd.execute()

    def undo_all(self):
        for cmd in reversed(self.stack()):
            cmd.undo()

    def redo_all(self):
        for cmd in self.stack():
            cmd.execute()


def main():
    client = Client()
    client.record(MV('/home/salt/a.txt', '/home/salt/b.txt'))
    client.record(MV('/home/salt/c.txt', '/home/salt/d.txt'))
    client.execute_all()
    client.undo_all()
    client.redo_all()


main()
