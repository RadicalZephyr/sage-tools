#!/usr/bin/env bash

processKey () {
    OUTFILE="$1"
    FILESTOMERGE="$2"

    if [ -n "$OUTFILE" -a -n "$FILESTOMERGE" ]
    then
        echo $OUTFILE
        sort -m $FILESTOMERGE > $OUTFILE
        rm $FILESTOMERGE
    fi
}

OUTFILE=''
FILESTOMERGE=''
while read -r KEY FILE
do
    if [ "$KEY" != "$OUTFILE" ]
    then
        processKey "$OUTFILE" "$FILESTOMERGE"
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

# Make sure we process the last key.
processKey "$OUTFILE" "$FILESTOMERGE"
