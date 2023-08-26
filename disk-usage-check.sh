#!/bin/bash

##########################
#
# This script is used to monitor disk space and sends notification when it exceeds certain level
#
# Requirements: mailutils
#
# Usage: ./disk-usage-check.sh [partition name] [mail] & - by adding ampersand script will run as background proces
#
#########################

DISK=$1
MAIL_TO=$2

if [ $# -ne 2 ];then
    echo "Usage: ./disk-usage-check.sh [partition name] [mail]"
    exit 1
fi

while true; do
    USAGE=$($(which df) | grep $DISK | awk '{print $5}' | sed 's/%//g')
    if [ $USAGE -ge 90 ];then
        echo "Disk $DISK usage is over 90% ||| $(date)" | mail -s "Critical disk usage" $MAIL_TO
        exit 0
    fi
    sleep 60
done