#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# decorator.py


def getattribute_logger(cls):
    orig_getattribute = cls.__getattribute__

    def new_getattribute(self, name):
        attribute = orig_getattribute(self, name)
        if callable(attribute):
            print("Calling", name)
        else:
            print("Getting attribute", name)
        return attribute

    cls.__getattribute__ = new_getattribute
    return cls


@getattribute_logger
class WrappedKls:
    def __init__(self, x):
        self.x = x

    def spam(self):
        pass


a = WrappedKls(42)
a.x
a.spam()
