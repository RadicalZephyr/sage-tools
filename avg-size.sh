#!/bin/bash

find ./ -name '*.gz' -type f | xargs -n1 -r wc -c | cut -d' ' -f1 | awk '{t+=$0;l++}END{print t/l;print l}'

find ./ -name '*.gz' -type f | xargs -n1 -r ./wc-gun | cut -d' ' -f1 | awk '{t+=$0;l++}END{print t/l;print l}'
