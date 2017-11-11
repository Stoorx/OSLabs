#!/bin/bash

while true;
do
read LINE
echo $LINE >> data.txt
if [[ "$LINE" == "QUIT" ]]
then
exit 0
fi
done
exit 0

