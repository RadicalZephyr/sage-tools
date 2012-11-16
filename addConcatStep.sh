#!/bin/bash

S3BUCKET=dev2logs.sagebase.org

pushd /home/geoff/work/sage

s3cmd put bin/maplogs.sh s3://$S3BUCKET/bin/
s3cmd put bin/reducelogs.sh s3://$S3BUCKET/bin/

emr-cli/elastic-mapreduce -j $1 --stream --input s3n://$S3BUCKET/dev/listing/ --output s3n://$S3BUCKET/dev/out/listing --mapper s3n://$S3BUCKET/bin/maplogs.sh --reducer s3n://$S3BUCKET/bin/reducelogs.sh --jobconf mapred.reduce.tasks=10

popd
