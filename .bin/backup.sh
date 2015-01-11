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

ARGS="-aXEhzAy --info=progress2 --delete --delete-delay --exclude-from /home/mal/.bin/backup.exclude.txt"
BUDIR="/mnt/bulk/backups"
SSHARGS="-i /home/mal/.ssh/id_rsa"

for butarget in $STUFFTOBU ; do
    echo -n "[Enter] to start $butarget:"
    read junk
    case $butarget in
        luca)
            rsync $ARGS / $BUDIR/luca
            echo "Backup from $(date '+%A, %d %B %Y, %T')" >$BUDIR/luca.backupinfo.txt
            ;;
        eva)
            rsync -4 $ARGS -e "ssh $SSHARGS" root@eva.sec.gd:/ $BUDIR/eva
            echo "Backup from $(date '+%A, %d %B %Y, %T')" >$BUDIR/eva.backupinfo.txt
            ;;
        tron)
            rsync -4 $ARGS -e "ssh $SSHARGS" root@tron.disruptivelabs.org:/ $BUDIR/tron
            echo "Backup from $(date '+%A, %d %B %Y, %T')" >$BUDIR/tron.backupinfo.txt
            ;;
        *)
            echo "Invalid backup target!"
            ;;
    esac
done

FINISH=$(date +%s)
echo " time: $(( ($FINISH-$START) / 60 )) minutes, $(( ($FINISH-$START) % 60 )) seconds"

df -h $BUDIR

