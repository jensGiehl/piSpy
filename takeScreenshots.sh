#!/bin/bash
logger "Read file $1"
logger "Save screenshots in $2"

# Use filename as subfolder for the output files
IFS='.' read -ra inputFile <<< $1
folder=${inputFile[0]}

# Read input file 
while read line; do
    IFS=';' read -ra JOB <<< $line

    # Take mobile and desktop screenshot
    phantomjs takeScreenshot.js ${JOB[1]} "$2/${JOB[0]}/desktop/$folder/" DESKTOP
    phantomjs takeScreenshot.js ${JOB[1]} "$2/${JOB[0]}/mobile/$folder/" MOBILE
done < $1
