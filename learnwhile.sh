#! /bin/bash
while read line
do 
    echo $line | wc -c
    echo
done < learnif.sh

cat learnif.sh | while read line
do 
    echo $line | wc -c
    echo
done 
