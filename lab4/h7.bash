#!/bin/bash
SigTerm()
{
	echo "SIGTERM recieved. Exit the process."
	exit 0
}
Usr1()
{
	let accum=$accum+2
}
Usr2()
{
	let accum=$accum*2
}
echo $$ > .PID
accum=1
trap 'SigTerm' SIGTERM
trap 'Usr1' USR1
trap 'Usr2' USR2

while true
do
sleep 1
echo $accum
done
