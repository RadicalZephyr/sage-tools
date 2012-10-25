#!/bin/bash

LOGNAME=$1
PREFIX=$2

for NAME in $(ls $LOGNAME.*)
do
    mv $NAME $PREFIX-$NAME
done
