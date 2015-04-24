#!/bin/bash

DISPLAY=":0"
PATH="$PATH:/usr/bin"

if pgrep redshift >/dev/null ; then
    echo -n
else
    redshift-my &
fi

nitrogen --restore &

if pgrep x11vnc >/dev/null ; then
    echo -n
else
    x11vnc -bg & # fork immediately, otherwise awm startup delay
fi

