#!/bin/bash

while true;
do
read LINE
case $LINE in
	"TERM")
		kill -SIGTERM $(cat .pid)
		exit
		;;
	"KILL")
		kill -SIGKILL $(cat .pid)
		exit
		;;
	"QUIT")
		kill -SIGQUIT $(cat .pid)
		exit
		;;
	*)
		:
		;;
esac
done
exit 0
