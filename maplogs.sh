#!/usr/bin/env bash

while read -r date time rest
do
    echo ${date}$'\t'${time}$'\t'$date $time $rest
done
