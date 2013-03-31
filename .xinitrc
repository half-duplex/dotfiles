#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

if [ -f $HOME/.xmodmap ]; then
    /usr/bin/xmodmap $HOME/.xmodmap
fi
if [ -f $HOME/.Xresources ]; then
    xrdb -merge $HOME/.Xresources
fi

DM=$1
if [ -z "$DM" ] ; then
    DM="awm"
fi

case $DM in
awm|awesome)
    exec awesome
    ;;
xfce|xfce4)
    exec startxfce4
    ;;
*)
    echo ".xinitrc: Unrecognized session type, exec anyway"
    exec $@
    ;;
esac

