#!/bin/bash
logger "Read file $1"
logger "Save screenshots in $2"

function takeScreenshot() {
	url=$1
	folder=$2
	agent=$3

	# Take screenshot
	phantomjs takeScreenshot.js $1 "$folder" $3


        diffName=`date '+%Y-%m-%d_%H%M'`
        diffName="diff_$diffName.png"

        # Compare screenshot with an older version
        array=($( ls -t "$folder"  | head -2 ))
        if [ ${#array[@]} -gt 1 ];
        then
                diffValue=$( compare -metric MAE "$folder/${array[0]}" "$folder/${array[1]}" $diffName 2>&1 |head -1 |tr -d '.'|cut -f1 -d' ' )
                logger "Compare ${array[0]} with ${array[1]}: Diff is $diffValue"
                if [ $diffValue == "0" ];
                then
                        # Remove newer screenshot
			echo "Delete $folder/${array[0]}"
                        rm "$folder/${array[0]}"
                        rm $diffName
                else
                        mkdir --parents "$folder/diff/"
                        mv $diffName "$folder/diff/$diffName"
                fi
        fi
}


# Use filename as subfolder for the output files
IFS='.' read -ra inputFile <<< $1
type=${inputFile[0]}

# Read input file
while read line; do
    IFS=';' read -ra JOB <<< $line

    # Take mobile and desktop screenshot
    echo "Folder: $2/${JOB[0]}/desktop/$type"
    takeScreenshot ${JOB[1]} "$2/${JOB[0]}/desktop/$type/" DESKTOP
    takeScreenshot ${JOB[1]} "$2/${JOB[0]}/mobile/$type/" MOBILE

done < $1


