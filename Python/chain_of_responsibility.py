#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# chain_of_responsibility.py


class CheckPoint:

    def chain(self, successor):
        self.successor = successor


class Point1(CheckPoint):

    def handle(self, request):
        if request > 0 and request <= 10:
            print("request %s in handler1" % request)
        else:
            self.successor.handle(request)


class Point2(CheckPoint):

    def handle(self, request):
        if request > 10 and request <= 20:
            print("request %s in handler2" % request)
        else:
            self.successor.handle(request)


class Point3(CheckPoint):

    def handle(self, request):
        if request > 20 and request <= 30:
            print("request %s in handler3" % request)


class CheckPointChain:

    def __init__(self):
        self.h1 = Point1()
        self.h2 = Point2()
        self.h3 = Point3()
        self.chain_point()

    def chain_point(self):
        self.h1.chain(self.h2)
        self.h2.chain(self.h3)

    def check_request(self, request):
        self.h1.handle(request)

    def check_requests(self, requests):
        for request in requests:
            self.h1.handle(request)


def main():
    ckchain = CheckPointChain()
    ckchain.check_requests(range(1, 30, 2))


main()
