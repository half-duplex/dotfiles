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
        STUFFTOBU="luca eva tron" #nucacdf-web"
        ;;
    *)
        STUFFTOBU="$@"
        ;;
esac

START=$(date +%s)

ARGS="-aXgoplEh --info=progress2"
BUDIR="/mnt/bulk/backups"
PARGS="--exclude-from /home/mal/.bin/backup.exclude.txt --delete"
SSHARGS="-i /home/mal/.ssh/id_rsa"

for butarget in $STUFFTOBU ; do
    echo -n "[Enter] to start $butarget:"
    read junk
    case $butarget in
        luca)
            rsync $ARGS / $BUDIR/luca $PARGS
            echo "Backup from $(date '+%A, %d %B %Y, %T')" >$BUDIR/luca.backupinfo.txt
            ;;
        eva)
            #rsync -4 $ARGS -e "ssh $SSHARGS" root@eva.sec.gd:/ $BUDIR/eva $PARGS
            rsync -4 $ARGS -e "ssh $SSHARGS" root@10.8.0.1:/ $BUDIR/eva $PARGS
            echo "Backup from $(date '+%A, %d %B %Y, %T')" >$BUDIR/eva.backupinfo.txt
            ;;
        tron)
            rsync -4 $ARGS -e "ssh $SSHARGS" root@tron.disruptivelabs.org:/ $BUDIR/tron $PARGS
            echo "Backup from $(date '+%A, %d %B %Y, %T')" >$BUDIR/tron.backupinfo.txt
            ;;
        nucacdf-web)
            rsync $ARGS -e "ssh $SSHARGS" mal@nucacdf.org:/home/mal/ $BUDIR/nucacdf-web
            echo "Backup from $(date '+%A, %d %B %Y, %T')" >$BUDIR/nucacdf-web.backupinfo.txt
            ;;
        *)
            echo "Invalid backup target!"
            ;;
    esac
done

FINISH=$(date +%s)
echo " time: $(( ($FINISH-$START) / 60 )) minutes, $(( ($FINISH-$START) % 60 )) seconds"

df -h $BUDIR


