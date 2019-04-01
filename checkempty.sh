#!/bin/sh

name=$1
if [ -z "$name" ]
then
	echo "\$name is empty"
else
	echo "\$name isn't empty"
	echo $name
fi
