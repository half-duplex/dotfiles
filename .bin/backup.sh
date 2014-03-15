#!/bin/bash

if [ "`whoami`" != "root" ] ; then
    echo "Need elevation!"
    exec sudo $0 $@
fi

case $@ in
    "")
        echo "Specify a machine to back up, or \"all\"."
        exit
        ;;
    all)
        STUFFTOBU="luca milo eva nucacdf-web"
        ;;
    *)
        STUFFTOBU="$@"
        ;;
esac

START=$(date +%s)

ARGS="-aXgoplEh --info=progress2"
BUDIR="/media/bulk1/backups"
PARGS="--exclude-from /home/mal/.bin/backup.exclude.txt --delete"
SSHARGS="-i /home/mal/.ssh/id_rsa"

for butarget in $STUFFTOBU ; do
    echo -n "[Enter] to start $butarget:"
    read junk
    case $butarget in
        luca)
            rsync $ARGS / $BUDIR/luca $PARGS
            echo "Backup from $(date '+%A, %d %B %Y, %T')" >$BUDIR/backupinfo.txt
            ;;
        milo)
            rsync $ARGS -e "ssh $SSHARGS" root@milo:/ $BUDIR/milo $PARGS
            echo "Backup from $(date '+%A, %d %B %Y, %T')" >$BUDIR/backupinfo.txt
            ;;
        eva)
            rsync $ARGS -e "ssh $SSHARGS" root@eva:/ $BUDIR/eva $PARGS
            echo "Backup from $(date '+%A, %d %B %Y, %T')" >$BUDIR/backupinfo.txt
            ;;
        nucacdf-web)
            rsync $ARGS -e "ssh $SSHARGS" mal@nucacdf.org:/home/mal/ $BUDIR/nucacdf-web
            echo "Backup from $(date '+%A, %d %B %Y, %T')" >$BUDIR/backupinfo.txt
            ;;
        *)
            echo "Invalid backup target!"
            ;;
    esac
done

FINISH=$(date +%s)
echo " time: $(( ($FINISH-$START) / 60 )) minutes, $(( ($FINISH-$START) % 60 )) seconds"

df -h $BUDIR


