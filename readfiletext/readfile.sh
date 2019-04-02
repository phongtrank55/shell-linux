#!/bin/bash

pathfile="i3nput.txt"
if [ ! -f $pathfile ] 
then
	echo 'khong ton tai'
	exit
fi


echo 'Read from file'
while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "Text read from file: $line"
	configs=( "${configs[@]}" "$line" )
done < "$pathfile"

echo 'Read from array'
for item in ${configs[@]}
do
	echo $item
done
