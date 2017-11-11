#!/bin/bash

exitfunc{
	echo "SIGTERM recieved. Exit the process."
	exit 0
}
quitHandle{
	echo "SIGQUIT recieved. Exit the process."
	exit 0
}


trap exitfunc SIGTERM
trap quitHandle SIGQUIT

a=0
while true;
do
	let a=$a+1
	echo $a
done
exit 0
