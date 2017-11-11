#!/bin/bash
echo "" > t
for i in $(ls /proc | grep -E [0-9] | sort -n)
do
if [[ $(cat /proc/$i/status 2>/dev/null | head -n4 | tail -n1 | awk '{print $2}' ) -ne null ]]
then
echo -n "ProcessID= "$(cat /proc/$i/status 2>/dev/null | head -n4 | tail -n1 | awk '{print $2}') >> t
echo -n " : Parent_ProcessID= "$(cat /proc/$i/status 2>/dev/null | head -n5 | tail -n1 | awk '{print $2}') >> t
echo -n " : Average_Sleeping_Time= "$(cat /proc/$i/sched 2>/dev/null | grep "^avg_atom" | awk '{print $3}') >> t
echo "" >> t
fi
done
sort -nt "=" -k3 t 
rm t
