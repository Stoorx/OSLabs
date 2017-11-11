#!/bin/bash
str1=$1
str2=$2
if [[ "$str1" == "$str2" ]]
then 
	echo "a = b"
else
	echo "a != b"
fi
