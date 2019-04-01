#!/bin/bash

val=`expr 2 + 2`
echo Result : $val

a=10
b=5
echo "a + b = `expr $a + $b`"
echo "a - b = `expr $a - $b`"
echo "a * b = `expr $a \* $b`"
echo "a / b = `expr $a / $b`"
echo "a % b = `expr $a % $b`"
#a=$b #phep gan
echo "a == b = `expr $a == $b`"
echo "a != b = `expr $a != $b`"

