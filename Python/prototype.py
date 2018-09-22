#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# prototype.py
import copy


class Prototype:

    def __init__(self):
        self.objects = dict()

    def register(self, identifier, obj):
        self.objects[identifier] = obj

    def unregister(self, identifier):
        if (self.objects[identifier]):
            del self.objects[identifier]

    def clone(self, identifier, **attr):
        found = self.objects.get(identifier)
        if not found:
            raise ValueError('Incorrect object identifier:'
                             '{}'.format(identifier))
        obj = copy.deepcopy(found)
        obj.__dict__.update(attr)
        return obj


class Class4Test:

    def __init__(self, **attr):
        self.__dict__.update(**attr)


obj1 = Class4Test(name='obj1')
obj2 = Class4Test(ins=obj1)
prototype = Prototype()
prototype.register('obj2', obj2)
obj3 = prototype.clone('obj2', name='obj2')
