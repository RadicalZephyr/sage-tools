#!/bin/bash

source ./setupEc2.sh

TEMP=$(mktemp)

ec2-run-instances -k PlatformKeyPairEast -g sg-ca7bf0a3 -t t1.micro -z us-east-1a ami-1624987f > $TEMP

cat $TEMP
INSTANCE_ID=$(tail -n+2 $TEMP | head -n1 | cut -f 2)

ec2-attach-volume vol-263d125a -i $INSTANCE_ID -d /dev/sdg

rm $TEMP
