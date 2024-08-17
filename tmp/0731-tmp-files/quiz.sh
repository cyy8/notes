#!/bin/bash

for i in $(ls)
do
    #echo $i 
    wc -l $i | awk '{print $2","$1}'
done  | sort -r -t "," -k 2 -n