#!/bin/bash

TAG=$(echo $1 | sed 's|svn/tags/Synapse-||')

git checkout $1 && git tag $TAG && git checkout - && git branch -d $1
