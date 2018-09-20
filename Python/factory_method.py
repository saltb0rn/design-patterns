# !/usr/bin/env python3
# -*- coding: utf-8 -*-
# factory_method.py


from abc import ABC, abstractmethod
from datetime import datetime


class Translator(ABC):

    @abstractmethod
    def load_dictionary(self):
        pass

    @abstractmethod
    def translate_from(self, text, lang):
        pass


class EnglishTranslator(Translator):
    def __init__(self):
        self.creational_time = str(datetime.today())
        self.dict = None
        self.lang = 'en'
        self.load_dictionary()

    def load_dictionary(self):
        if not self.dict:
            self.dict = 'English Dictionary'

    def translate_from(self, text, lang):
        print(('Translating "{text}" from'
               ' {src_lang} to {target_lang}').format(
                   text=text, src_lang=lang, target_lang=self.lang))


class ChineseTranslator(Translator):
    def __init__(self):
        self.creational_time = str(datetime.today())
        self.dict = None
        self.lang = 'ch'
        self.load_dictionary()

    def load_dictionary(self):
        if not self.dict:
            self.dict = 'Chinese Dictionary'

    def translate_from(self, text, lang):
        print(('Translating "{text}" from'
               ' {src_lang} to {target_lang}').format(
                   text=text, src_lang=lang, target_lang=self.lang))


def translator_factory(lang):
    if lang == 'en':
        translator = EnglishTranslator
    elif lang == 'ch':
        translator = ChineseTranslator
    else:
        raise ValueError('The language {} is unavaliable'.format(lang))
    return translator()
