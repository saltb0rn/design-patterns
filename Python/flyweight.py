#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# flyweight.py


import weakref
from enum import Enum


EnemyType = Enum('EnemyType', (
    'shotgun '
    'pistol '
    'rpg '
    'knife'))


class Scene:

    def __init__(self):
        self.enemies = dict()
        self.enemy_counter = 0
        self.load_resource()

    def load_resource(self):
        print("Loading resources ...")

    def add_enemy(self, type):
        enemy_tpl = EnemyTemplate(type)
        enemy = Enemy(enemy_tpl)
        self.enemies[self.enemy_counter] = enemy
        self.enemy_counter += 1
        return self.enemy_counter - 1

    def get_enemy(self, enemy_counter):
        return self.enemies.get(enemy_counter, None)

    def remove_enemy(self, enemy_counter):
        enemy = self.enemies.get(enemy_counter, None)
        if enemy:
            del self.enemies[enemy_counter]


class EnemyTemplate:

    # cache = dict()
    cache = weakref.WeakValueDictionary()

    def __new__(cls, type):
        obj = cls.cache.get(type, None)
        if not obj:
            obj = super().__new__(cls)
            cls.cache[type] = obj
            obj.type = type
        return obj


class Enemy:

    def __init__(self, enemy_tpl):
        self.enemy_tpl = enemy_tpl
        self.hp = 100
        self.armor = 0

    def get_damage(self, damage):
        remained_armor = self.armor - damage
        if remained_armor >= 0:
            self.armor = remained_armor
        else:
            self.hp += remained_armor
        return self.hp

    def buy_armor(self):
        self.armor = 100


def start_game():
    scene = Scene()
    eid1 = scene.add_enemy(EnemyType.shotgun)
    scene.get_enemy(eid1).get_damage(4)
    scene.remove_enemy(eid1)


start_game()
