#!/bin/bash
str=''
tmpstr=''
until [[ $tmpstr == 'q' ]]
do   
	str=$str' '$tmpstr
	echo -n "Введите строку>"
	read tmpstr
done
echo $str
