#!/usr/bin/env bash

echoerr() {
    echo "$@" 1>&2
}

processKey () {
    OUTFILE="$1"
    FILESTOMERGE="$2"
    OUTDIR="$3"

    echoerr "Doing post-processing of $OUTFILE, outputting to $OUTDIR"

    if [ -n "$OUTFILE" -a -n "$FILESTOMERGE" ]
    then
        sort -m $FILESTOMERGE > out/${OUTFILE}.log
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
    echoerr "Key: $KEY"
    echoerr "File: $FILE"
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
    fi        
done

# Make sure we process the last key.
processKey "$OUTFILE" "$FILESTOMERGE" "$OUTDIR"
