#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# facade.py


class CPU:

    def jump(self):
        print("Jumping to BOOT address")

    def execute(self):
        print("Startup completed, start to work!")


class Memory:

    def load(self):
        print("Loaded from BOOT address")


class HardDrive:

    def read(self):
        print("Read from BOOT sector")


# ---------- Facade ----------
class Computer:

    def __init__(self):
        self.cpu = CPU()
        self.mem = Memory()
        self.hhd = HardDrive()

    def start(self):
        """隐藏的一系列细节"""
        self.mem.load()
        self.hhd.read()
        self.cpu.jump()
        self.cpu.execute()


# ---------- 用户 ----------

def client():
    pc = Computer()
    pc.start()


client()
