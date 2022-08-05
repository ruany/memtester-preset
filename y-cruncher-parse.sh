#!/usr/bin/env bash
set -euo pipefail

## Config ##
cores=24
physical_cores=$[cores/2]

## Run ##
buffer=$(mktemp)

$EDITOR "$buffer"

grep -o 'Error(s) encountered on logical core.*' "$buffer"|tr -d 'a-zA-Z.()'|\
while read line; do
    if [ $line -ge $physical_cores ]; then line=$[line-physical_cores]; fi
    echo "$line"
done|sort|uniq -c|sort -rn|awk '{print $2 " " $1}'|column -tN CORE,FAILURES

rm "$buffer"