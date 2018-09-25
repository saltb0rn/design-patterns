#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# decorator.py
from functools import wraps

# 装饰类


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


## 第一种装饰类的手段

@getattribute_logger
class WrappedKls:
    def __init__(self, x):
        self.x = x

    def spam(self):
        print(self.x)


a = WrappedKls(42)
a.x
a.spam()


## 第二种装饰类的手段


class WrappedKls2:
    def __init__(self, x):
        self.x = x

    def spam(self):
        print(self.x)


class Kls2(WrappedKls2):
    def __init__(self, x):
        print("Initializing ...")
        super().__init__(x)

    def spam(self):
        print("Calling spam")
        super().spam()


# 装饰函数
def decorator(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        print("Decorating ...")
        res = func(*args, **kwargs)
        print("Exiting ...")
        return res
    return wrapper


@decorator
def wrapped_func(x, y):
    return x + y


wrapped_func(1, 2)
