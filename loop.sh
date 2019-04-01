#!/bin/bash

numbers=(19 34 44)
echo "Length ${#numbers[@]}"

sum=0
for num in ${numbers[@]}
do
	sum=$[sum+num]
	echo $num
done

echo "Sum is $sum"
