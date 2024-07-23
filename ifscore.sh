#! /bin/bash
echo -n "Please input a score"
read SCORE
if [ "$SCORE" -lt 60 ]; then
    echo "C"
fi
if [ "$SCORE" -lt 80 -a "$SCORE" -ge 60 ]; then
    echo "B"
fi
if [ "$SCORE" -ge 80 ]; then
    echo "A"
fi