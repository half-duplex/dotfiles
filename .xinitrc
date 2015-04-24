#!/bin/sh

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

nitrogen --restore &

if ! pgrep redshift >/dev/null ; then
    redshift-my &
fi

if ! pgrep x11vnc >/dev/null ; then
    x11vnc -bg & # fork immediately, otherwise awm startup delay
fi

shift
exec awesome $@

