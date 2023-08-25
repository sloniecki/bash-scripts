#!/bin/bash
######################################
#
#
# This script shows your repositories which were updated in chosen period of time "set to 1 day back"
#
# Usage: provide your github token as input
#
#
######################################

TOKEN=$1
TEMPFILE=$(mktemp /tmp/fileXXX.txt)
DATE=$(date --date='-1 day' -u --iso-8601=ns | sed s/+00:00/Z/ | sed s/,/./)

if [ -z "$TOKEN" ];then
    echo "Usage: $0 [your github token]"
    exit 1
fi

curl -L \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $TOKEN" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/user/repos?since=:$DATE | grep -E '\"name\":|\"size\":' -A 5 > $TEMPFILE
if [ -z "$TEMPFILE" ];then
    echo "No repositories" > $TEMPFILE
fi

cat $TEMPFILE