#!/bin/bash

if ps aux | grep redshift | grep -v grep >/dev/null ; then
    echo -n
else
    redshift-my &
fi

nitrogen --restore &

if ps aux | grep x11vnc | grep -v grep >/dev/null ; then
    echo -n
else
    x11vnc -bg
fi

