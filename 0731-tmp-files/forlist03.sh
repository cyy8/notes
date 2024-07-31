#! /bin/bash
sum=0
for VAR in `seq 1 100`
#for VAR in $(seq 1 100)   用$()替换``
do
    let "sum+=VAR"     #啥意思
done
echo "Total: $sum"

sum=0
for VAR in `seq 1 2 100`
#for VAR in $(seq 1 2 100)   用$()替换``
do
    let "sum+=VAR"     #啥意思
done
echo "Total: $sum"


sum=0
for VAR in `seq 2 2 100`
#for VAR in $(seq 2 2 100)   用$()替换``
do
    let "sum+=VAR"     #啥意思
done
echo "Total: $sum"