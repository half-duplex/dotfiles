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
    xmodmap $HOME/.xmodmap
fi
if [ -f $HOME/.Xresources ]; then
    xrdb -merge $HOME/.Xresources
fi

if [ -d "$HOME/.bin" ] ; then
    export PATH="$HOME/.bin:$PATH"
fi

DM=$1
if [ -z "$DM" ] ; then
    DM="awm"
fi

case $DM in
awm|awesome)
    shift
    exec awesome $@
    ;;
i3|i3wm)
    shift
    exec i3 $@
    ;;
xfce|xfce4)
    shift
    exec startxfce4 $@
    ;;
*)
    echo ".xinitrc: Unrecognized session type, exec anyway"
    exec $@
    ;;
esac

