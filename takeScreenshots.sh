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
#    phantomjs takeScreenshot.js ${JOB[1]} "$2/${JOB[0]}/mobile/$folder/" MOBILE

	# Remove duplications
	diffName=`date '+%Y-%m-%d_%H%M'`
	diffName="diff_$diffName.png"
	desktopFolder="$2/${JOB[0]}/desktop/$folder/"
	mobileFolder="$2/${JOB[0]}/mobile/$folder/"
	
	array=($( ls -t "$desktopFolder"  | head -2 ))
	if [ ${#array[@]} -gt 1 ];
	then
		diffValue=$( compare -metric MAE "$desktopFolder/${array[0]}" "$desktopFolder/${array[1]}" $diffName 2>&1 |head -1 |tr -d '.'|cut -f1 -d' ' )
		logger "Compare ${array[0]} with ${array[1]}: Diff is $diffValue"
		if [ $diffValue == "0" ];
		then
			echo "Delete $desktopFolder/${array[0]}"
			# Remove newer screenshot
			rm "$desktopFolder/${array[0]}"
			rm $diffName
		else
			mkdir --parents "$desktopFolder/diff/"
			mv $diffName "$desktopFolder/diff/$diffName"
		fi
	fi

done < $1

