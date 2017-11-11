#!/bin/bash
res=1
mode="+"
echo "Started!"
echo "Result=$res"
(tail -n 0 -f data.txt) |
while true;
do
read LINE;
case $LINE in
	QUIT)
		echo "exit"
		killall tail
		exit
		;;
	"+")
		echo "sum"
		mode="+"
		echo "Enter number"
		;;
	"*")
		echo "mul"
		mode="*"
		echo "Enter number"
	[0-9])
		let "res=res$mode$LINE"
		echo "Result=$res"
		;;
	*)
		echo "ERROR!"
		killall tail
		exit 0
		;;
esac
done
