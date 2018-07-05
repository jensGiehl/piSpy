#!/bin/bash
logger "Read file $1"
logger "Save screenshots in $2"

function takeScreenshot() {
	url=$1
	folder=$2
	agent=$3
	name=$4
	logger "Take screenshot from $url into folder $folder  (Agent=$agent and listname is $name)"

	if [[ ! -e $folder ]]; then
		mkdir -p "$folder"
	fi

	# Take screenshot
	timeout 45s phantomjs takeScreenshot.js $url "$folder" $agent


	# Gen Diffname
        currentDate=`date '+%Y-%m-%d_%H%M'`
        diffName="diff-$type-$agent-$currentDate.png"
        logger "Filename diff: $diffName"

        # Compare screenshot with an older version
        latestFiles=($(ls -t "$folder" | head -2 ))
        if [ ${#latestFiles[@]} -gt 1 ];
        then
		newFile=${latestFiles[0]}
		previousFile=${latestFiles[1]}
                diffValue=$( compare -metric MAE "$folder/$newFile" "$folder/$previousFile" $diffName 2>&1 |head -1 |tr -d '.'|cut -f1 -d' ' )
                logger "Compare $newFile with $previousFile: Diff is $diffValue"
                if [ $diffValue == "0" ];
                then
                        # Remove newer screenshot
			logger "Delete $folder/$newFile"
                        rm "$folder/$newFile"
                        rm $diffName
                else
                        mkdir --parents "$folder/diff/"
                        mv $diffName "$folder/diff/$diffName"
                fi
        fi
}


# Use filename as subfolder for the output files
name="${1##*/}"
name=`echo $name | cut -d'.' -f 1`


# Read input file
while read line; do
    IFS=';' read -ra JOB <<< $line

    # Take mobile and desktop screenshot
    takeScreenshot ${JOB[1]} "$2/${JOB[0]}/desktop/$name/" DESKTOP $type
    takeScreenshot ${JOB[1]} "$2/${JOB[0]}/mobile/$name/" MOBILE $type

done < $1


