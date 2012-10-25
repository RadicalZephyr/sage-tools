#!/bin/bash

UPDATE=$1
INSTALL_DIR=$2

JAVAS="java javac javaws"
echo $JAVAS
for JAVA in $(echo $JAVAS)
do
    if [ $UPDATE = --install ]
    then
        echo "Installing " $JAVA
        sudo update-alternatives --install /usr/bin/$JAVA $JAVA $INSTALL_DIR/bin/$JAVA 1
    elif [ $UPDATE = --config ]
    then
        echo "Configuring " $JAVA
        sudo update-alternatives --config $JAVA
    elif [ $UPDATE = --remove ]
    then
        echo "Removing " $JAVA
        sudo update-alternatives --remove $JAVA $INSTALL_DIR/bin/$JAVA
    fi
done
