#!/bin/bash
for i in a b c d 1 2 3
do 
    echo $i
done





for i in 50 60 70
do 
    echo $i
    if [ "$i" -lt 60 ]; then
        echo "C"
    else
        echo "B"
    fi
done


for i in $(seq 10)
do 
    echo $i
done

for i in $(ls)
do 
    echo $i
done