#!/bin/bash
a=$1
b=$2
c=$3
max=$a
if [ $b > $max ]
then
	max=$b
fi

if [ $c > $max ]
then 
	max=$c
fi
echo $max
