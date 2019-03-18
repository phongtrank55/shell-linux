#!/bin/sh

var1="abcxc"
var2=10
echo $var2
readonly var1 # hang so
var1='222'
echo $var1 la hang so
unset var2 # xoa bien. khong xoa dc bien readonly
echo cung nhau tung tang
