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

