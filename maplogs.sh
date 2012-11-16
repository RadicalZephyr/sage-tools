#!/usr/bin/env bash

while read -r 
do
    NAME=$(echo $(basename $REPLY) | cut -d '/' -f 7 | cut -d '.' -f 1)
    DATE=$(echo $(basename $REPLY) | cut -d '/' -f 7 | cut -d '.' -f 2 | cut -d '-' -f1-3)
    if [ $NAME = "repo-activity" ]
    then
        echo $NAME-$DATE$'\t'$REPLY
    fi
done
