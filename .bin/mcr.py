#!/usr/bin/python3
import os
import ConfigParser

configparser = ConfigParser.ConfigParser()

config=[]
with open(os.path.expanduser("~")+"/.mcr","r") as conffile:
    for line in conffile:
        config.append(line[:-1])

for line in config:
    if len(line)<1 or line[0]=="#" or line[0]==";": # comment
        continue
    tup=line.split("=",1)
    print("tup:",tup)

