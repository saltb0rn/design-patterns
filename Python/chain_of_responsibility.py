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
        self.p1 = Point1()
        self.p2 = Point2()
        self.p3 = Point3()
        self.chain_point()

    def chain_point(self):
        self.p1.chain(self.p2)
        self.p2.chain(self.p3)

    def check_request(self, request):
        self.p1.handle(request)

    def check_requests(self, requests):
        for request in requests:
            self.check_request(request)


def main():
    ckchain = CheckPointChain()
    ckchain.check_requests(range(1, 30, 2))


main()
