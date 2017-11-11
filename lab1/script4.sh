#!/bin/bash
counter=0
tmp=1
until [[ $[tmp%2] == 0 ]]
do
    echo -n "Введите число>"
    read tmp
    counter=$[counter+1]
done
echo $counter
