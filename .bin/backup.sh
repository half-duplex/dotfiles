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
        STUFFTOBU="luca milo elliot mc-home mc-mc dream dream-sql" #maya =(
        ;;
    *)
        STUFFTOBU="$@"
        ;;
esac

START=$(date +%s)

ARGS="-aXgoplE" # --stats" # --progress"
BUDIR="/media/bulk1/backups"
PARGS="--exclude-from /home/mal/.bin/backup.exclude.txt --delete"

for butarget in $STUFFTOBU ; do
    echo -n "[Enter] to start $butarget:"
    read junk
    case $butarget in
        luca)
            time rsync $ARGS / $BUDIR/luca $PARGS
            ;;
        milo)
            time rsync $ARGS -e ssh root@milo:/ $BUDIR/milo $PARGS
            ;;
        elliot)
            time rsync $ARGS -e ssh root@elliot:/ $BUDIR/elliot $PARGS
            ;;
        minecraft-home|mc-home)
            time rsync $ARGS -e ssh minecraft@mc.bck.me:/opt/minecraft/ $BUDIR/minecraft/home --exclude={minemod/*,backups/*}
            ;;
        minecraft-mc|mc-mc)
            time rsync $ARGS -e ssh minecraft@mc.bck.me:/opt/minecraft/backups/`date +%Y%m%d-`* $BUDIR/minecraft/minemod
            ;;
        dream)
            time rsync $ARGS -e ssh mallegonian@dream:/home/mallegonian/ $BUDIR/dream
            ;;
        dream-sql)
            mysqldump --all-databases -h mysql.blackcatstudios.org -u mallegonian -p >$BUDIR/dream-$START.sql
            ;;
        *)
            echo "Invalid backup target!"
            ;;
    esac
done

FINISH=$(date +%s)
echo " time: $(( ($FINISH-$START) / 60 )) minutes, $(( ($FINISH-$START) % 60 )) seconds"

df -h $BUDIR

#touch $1/"Backup from $(date '+%A, %d %B %Y, %T')"

