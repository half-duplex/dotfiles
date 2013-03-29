#!/bin/bash

if ps aux | grep nm-applet | grep -v grep >/dev/null ; then
    echo -n
else
    nm-applet --sm-disable &
fi

if ps aux | grep redshift | grep -v grep >/dev/null ; then
    echo -n
else
    redshift-my &
fi

nitrogen --restore &

if ps aux | grep x11vnc | grep -v grep >/dev/null ; then
    echo -n
else
    #x11vnc -6 -alwaysshared -norepeat -usepw -many -remap Control_R-Super_L &
    x11vnc-my
fi

