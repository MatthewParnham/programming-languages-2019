#!/usr/local/bin/bash
for filename in /test/*.lc; do
    ./LambdaNat-exe "$filename"
done
