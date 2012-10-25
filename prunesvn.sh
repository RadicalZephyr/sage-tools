#!/bin/bash

git branch -r | grep 'upstream/svn/tags/' | grep -v 'rw-' | sed 's|upstream/||' | xargs -r -n1 ../bin/svntogittag.sh

git push --tags rw-upstream

git branch -r | grep 'upstream/svn/tags/' | sed 's|upstream/|:|' | xargs -r -n1 git push rw-upstream

# svn/tags/Synapse-0.6.2
git branch -r | grep 'origin/svn' | sed 's|origin/|:|' | xargs -n1 git push origin
