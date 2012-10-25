#!/bin/bash

DEV=geoff

echo "drop database "dev$DEV"; create database "dev$DEV" ;" | mysql -u root dev$DEV
echo "Database cleaned"

if [ $? -eq 0 ]
then
    mvn clean install
    END=$?

    if [ $END -eq 0 ]
    then
        notify-send -t 5000 'Compilation succeeded'
        beep
    else
        notify-send -t 5000 'Compilation failed'
    fi
else
    echo 'Wrong password (or something like that...)'
fi

exit $END
