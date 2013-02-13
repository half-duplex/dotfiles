#!/bin/bash

echo "$1" | socat STDIN UDP:172.16.42.12:12345
#echo "$1" | socat STDIN UDP:localhost:12345

