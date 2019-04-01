#!/bin/bash

function f1()
{
	echo 'f1() executed'
}

function f2()
{
	echo "Hello $1"
	return 3
}

f1 
f2 pt
echo "The previous function has return value of $?"
