#!/bin/bash -e
# dnssec.sh
# Trevor Bergeron - mallegonian@gmail.com
# Licensed under the GPLv3 or later
#
#   crontab entries:
# 5 2 1 * * /var/named/local/dnssec.sh y # rotate ZSKs
# 5 2 11 * * /var/named/local/dnssec.sh # no rotation
# 5 2 21 * * /var/named/local/dnssec.sh # no rotation

dir="/var/named/local/zones/"
keygen="/usr/sbin/dnssec-keygen"
signzone="/usr/sbin/dnssec-signzone"


keyroll=$1 # "dnssec.sh y" = key rollover (ZSKs only)
cd $dir
zonelist="$(ls | grep db. | grep -v signed | sed -e 's/^db\.//')"
for each in $zonelist ; do
    echo $each
    thiskeyroll=$keyroll
    if [ -z "`ls | grep K$each`" ] ; then
        echo -e "\tGenerating new KSK..."
        sed -e "s/.*INCLUDE K$each.*//g" -i db.$each
        thiskeyroll=y
        KSK=`$keygen -3 -r /dev/urandom -a RSASHA512 -b 4096 -n ZONE -f KSK $each 2>&1 | tail -n 1`
        echo "\$INCLUDE $KSK.key ; KSK" >>db.$each
    fi

    if [ "x$thiskeyroll" == "xy" ] ; then
        echo -e "\tGenerating new ZSK..."
        sed -r -e 's/(^\$INCLUDE K.*\.key ; ZSK) outgoing$/; expired: \1/g' -e 's/\.key ; ZSK$/.key ; ZSK outgoing/g' -i db.$each
        ZSK=`$keygen -3 -r /dev/urandom -a RSASHA512 -b 4096 -n ZONE $each 2>&1 | tail -n 1`
        echo "\$INCLUDE $ZSK.key ; ZSK" >>db.$each
    fi

    $signzone -N unixtime -3 `uuidgen -r | sed -e 's/-//g'` -o $each db.$each
done

/usr/bin/systemctl reload named
