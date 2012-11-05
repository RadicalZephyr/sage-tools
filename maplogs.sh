#!/usr/bin/env bash

while read -r 
do
    DATE=$(echo $(basename $REPLY) | cut -d '.' -f 2 | cut -d '-' -f 1-3)
    NAME=$(echo $(basename $REPLY) | cut -d '.' -f 1 | cut --complement -c1-8)
    echo $NAME-$DATE$'\t'$REPLY
done
