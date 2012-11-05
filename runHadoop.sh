#!/usr/bin/env bash

SAGE_DIR=/home/geoff/work/sage

HADOOP_INSTALL=/home/geoff/src/hadoop-0.20.2
HADOOP_OUT_DIR=/home/geoff/work/sage/hadoopout

rm -rf $HADOOP_OUT_DIR

pushd $SAGE_DIR

$HADOOP_INSTALL/bin/hadoop jar $HADOOP_INSTALL/contrib/streaming/hadoop-0.20.2-streaming.jar \
  -D stream.num.map.output.key.fields=2 \
  -D mapred.text.key.partitioner.options=-k1,1 \
  -D mapred.output.key.comparator.class=org.apache.hadoop.mapred.lib.KeyFieldBasedComparator \
  -D mapred.text.key.comparator.options="-k1n -k2n" \
  -input /home/geoff/work/sage/logs/repo/ \
  -output $HADOOP_OUT_DIR \
  -mapper bin/maplogs.sh \
  -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner \
  -reducer bin/reducelogs.sh \
  -file bin/maplogs.sh \
  -file bin/reducelogs.sh

popd
