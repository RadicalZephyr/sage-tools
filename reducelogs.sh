#!/usr/bin/env bash

OUTFILE=''
FILESTOMERGE=''
while read -r KEY FILE
do
    if [ "$KEY" != "$OUTFILE" ]
    then
        if [ -n "$OUTFILE" -a -n "$FILESTOMERGE" ]
        then
            sort -m $FILESTOMERGE > $OUTFILE
            rm $FILESTOMERGE
        fi
        OUTFILE=$KEY
        FILESTOMERGE=''
    fi

    # file must be sorted to do a merge
    TMP=$(mktemp)
    gunzip -c > $TMP $FILE

    if sort -c $TMP
    then
        FILESTOMERGE=$FILESTOMERGE" $TMP"
    fi        
done

if [ -n "$OUTFILE" ]
then
    sort -m $FILESTOMERGE > $OUTFILE
fi
