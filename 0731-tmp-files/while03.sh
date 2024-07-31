#! /bin/bash
PRE_SET_NUM=8
echo "Input a number between 1 and 10"
while  read GUESS
do
    if [[ "$GUESS" -eq "$PRE_SET_NUM" ]]; then
        echo "You get the right number"
        exit
    else
        echo "Wrong, try again"
    fi
done