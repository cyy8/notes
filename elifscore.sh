#! /bin/bash
echo -n "Please input a score"
read SCORE
if [ "$SCORE" -lt 60 ]; then
    echo "C"
elif [ "$SCORE" -lt 80 -a "$SCORE" -ge 60 ]; then
    echo "B"
else 
    echo "A"
fi