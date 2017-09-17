#!/bin/bash
# example call: ./sendMail.sh 'myFolder/myFile_*'
if [ $# -eq 1 ]
then
  diffName="diff.png"
  array=($( ls -t $1  | head -2 ))
  diffValue=$( compare -metric MAE ${array[0]} ${array[1]} $diffName 2>&1 |tr -d '.'|cut -f1 -d' ' )
  logger "Compare ${array[0]} with ${array[1]}: Diff is $diffValue"
fi

