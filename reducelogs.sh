#!/usr/bin/env bash

processKey () {
    OUTFILE="$1"
    FILESTOMERGE="$2"
    OUTDIR="$3"

    if [ -n "$OUTFILE" -a -n "$FILESTOMERGE" ]
    then
        sort -o out/${OUTFILE}.log -m $FILESTOMERGE
        #hadoop fs -cp $OUTFILE $OUTDIR/
        #echo $OUTDIR/$(basename $OUTFILE)
        echo $OUTFILE
        rm $FILESTOMERGE
    fi
}

OUTDIR="s3n://dev2logs.sagebase.org/dev/concatenated"

OUTFILE=''
FILESTOMERGE=''
while read -r KEY FILE
do
    if [ "$KEY" != "$OUTFILE" ]
    then
        processKey "$OUTFILE" "$FILESTOMERGE" "$OUTDIR"
        OUTFILE=$KEY
        FILESTOMERGE=''
    fi

    # file must be sorted to do a merge
    TMP=$(mktemp)
    #hadoop fs -cat $FILE | gzip -cd > $TMP
    cat $FILE | gzip -cd > $TMP

    if sort -c $TMP
    then
        FILESTOMERGE=$FILESTOMERGE" $TMP"
    else
        sort -o $TMP $TMP
        FILESTOMERGE=$FILESTOMERGE" $TMP"
    fi        
done

# Make sure we process the last key.
processKey "$OUTFILE" "$FILESTOMERGE" "$OUTDIR"
