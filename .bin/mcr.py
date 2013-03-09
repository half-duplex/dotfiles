#!/usr/bin/python3
import os
import configparser

class MyConfigParser(configparser.ConfigParser):
    def as_dict(self):
        d = dict(self._sections)
        for k in d:
            d[k] = dict(self._defaults, **d[k])
            d[k].pop('__name__', None)
        return d

mycfgp=MyConfigParser()
mycfgp.read(os.path.expanduser("~")+"/.mcr")
config=mycfgp.as_dict()

print(config)

