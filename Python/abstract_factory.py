#! /usr/bin/env python3
# -*- coding: utf-8 -*-
# abstract_factory.py
from abc import ABCMeta, abstractmethod

# ---------- 抽象 ----------


class CPU(metaclass=ABCMeta):

    def __init__(self, spec):
        self.spec = spec

    @abstractmethod
    def get_cpu_info(self):
        pass


class GPU(metaclass=ABCMeta):

    def __init__(self, spec):
        self.spec = spec

    @abstractmethod
    def get_gpu_info(self):
        pass


class ConsoleFactory(metaclass=ABCMeta):

    @abstractmethod
    def ship_cpu(self):
        pass

    @abstractmethod
    def ship_gpu(self):
        pass


# ---------- 具体 ----------

class IntelCPU(CPU):

    def get_cpu_info(self):
        return "Intel CPU : %s" % self.spec


class AMDCPU(CPU):

    def get_cpu_info(self):
        return "AMD CPU : %s" % self.spec


class NvidiaCPU(CPU):

    def get_cpu_info(self):
        return "Nvidia CPU : %s" % self.spec


class AMDGPU(GPU):

    def get_gpu_info(self):
        return "AMD GPU : %s" % self.spec


class NvidiaGPU(GPU):

    def get_gpu_info(self):
        return "Nvidia GPU : %s" % self.spec


class XBOXFactory(ConsoleFactory):

    def ship_cpu(self):
        if not getattr(self, "cpu", None):
            self.cpu = AMDCPU("")
        return self.cpu

    def ship_gpu(self):
        if not getattr(self, "gpu", None):
            self.gpu = AMDGPU("AMD Radeon GCN (40CU 2560 Cores)")
        return self.gpu


class PlayStationFactory(ConsoleFactory):

    def ship_cpu(self):
        if not getattr(self, "cpu", None):
            self.cpu = AMDCPU("x86-64 AMD Jaguar 8 cores")
        return self.cpu

    def ship_gpu(self):
        if not getattr(self, "gpu", None):
            self.gpu = AMDGPU("AMD Radeon GCN (36U 2304 Cores)")
        return self.gpu


class NintendoSwithFactory(ConsoleFactory):

    def ship_cpu(self):
        if not getattr(self, "cpu", None):
            self.cpu = NvidiaCPU("Cortex A57 4 cores")
        return self.cpu

    def ship_gpu(self):
        if not getattr(self, "gpu", None):
            self.gpu = NvidiaGPU("Tegra X1")
        return self.gpu


# ---------- 客户端 ----------
class Console:
    def __init__(self, cpu, gpu):
        self.cpu = cpu
        self.gpu = gpu

    def get_info(self):
        return dict(cpu=self.cpu, gpu=self.gpu)


def make_console(factory):
    cpu = factory.ship_cpu()
    gpu = factory.ship_gpu()
    return Console(cpu, gpu)


ns = make_console(NintendoSwithFactory())
ns.get_info()
