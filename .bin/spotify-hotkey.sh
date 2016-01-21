#!/bin/sh

x="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player"

case $1 in
   "play")
       ${x}.PlayPause
       ;;
   "next")
       ${x}.Next
       ;;
   "prev")
       ${x}.Previous
       ;;
   *)
       echo "Usage: $0 play|next|prev"
       exit 1
        ;;
esac
exit 0
