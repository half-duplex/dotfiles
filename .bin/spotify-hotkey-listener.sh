#!/bin/bash

socat UDP-RECV:12345 STDOUT | while read ri ; do
    case $ri in
        "play")
            spotify-hotkey.sh play
            ;;
        "next")
            spotify-hotkey.sh next
            ;;
        "prev")
            spotify-hotkey.sh prev
            ;;
        "volup")
            volctl up
            ;;
        "voldown")
            volctl down
            ;;
        "volmute")
            volctl mute
            ;;
        *)
            echo "Bad command!"
            ;;
    esac
done

