#!/bin/sh
echo nonempty:
cat $@ | sed -z "s/\n\n/\n/g" | wc -l
echo total:
cat $@ | wc -l
