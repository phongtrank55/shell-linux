#!/bin/bash

#name[0]="Zara"
#name[1]="Qadir"
#name[2]="abc"

name=("zara" "avc" "qadir")
#set -a name "vxc" "ass" 
#declare -a name="zxx" "sss";
#echo ${name[0]};
echo "First Index: ${name[0]} "
echo "Second Index: ${name[1]}"
echo "Length ${#name[@]}"

echo "First Method: ${name[*]}"
echo "Second Method: ${name[@]}"
