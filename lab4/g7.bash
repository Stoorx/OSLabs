#!/bin/bash
read pid < .PID
while true
do
read inp
case $inp in
	"+")
		kill -USR1 $pid
	;;
	"*")
		kill -USR2 $pid
	;;
	"TERM")
		kill $pid
		exit 0
	;;
	*)
		continue
	;;
esac
done
