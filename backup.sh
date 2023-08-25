#!/bin/bash

#################################
#
# This scrip uses rsync to create backup on another server 
#
# Usage: backup.sh [source directory] [destination directory] [username@ip]
#
#################################

DATE=$(date +%Y-%m-%d)

RSYNC_OPTIONS="-avb --backup-dir $2/$DATE --delete "


if [ $# -ne 3 ];then
    echo "Usage: backup.sh [source directory] [destination directory] [username@ip]"
    exit 1
fi

if ! which rsync > /dev/null 2>&1; then
    echo "Please install rsync"
    exit 2
fi

$(which rsync) $RSYNC_OPTIONS $1 $3:/$2/current


