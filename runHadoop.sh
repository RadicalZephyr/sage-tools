#!/usr/bin/env bash

SAGE_DIR=/home/geoff/work/sage

HADOOP_INSTALL=/home/geoff/src/hadoop-0.20.2
HADOOP_OUT_DIR=/home/geoff/work/sage/hadoopout

rm -rf $HADOOP_OUT_DIR

pushd $SAGE_DIR

$HADOOP_INSTALL/bin/hadoop jar $HADOOP_INSTALL/contrib/streaming/hadoop-0.20.2-streaming.jar \
  -input /home/geoff/work/sage/logs/s3/listing.txt \
  -output $HADOOP_OUT_DIR \
  -mapper bin/maplogs.sh \
  -reducer bin/reducelogs.sh \
  -file bin/maplogs.sh \
  -file bin/reducelogs.sh

popd
