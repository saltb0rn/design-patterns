#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# adapter.py


class Adapter:

    def __init__(self, obj, adapted_methods):
        self.obj = obj
        self.__dict__.update(adapted_methods)

    def __str__(self):
        return str(self.obj)


# ---------- 被适配的类 ----------
class Human:

    def __init__(self, msg):
        self.msg = msg

    def greeting(self):
        print(self.msg)


class Computer:

    def welcome(self):
        print("Welcome to Debian!")


class Google:

    def page_info(self):
        print("Discover the store!")


human_1 = Human("你好!")
human_2 = Human("Hello!")
computer = Computer()
google = Google()


# ---------- 原本的系统 ----------
def greeting(objs):
    for obj in objs:
        obj.greeting()

# ---------- 适配 Computer 和 Google 的实例
computer_adapter = Adapter(computer, dict(greeting=computer.welcome))
google_adapter = Adapter(google, dict(greeting=google.page_info))

greeting([human_1, human_2, computer_adapter, google_adapter])
