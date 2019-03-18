#!/bin/sh


sentence="I don't need arrays because I can use delimited strings"
for word in $sentence
do
  printf '%s\n' "$word"
done
