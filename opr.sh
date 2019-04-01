#!/bin/bash

a=10
b=5
if [ $a == $b ]
then
	echo '$a va $b bang nhau'
else
	echo '$a va $b khac nhau'
fi

str1="HELLO"
str2="Hello"
if [[ $str1 > $str2 ]]
then 
	echo $str1
	echo $str2
	echo 'Chuoi 1 > hon chuoi 2'
fi

#$str3
if [[ -z$str3 ]]
then
	echo 'Chuoi 3 rong'
fi

if [[ -n$str1 ]]
then
	echo 'Chuoi 1 khong rong'
fi
