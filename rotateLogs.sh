#!/bin/env bash

LOG_ROOT=/opt/tomcat7/logs
LOG_BASE_LIST=repo-activity repo-trace-profile repo-slow-profile

LOG_BUCKET=logsweeps.sagebase.org

EC2ID=$(wget -q -O - http://169.254.169.254/latest/meta-data/instance-id)

for LOG_BASE_NAME in $(echo $LOG_BASE_LIST)
do

    for FILE in $(ls $LOG_ROOT/$LOG_BASE_NAME.*.gz)
    do
        s3cmd put $FILE s3://$LOG_BUCKET/$EC2ID/$(basename $FILE)
        if [ $? -eq 0 ]
        then
            rm $FILE
        fi
    done
done
