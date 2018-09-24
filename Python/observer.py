#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# observer.py


class Publisher:

    def __init__(self):
        self.subscribers = []

    def add(self, subscriber):
        if subscriber not in self.subscribers:
            self.subscribers.append(subscriber)
        else:
            print("Failed to add: {}".format(subscriber))

    def remove(self, subscriber):
        try:
            self.subscribers.remove(subscriber)
        except ValueError:
            print("Failed to remove: {}".format(subscriber))

    def notify(self):
        [o.update(self) for o in self.subscribers]


class ConcretePublisher(Publisher):

    def __init__(self, name=''):
        super().__init__()
        self.name = name
        self._data = 0

    @property
    def data(self):
        return self._data

    @data.setter
    def data(self, value):
        self._data = value
        self.notify()


class NormalSubscriber:

    def update(self, publisher):
        print("NormalSubscriber: Publisher: \"%s\" update data: \"%s\"."
              % (publisher.name, publisher.data))


class VIPSubscriber:

    def update(self, publisher):
        print('VIPSubscriber: Publisher: \"%s\" update data: \"%s\".'
              % (publisher.name, publisher.data))


def main():
    normal_channel = ConcretePublisher('Normal Channel')
    vip_channel = ConcretePublisher('VIP Channel')
    normal_subscriber = NormalSubscriber()
    vip_subscriber = VIPSubscriber()
    normal_channel.add(normal_subscriber)
    normal_channel.add(vip_subscriber)
    vip_channel.add(vip_subscriber)
    normal_channel.data = "This is the new update for everyone"
    vip_channel.data = "This is the new update for vip users"


main()
