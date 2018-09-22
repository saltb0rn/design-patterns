#! /usr/bin/env python3
# -*- coding: utf-8 -*-
# builder.py
from abc import ABCMeta, abstractmethod


class Director:
    def __init__(self, builder=None):
        self.builder = builder

    def construct_building(self):
        if self.builder:
            self.builder.new_building()
            self.builder.build_floor()
            self.builder.build_window()
            self.builder.decorate()
            self.builder.clean_up()
        else:
            print("no builder works for you.")

    def get_building(self):
        return self.builder.building


class Builder(metaclass=ABCMeta):

    building = None

    @abstractmethod
    def new_building(self):
        pass

    @abstractmethod
    def build_floor(self):
        pass

    @abstractmethod
    def build_window(self):
        pass

    @abstractmethod
    def decorate(self):
        pass

    @abstractmethod
    def clean_up(self):
        pass


class Building:

    floor = None
    window = None
    style = None
    time = None


class CottageBuilder(Builder):

    def __init__(self):
        self.floor = "One"
        self.window = "Small"
        self.style = "Classical"
        self.time = "2 days"

    def new_building(self):
        if not self.building:
            print("prepare to build")
            self.building = Building()

    def build_floor(self):
        print("building floor ... for 2 days")
        self.building.floor = self.floor

    def build_window(self):
        print("building window ... for 3 days")
        self.building.window = self.window

    def decorate(self):
        print("decorating for ... 5 days")
        self.building.style = self.floor

    def clean_up(self):
        print("It will take us %s to clean up" % self.time)


director = Director(CottageBuilder())
director.construct_building()
director.get_building()
